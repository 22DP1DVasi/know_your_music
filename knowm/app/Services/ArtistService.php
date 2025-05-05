<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Support\Facades\DB;

class ArtistService
{
    public function getArtistWithDetails(int $artistId): array
    {
        $artist = $this->getArtistInfo($artistId);

        return [
            'artist' => $artist,
            'genres' => $this->getArtistGenres($artistId),
            'tracks' => $this->getArtistTracksWithDetails($artistId),
            'releases' => $this->getArtistReleasesWithDetails($artistId),
            'total_tracks' => $this->getArtistTracksCount($artistId),
            'total_releases' => $this->getArtistReleasesCount($artistId),
        ];
    }

    public function getArtistInfo(int $artistId): array
    {
        $artist = Artist::findOrFail($artistId);

        return [
            'id' => $artist->id,
            'name' => $artist->name,
            'slug' => $artist->slug,
            'profile_url' => $artist->profile_url,
            'biography' => $artist->biography,
            'formed_year' => $artist->formed_year,
            'disbanded_year' => $artist->disbanded_year,
            'is_active' => $artist->is_active,
            'solo_or_band' => $artist->solo_or_band,
        ];
    }

    public function getArtistGenres(int $artistId): array
    {
        return DB::table('artists_genres')
            ->join('genres', 'artists_genres.genre_id', '=', 'genres.id')
            ->where('artist_id', $artistId)
            ->pluck('genres.name')
            ->toArray();
    }

    public function getArtistTracksWithDetails(int $artistId, int $limit = 10): array
    {
        /*$artist = Artist::findOrFail($artistId);*/
        $tracks = $this->getTracksByArtist($artistId, $limit);

        return $tracks->map(function ($track) {
            return [
                'id' => $track->id,
                'title' => $track->title,
                'duration' => $track->duration,
                'cover_url' => $track->releases->first()->cover_url ?? '/images/default-release-banner.webp',
                'artists' => $track->artists->map(fn($a) => ['id' => $a->id, 'name' => $a->name]),
                'release_title' => $track->releases->first()->title ?? 'Unknown Release',
            ];
        })->toArray();
    }

    public function getArtistReleasesWithDetails(int $artistId, int $limit = 4): array
    {
        return Artist::findOrFail($artistId)
            ->releases()
            ->with(['artists'])
            ->orderBy('release_date', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($release) {
                return [
                    'id' => $release->id,
                    'title' => $release->title,
                    'slug' => $release->slug,
                    'year' => $release->release_date ? date('Y', strtotime($release->release_date)) : null,
                    'type' => $release->release_type,
                    'cover_url' => $release->cover_url ?? '/images/default-release-cover.webp',
                    'artists' => $release->artists->map(fn($a) => ['id' => $a->id, 'name' => $a->name]),
                ];
            })
            ->toArray();
    }

    public function getTracksByArtist(int $artistId, int $limit = 10)
    {
        return Track::whereHas('artists', function($query) use ($artistId) {
            $query->where('artists.id', $artistId);
        })
            ->with(['artists', 'releases'])
            ->limit($limit)
            ->get();
    }

    public function getArtistReleases(int $artistId, int $limit = 4): array
    {
        return DB::table('artists_releases')
            ->join('releases', 'artists_releases.release_id', '=', 'releases.id')
            ->where('artist_id', $artistId)
            ->select([
                'releases.id',
                'releases.title',
                'releases.release_date as year',
                'releases.release_type as type'
            ])
            ->orderBy('releases.release_date', 'desc')
            ->limit($limit)
            ->get()
            ->toArray();
    }

    public function getArtistTracksCount(int $artistId): int
    {
        return Track::whereHas('artists', function($query) use ($artistId) {
            $query->where('artists.id', $artistId);
        })->count();
    }

    public function getArtistReleasesCount(int $artistId): int
    {
        return Release::whereHas('artists', function($query) use ($artistId) {
            $query->where('artists.id', $artistId);
        })->count();
    }
}
