<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\SpotifyService;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Carbon\Carbon;

class ImportSpotifyArtists extends Command
{
    protected $signature = 'spotify:import-artists';
    protected $description = 'Import artists and their discographies from Spotify';

    public function handle()
    {
        $artistsToImport = [
            'Bring Me The Horizon',
            'Architects',
            'Porter Robinson',
            'Brand of Sacrifice',
            'KAMAARA'
        ];

        $spotify = new SpotifyService();

        foreach ($artistsToImport as $artistName) {
            $this->info("Processing artist: {$artistName}");

            // Search for the artist
            $searchResults = $spotify->searchArtists($artistName, 1);

            if (empty($searchResults->artists->items)) {
                $this->error("Artist not found: {$artistName}");
                continue;
            }

            $spotifyArtist = $searchResults->artists->items[0];
            $this->processArtist($spotifyArtist, $spotify);
        }

        $this->info('Import completed!');
    }


    protected function processArtist($spotifyArtist, $spotifyService)
    {
        // Create or update artist
        $artist = Artist::updateOrCreate(
            ['name' => $spotifyArtist->name],
            [
                'solo_or_band' => $this->determineArtistType($spotifyArtist->name),
                // Note: Spotify doesn't provide formed/disbanded years or biography
                // We'll get these from Last.fm later
            ]
        );

        $this->info("Processing discography for: {$artist->name}");

        // Get artist's albums
        $albums = $spotifyService->getArtistAlbums($spotifyArtist->id, 50);

        foreach ($albums->items as $album) {
            // Skip compilations and appearances for now
            if ($album->album_group !== 'album') continue;

            $this->processRelease($album, $artist, $spotifyService);
        }
    }

    protected function processRelease($spotifyAlbum, $artist, $spotifyService)
    {
        // Get tracks first to count them
        $tracks = $spotifyService->getApi()->getAlbumTracks($spotifyAlbum->id);
        $trackCount = count($tracks->items);

        $release = Release::updateOrCreate(
            ['title' => $spotifyAlbum->name],
            [
                'release_date' => Carbon::parse($spotifyAlbum->release_date),
                'release_type' => $this->mapReleaseType($spotifyAlbum->album_type, $trackCount),
            ]
        );

        // Process release artists (existing code)
        $artistIds = [];
        $artistIds[$artist->id] = ['role' => 'primary'];
        foreach ($spotifyAlbum->artists as $albumArtist) {
            if ($albumArtist->id === $artist->id) continue;

            $collabArtist = Artist::updateOrCreate(
                ['name' => $albumArtist->name],
                ['solo_or_band' => $this->determineArtistType($albumArtist->name)]
            );
            $artistIds[$collabArtist->id] = ['role' => 'primary'];
        }
        $release->artists()->sync($artistIds);

        // Process tracks - CHANGE THIS LINE:
        $tracks = $spotifyService->getApi()->getAlbumTracks($spotifyAlbum->id);
        foreach ($tracks->items as $position => $track) {
            $this->processTrack($track, $release, $position + 1); // Removed $primaryArtist parameter
        }
    }

    protected function processTrack($spotifyTrack, $release, $position)
    {
        try {
            $track = Track::updateOrCreate(
                ['title' => $spotifyTrack->name],
                [
                    'duration' => gmdate('H:i:s', $spotifyTrack->duration_ms / 1000),
                    'release_date' => $release->release_date,
                ]
            );

            // Link track to release
            $release->tracks()->syncWithoutDetaching([
                $track->id => ['track_position' => $position]
            ]);

            // Get all release artist IDs
            $releaseArtistIds = $release->artists->pluck('id')->toArray();

            // Process all track artists
            $artistRoles = [];
            foreach ($spotifyTrack->artists as $trackArtist) {
                $artist = Artist::updateOrCreate(
                    ['name' => $trackArtist->name],
                    ['solo_or_band' => $this->determineArtistType($trackArtist->name)]
                );

                $role = in_array($artist->id, $releaseArtistIds) ? 'primary' : 'featured';
                $artistRoles[$artist->id] = ['role' => $role];
            }

            $track->artists()->sync($artistRoles);

        } catch (\Exception $e) {
            $this->error("Failed processing track {$spotifyTrack->name}: ".$e->getMessage());
            \Log::error("Track import failed", [
                'track' => $spotifyTrack->name,
                'error' => $e->getMessage()
            ]);
        }
    }

    protected function determineTrackArtistRole($artistId, $artistName, $releaseArtistIds)
    {
        // Check if artist is on the release
        return in_array($artistId, $releaseArtistIds) ? 'primary' : 'featured';
    }

    protected function determineArtistRole($artistName, $trackTitle)
    {
        $lowerName = strtolower($artistName);
        $lowerTrack = strtolower($trackTitle);

        // Producer indicators
        $producerIndicators = [
            'prod',
            'production',
            'remix',
            'mix',
            'edit',
            'dr.',
            'master'
        ];

        foreach ($producerIndicators as $indicator) {
            if (str_contains($lowerName, $indicator) || str_contains($lowerTrack, $indicator)) {
                return 'producer';
            }
        }

        // Default to featured for all others
        return 'featured';
    }

    protected function determineArtistType($name)
    {

        // Then check for band indicators
        $bandIndicators = [
            ' and ',
            ' & ',
            'The ',
            ' vs ',
            ' vs. ',
            ' with ',
            ', ',
            ' + ',
            ' x ',
            ' feat ',
            ' feat. ',
            ' ft ',
            ' ft. '
        ];

        foreach ($bandIndicators as $indicator) {
            if (str_contains($name, $indicator)) {
                return 'band';
            }
        }

        // Default to solo if no indicators found
        return 'solo';
    }

    protected function mapReleaseType($spotifyType, $trackCount = null)
    {
        // If we have track count information and it's a single
        if ($trackCount !== null && $spotifyType === 'single') {
            // Classify as EP if it has 3-6 tracks
            if ($trackCount >= 3 && $trackCount <= 6) {
                return 'ep';
            }
            return 'single';
        }

        // Default mapping for other types
        return match($spotifyType) {
            'album' => 'album',
            'single' => 'single',
            'compilation' => 'compilation',
            default => 'ep', // Fallback for any other types
        };
    }
}
