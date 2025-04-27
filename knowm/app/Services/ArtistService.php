<?php

namespace App\Services;

use App\Models\Artist;
use Illuminate\Support\Facades\DB;

class ArtistService
{
    public function getArtistWithDetails(int $artistId): array
    {
        return [
            'artist' => $this->getArtistInfo($artistId),
            'genres' => $this->getArtistGenres($artistId),
            'tracks' => $this->getArtistTracks($artistId),
            'releases' => $this->getArtistReleases($artistId),
        ];
    }

    public function getArtistInfo(int $artistId): array
    {
        $artist = Artist::findOrFail($artistId);

        return [
            'id' => $artist->id,
            'name' => $artist->name,
            'profile_image' => $artist->profile_image,
            'biography' => $artist->biography,
            'formed_year' => $artist->formed_year,
            'disbanded_year' => $artist->disbanded_year,
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

    public function getArtistTracks(int $artistId, int $limit = 10): array
    {
        return DB::table('artists_tracks')
            ->join('tracks', 'artists_tracks.track_id', '=', 'tracks.id')
            ->leftJoin('tracks_releases', 'tracks.id', '=', 'tracks_releases.track_id')
            ->leftJoin('releases', 'tracks_releases.release_id', '=', 'releases.id')
            ->where('artists_tracks.artist_id', $artistId)
            ->select([
                'tracks.id',
                'tracks.title',
                'tracks.duration',
                'releases.title as release_title',
                'tracks_releases.track_position'
            ])
            ->orderBy('tracks.title')
            ->limit($limit)
            ->get()
            ->toArray();
    }

    public function getArtistReleases(int $artistId, int $limit = 12): array
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
}
