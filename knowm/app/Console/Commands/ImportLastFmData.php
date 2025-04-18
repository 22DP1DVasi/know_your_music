<?php

namespace App\Console\Commands;

use App\Models\Artist;
use App\Models\Genre;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use App\Services\LastFmService;

class ImportLastFmData extends Command
{
    protected $signature = 'lastfm:import {artist : The artist name to import} {--limit=10 : Limit of top albums to process}';
    protected $description = 'Import artist data from Last.fm';
    protected $lastFmService;

    public function __construct(LastFmService $lastFmService)
    {
        parent::__construct();
        $this->lastFmService = $lastFmService;
    }

    public function handle()
    {
        $artistName = $this->argument('artist');
        $limit = (int)$this->option('limit');

        $this->info("Starting import for artist: {$artistName}");

        // First try with exact name
        $artist = $this->importArtist($artistName);

        if (!$artist) {
            $this->error("Artist not found on Last.fm after multiple attempts");
            return;
        }

        $this->importTopAlbums($artist, $limit);

        $this->info("Import completed successfully!");
    }

    protected function importArtist(string $artistName): ?Artist
    {
        $this->info("Trying with artist name: {$artistName}");

        $response = Http::get('http://ws.audioscrobbler.com/2.0/', [
            'method' => 'artist.getinfo',
            'artist' => $artistName,
            'api_key' => env('LASTFM_API_KEY'),
            'format' => 'json',
            'autocorrect' => 1,
        ]);

        $data = $response->json();

        if ($response->failed() || isset($data['error'])) {
            $this->warn("Failed with name '{$artistName}': " . ($data['message'] ?? 'Unknown error'));
            return null;
        }

        $artistData = $data['artist'];
        $correctName = $artistData['name'];

        if (strtolower($correctName) !== strtolower($artistName)) {
            $this->info("Artist name autocorrected from '{$artistName}' to '{$correctName}'");
        }

        $artist = Artist::updateOrCreate(
            ['name' => $correctName],
            [
                'biography' => $this->cleanBio($artistData['bio']['content'] ?? null),
            ]
        );

        // Import artist tags separately as they might be more comprehensive
        $artistTags = $this->lastFmService->getArtistTags($correctName);
        if ($artistTags) {
            $this->importGenres($artistTags, $artist);
        }
        // Also import tags from getinfo if they exist
        elseif (isset($artistData['tags']['tag'])) {
            $this->importGenres($artistData['tags']['tag'], $artist);
        }

        return $artist;
    }

    protected function importTopAlbums(Artist $artist, int $limit)
    {
        $this->info("Fetching top {$limit} albums for {$artist->name}");

        $response = Http::get('http://ws.audioscrobbler.com/2.0/', [
            'method' => 'artist.gettopalbums',
            'artist' => $artist->name, // Use the corrected name
            'api_key' => env('LASTFM_API_KEY'),
            'format' => 'json',
            'limit' => $limit,
        ]);

        $data = $response->json();

        if ($response->failed() || empty($data['topalbums']['album'])) {
            $this->error("No top albums found: " . ($data['message'] ?? 'Unknown error'));
            return;
        }

        $this->info("Found " . count($data['topalbums']['album']) . " albums");

        foreach ($data['topalbums']['album'] as $album) {
            $this->processAlbum($album, $artist);
            sleep(1); // Rate limiting
        }
    }

    protected function processAlbum(array $albumData, Artist $artist)
    {
        $albumName = $albumData['name'];
        $this->info("Processing album: {$albumName}");

        $release = Release::where('title', $albumName)
            ->whereHas('artists', fn($q) => $q->where('artist_id', $artist->id))
            ->first();

        if (!$release) {
            $this->warn("No matching release in database: {$albumName}");
            return;
        }

        // Get album info first
        $albumInfo = $this->getAlbumInfo($artist->name, $albumName);

        if ($albumInfo) {
            if (empty($release->description) && isset($albumInfo['wiki']['content'])) {
                $release->description = $this->cleanBio($albumInfo['wiki']['content']);
                $release->save();
                $this->info("Updated album description");
            }

            if (isset($albumInfo['tags']['tag'])) {
                $this->importGenres($albumInfo['tags']['tag'], $release);
            }
        }

        // Process each track in the release
        $this->processAlbumTracks($release, $artist);
    }

    protected function processAlbumTracks(Release $release, Artist $artist)
    {
        $this->info("Processing tracks for release: {$release->title}");

        foreach ($release->tracks as $track) {
            $this->processTrack($track, $artist);
            sleep(1); // Be kind to Last.fm API
        }
    }

    protected function processTrack(Track $track, Artist $artist)
    {
        // Skip if track already has a description
        if (!empty($track->description)) {
            $this->info("Track '{$track->title}' already has description, skipping");
            return;
        }

        $trackInfo = $this->getTrackInfo($artist->name, $track->title);

        if (!$trackInfo || empty($trackInfo['wiki']['content'])) {
            $this->warn("No track info found for '{$track->title}'");
            return;
        }

        $track->description = $this->cleanBio($trackInfo['wiki']['content']);
        $track->save();
        $this->info("Updated description for track '{$track->title}'");

        // Import track genres if available
        if (isset($trackInfo['toptags']['tag'])) {
            $this->importGenres($trackInfo['toptags']['tag'], $track);
        }
    }

    protected function getTrackInfo(string $artistName, string $trackName): ?array
    {
        $response = Http::get('http://ws.audioscrobbler.com/2.0/', [
            'method' => 'track.getinfo',
            'artist' => $artistName,
            'track' => $trackName,
            'api_key' => env('LASTFM_API_KEY'),
            'format' => 'json',
            'autocorrect' => 1,
        ]);

        if ($response->failed() || isset($response->json()['error'])) {
            $this->warn("Track info error for '{$trackName}': " . ($response->json()['message'] ?? 'Unknown error'));
            return null;
        }

        return $response->json()['track'] ?? null;
    }

    protected function getAlbumInfo(string $artistName, string $albumName): ?array
    {
        $response = Http::get('http://ws.audioscrobbler.com/2.0/', [
            'method' => 'album.getinfo',
            'artist' => $artistName,
            'album' => $albumName,
            'api_key' => env('LASTFM_API_KEY'),
            'format' => 'json',
        ]);

        return $response->successful() ? $response->json()['album'] ?? null : null;
    }

    protected function importGenres(array $tags, $model)
    {
        foreach ($tags as $tag) {
            $tagName = $tag['name'];

            // Skip tags that are just years (4-digit numbers)
            if (preg_match('/^\d{4}$/', $tagName)) {
                $this->info("Skipping year-based tag: {$tagName}");
                continue;
            }

            // First check if genre exists without creating it
            $genre = Genre::where('name', $tagName)->first();

            if (!$genre) {
                // Genre doesn't exist - fetch info and create
                $tagInfo = $this->getTagInfo($tagName);

                $genre = Genre::create([
                    'name' => $tagName,
                    'description' => $this->cleanBio($tagInfo['wiki']['content'] ?? null),
                ]);

                $this->info("Created new genre: {$tagName}");
            }

            // Attach to model
            $model->genres()->syncWithoutDetaching([$genre->id]);
        }
    }

    protected function getTagInfo(string $tagName): array
    {
        $response = Http::get('http://ws.audioscrobbler.com/2.0/', [
            'method' => 'tag.getinfo',
            'tag' => $tagName,
            'api_key' => env('LASTFM_API_KEY'),
            'format' => 'json',
        ]);

        if ($response->failed() || isset($response->json()['error'])) {
            $this->warn("Failed to fetch tag info for {$tagName}");
            return ['wiki' => ['content' => null]];
        }

        return $response->json()['tag'] ?? ['wiki' => ['content' => null]];
    }

    protected function cleanBio(?string $bio): ?string
    {
        return $bio ? trim(strip_tags(preg_replace('/<a href="https:\/\/www\.last\.fm.*?">Read more on Last\.fm<\/a>\.?/', '', $bio))) : null;
    }
}
