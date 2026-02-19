<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Genre;
use App\Models\Release;
use App\Models\Track;
use App\Models\GenreComment;
use Illuminate\Support\Facades\DB;

class GenreService
{
    /**
     * @param Genre $genre
     * @param int $commentsPage
     * @return array
     */
    public function getGenreWithDetailsAndComments(Genre $genre, int $commentsPage = 1): array
    {
        // informācija par žanru
        $baseData = $this->getGenreWithDetails($genre);
        // komentāri
        $comments = GenreComment::withTrashed()
            ->where('genre_id', $genre->id)
            ->whereNull('parent_id')
            ->with(['user', 'replies'])
            ->orderBy('created_at', 'desc')
            ->paginate(10, ['*'], 'page', $commentsPage);

        // iegūt visu komentāru skaitu, ieskaitot atbildes
        $totalCommentsCount = GenreComment::withTrashed()
            ->where('genre_id', $genre->id)
            ->count();

        return array_merge(
            $baseData,
            [
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

    /**
     * @param Genre $genre
     * @return array
     */
    public function getGenreWithDetails(Genre $genre): array
    {
        $genreInfo = $this->getGenreInfo($genre);
        return array_merge(
            $genreInfo,
            [
                'artists' => $this->getGenreArtistsWithDetails($genre),
                'tracks' => $this->getGenreTracksWithDetails($genre),
                'releases' => $this->getGenreReleasesWithDetails($genre),
                'total_artists' => $this->getGenreArtistsCount($genre),
                'total_tracks' => $this->getGenreTracksCount($genre),
                'total_releases' => $this->getGenreReleasesCount($genre),
            ]
        );
    }

    /**
     * @param Genre $genre
     * @return array
     */
    public function getGenreInfo(Genre $genre): array
    {
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

    /**
     * @param Genre $genre
     * @param int $limit
     * @return array
     */
    public function getGenreArtistsWithDetails(Genre $genre, int $limit = 4): array
    {
        return Artist::whereHas('genres', function($query) use ($genre) {
            $query->where('genres.id', $genre->id);
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

    /**
     * @param Genre $genre
     * @param int $limit
     * @return array
     */
    public function getGenreTracksWithDetails(Genre $genre, int $limit = 10): array
    {
        return Track::whereHas('genres', function($query) use ($genre) {
            $query->where('genres.id', $genre->id);
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

    /**
     * @param Genre $genre
     * @param int $limit
     * @return array
     */
    public function getGenreReleasesWithDetails(Genre $genre, int $limit = 4): array
    {
        return Release::whereHas('genres', function($query) use ($genre) {
            $query->where('genres.id', $genre->id);
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

    /**
     * @param Genre $genre
     * @return int
     */
    public function getGenreArtistsCount(Genre $genre): int
    {
        return DB::table('artists_genres')
            ->where('genre_id', $genre->id)
            ->count();
    }

    /**
     * @param Genre $genre
     * @return int
     */
    public function getGenreTracksCount(Genre $genre): int
    {
        return DB::table('tracks_genres')
            ->where('genre_id', $genre->id)
            ->count();
    }

    /**
     * @param Genre $genre
     * @return int
     */
    public function getGenreReleasesCount(Genre $genre): int
    {
        return DB::table('releases_genres')
            ->where('genre_id', $genre->id)
            ->count();
    }

    /**
     * @param Genre $genre
     * @param int $perPage
     * @return array
     */
    public function getGenreArtistsPaginated(Genre $genre, int $perPage = 24): array
    {
        $query = Artist::query()
            ->select([
                'artists.id',
                'artists.name',
                'artists.slug',
                DB::raw('COUNT(tracks.id) as tracks_count')
            ])
            ->join('artists_genres', 'artists.id', '=', 'artists_genres.artist_id')
            ->leftJoin('artists_tracks', 'artists.id', '=', 'artists_tracks.artist_id')
            ->leftJoin('tracks', 'artists_tracks.track_id', '=', 'tracks.id')
            ->where('artists_genres.genre_id', $genre->id)
            ->groupBy('artists.id', 'artists.name', 'artists.slug')
            ->orderBy('artists.name');
        $paginator = $query->paginate($perPage);
        return [
            'artists' => $paginator->items(),
            'paginationLinks' => $paginator->toArray()['links'],
            'currentPage' => $paginator->currentPage(),
            'totalPages' => $paginator->lastPage()
        ];
    }
}
