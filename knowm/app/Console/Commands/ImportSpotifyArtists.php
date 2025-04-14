<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\SpotifyService;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ImportSpotifyArtists extends Command
{
    protected $signature = 'spotify:import-artists';
    protected $description = 'Import artists and their discographies from Spotify';

    public function handle()
    {
        $artistsToImport = [
            'Bring Me The Horizon',
            'Porter Robinson',
            'Brand of Sacrifice',
            'KAMAARA',
            'Korn'
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
            ]
        );

        $this->info("Processing discography for: {$artist->name}");

        // Get all release types (remove album-only filter)
        $albums = $spotifyService->getArtistAlbums($spotifyArtist->id, 50);

        foreach ($albums->items as $album) {
            // Only skip "appears_on" albums but process all others
            if ($album->album_group === 'appears_on') continue;

            $this->processRelease($album, $artist, $spotifyService);
        }
    }

    protected function processRelease($spotifyAlbum, $artist, $spotifyService)
    {
        // Get tracks first for count and type determination
        $tracks = $spotifyService->getApi()->getAlbumTracks($spotifyAlbum->id);
        $trackCount = count($tracks->items);

        $release = Release::updateOrCreate(
            ['title' => $spotifyAlbum->name],
            [
                'release_date' => Carbon::parse($spotifyAlbum->release_date),
                'release_type' => $this->determineReleaseType($spotifyAlbum, $trackCount),
            ]
        );

        // Process release artists
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

        // Process tracks
        foreach ($tracks->items as $position => $track) {
            $this->processTrack($track, $release, $position + 1);
        }
    }

    protected function processTrack($spotifyTrack, $release, $position)
    {
        try {
            // First create/update the track
            $track = Track::updateOrCreate(
                ['title' => $spotifyTrack->name],
                [
                    'duration' => gmdate('H:i:s', $spotifyTrack->duration_ms / 1000),
                    'release_date' => $release->release_date,
                ]
            );

            // Remove any existing relationship to avoid unique constraint violations
            DB::table('tracks_releases')
                ->where('release_id', $release->id)
                ->where('track_id', $track->id)
                ->delete();

            // Also remove any existing track at this position
            DB::table('tracks_releases')
                ->where('release_id', $release->id)
                ->where('track_position', $position)
                ->delete();

            // Create new relationship with correct position
            $release->tracks()->attach($track->id, [
                'track_position' => $position,
                'created_at' => now(),
                'updated_at' => now()
            ]);

            // Process artist relationships (existing code)
            $releaseArtistIds = $release->artists->pluck('id')->toArray();
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
                'error' => $e->getMessage(),
                'release' => $release->title,
                'position' => $position
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

    protected function determineReleaseType($spotifyAlbum, $trackCount)
    {
        // Handle Spotify's album_group and album_type
        $spotifyType = $spotifyAlbum->album_type;
        $spotifyGroup = $spotifyAlbum->album_group;

        // Compilations take priority
        if ($spotifyType === 'compilation' || $spotifyGroup === 'compilation') {
            return 'compilation';
        }

        // Singles with 4-6 tracks become EPs
        if ($spotifyType === 'single' && $trackCount >= 4 && $trackCount <= 6) {
            return 'ep';
        }

        // Standard mapping
        return match($spotifyType) {
            'album' => 'album',
            'single' => 'single',
            default => $spotifyGroup === 'single' ? 'single' : 'album', // fallback
        };
    }
}
