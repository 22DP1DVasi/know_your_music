<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Genre;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Support\Facades\DB;

class GenreService
{
    public function getGenreWithDetails(int $genreId): array
    {
        return [
            'genre' => $this->getGenreInfo($genreId),
            'artists' => $this->getGenreArtistsWithDetails($genreId),
            'tracks' => $this->getGenreTracksWithDetails($genreId),
            'releases' => $this->getGenreReleasesWithDetails($genreId),
            'total_artists' => $this->getGenreArtistsCount($genreId),
            'total_tracks' => $this->getGenreTracksCount($genreId),
            'total_releases' => $this->getGenreReleasesCount($genreId),
        ];
    }

    public function getGenreInfo(int $genreId): array
    {
        $genre = Genre::findOrFail($genreId);
        return [
            'id' => $genre->id,
            'name' => $genre->name,
            'slug' => $genre->slug,
            'description' => $genre->description,
            'origin_year' => $genre->origin_year,
            'origin_country' => $genre->origin_country,
            'profile_url' => $genre->profile_url,
        ];
    }

    public function getGenreArtistsWithDetails(int $genreId, int $limit = 4): array
    {
        return Artist::whereHas('genres', function($query) use ($genreId) {
            $query->where('genres.id', $genreId);
        })
            ->with(['genres'])
            ->limit($limit)
            ->get()
            ->map(function ($artist) {
                return [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'slug' => $artist->slug,
                    'profile_url' => $artist->profile_url ?? '/images/default-artist.webp',
                ];
            })
            ->toArray();
    }

    public function getGenreTracksWithDetails(int $genreId, int $limit = 10): array
    {
        return Track::whereHas('genres', function($query) use ($genreId) {
            $query->where('genres.id', $genreId);
        })
            ->with(['artists', 'releases'])
            ->limit($limit)
            ->get()
            ->map(function ($track) {
                return [
                    'id' => $track->id,
                    'title' => $track->title,
                    'slug' => $track->slug,
                    'duration' => $track->duration->format('H:i:s'),
                    'audio_source' => $track->audio_source,
                    'cover_url' => $track->releases->first()->cover_url ?? '/images/default-release-cover.webp',
                    'artists' => $track->artists->map(fn($a) => ['id' => $a->id, 'name' => $a->name]),
                ];
            })
            ->toArray();
    }

    public function getGenreReleasesWithDetails(int $genreId, int $limit = 4): array
    {
        return Release::whereHas('genres', function($query) use ($genreId) {
            $query->where('genres.id', $genreId);
        })
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

    public function getGenreArtistsCount(int $genreId): int
    {
        return DB::table('artists_genres')
            ->where('genre_id', $genreId)
            ->count();
    }

    public function getGenreTracksCount(int $genreId): int
    {
        return DB::table('tracks_genres')
            ->where('genre_id', $genreId)
            ->count();
    }

    public function getGenreReleasesCount(int $genreId): int
    {
        return DB::table('releases_genres')
            ->where('genre_id', $genreId)
            ->count();
    }
}
