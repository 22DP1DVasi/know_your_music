<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\ArtistComment;
use Illuminate\Support\Facades\DB;

class ArtistService
{
    /**
     * Atgriež informāciju par izpildītāju kopā ar noteiktu komentāru lapu.
     *
     * @param Artist $artist
     * @param int $commentsPage
     * @return array
     */
    public function getArtistWithDetailsAndComments(Artist $artist, int $commentsPage = 1): array
    {
        // informācija par izpildītāju
        $artistInfo = $this->getArtistInfo($artist);
        // komentāri
        $comments = ArtistComment::withTrashed()
            ->where('artist_id', $artist->id)
            ->whereNull('parent_id')
            ->with(['user', 'replies'])
            ->orderBy('created_at', 'desc')
            ->paginate(10, ['*'], 'page', $commentsPage);

        // iegūt kopējo komentāru skaitu
        $totalCommentsCount = ArtistComment::withTrashed()
            ->where('artist_id', $artist->id)
            ->count();

        return array_merge(
            $artistInfo,
            [
                'genres' => $this->getArtistGenres($artist),
                'tracks' => $this->getArtistTracksWithDetails($artist),
                'releases' => $this->getArtistReleasesWithDetails($artist),
                'total_tracks' => $this->getArtistTracksCount($artist),
                'total_releases' => $this->getArtistReleasesCount($artist),
                'comments' => $comments->items(),
                'comments_pagination' => [
                    'current_page' => $comments->currentPage(),
                    'last_page' => $comments->lastPage(),
                    'total' => $totalCommentsCount,
                    'per_page' => $comments->perPage(),
                ]
            ]
        );
    }

    /***
     * Atgriež informāciju/laukus par izpildītāju.
     *
     * @param Artist $artist
     * @return array
     */
    public function getArtistInfo(Artist $artist): array
    {
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

    /**
     * Iegūst izpildītāja formatētu žanru sarakstu.
     *
     * @param Artist $artist
     * @return array
     */
    public function getArtistGenres(Artist $artist): array
    {
        return $artist->genres
            ->map(fn ($genre) => [
                'name' => $genre->name,
                'slug' => $genre->slug,
            ])
            ->toArray();
    }

    /**
     * Iegūst izpildītāja dziesmas ar informāciju par tām.
     *
     * @param Artist $artist
     * @param int $limit
     * @return array
     */
    public function getArtistTracksWithDetails(Artist $artist, int $limit = 10): array
    {
        $tracks = $this->getTracksByArtist($artist, $limit);
        return $tracks->map(function ($track) {
            return [
                'id' => $track->id,
                'title' => $track->title,
                'slug' => $track->slug,
                'duration' => $track->duration->format('H:i:s'),
                'audio_source' => $track->audio_source,
                'cover_url' => $track->cover_url,
                'artists' => $track->artists->map(fn($a) => ['id' => $a->id, 'name' => $a->name]),
                'release_title' => $track->releases->first()->title,
            ];
        })->toArray();
    }

    /**
     * Iegūst izpildītāja albumus ar informāciju par tiem.
     *
     * @param Artist $artist
     * @param int $limit
     * @return array
     */
    public function getArtistReleasesWithDetails(Artist $artist, int $limit = 4): array
    {
        return $artist->releases()
            ->with(['artists'])
            ->orderBy('release_date', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($release) {
                return [
                    'id' => $release->id,
                    'title' => $release->title,
                    'slug' => $release->slug,
                    'year' => $release->release_date?->format('Y'),
                    'type' => $release->release_type,
                    'cover_url' => $release->cover_url ?? '/images/default-release-cover.webp',
                    'artists' => $release->artists->map(fn ($a) => [
                        'id' => $a->id,
                        'name' => $a->name,
                    ]),
                ];
            })
            ->toArray();
    }

    /**
     * @param Artist $artist
     * @param int $limit
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function getTracksByArtist(Artist $artist, int $limit = 10):
    \Illuminate\Database\Eloquent\Collection
    {
        return Track::whereHas('artists', function($query) use ($artist) {
            $query->where('artists.id', $artist->id);
        })
            ->with(['artists', 'releases'])
            ->limit($limit)
            ->get();
    }

    /**
     * @param Artist $artist
     * @return int
     */
    public function getArtistTracksCount(Artist $artist): int
    {
        return Track::whereHas('artists', function($query) use ($artist) {
            $query->where('artists.id', $artist->id);
        })->count();
    }

    /**
     * @param Artist $artist
     * @return int
     */
    public function getArtistReleasesCount(Artist $artist): int
    {
        return Release::whereHas('artists', function($query) use ($artist) {
            $query->where('artists.id', $artist->id);
        })->count();
    }
}
