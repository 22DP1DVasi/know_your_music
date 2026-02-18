<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\ReleaseComment;

class ReleaseService
{
    /**
     * Iegūst informāciju par albumu kopā ar noteiktu komentāru lapu.
     *
     * @param Release $release
     * @param int $commentsPage
     * @return array
     */
    public function getReleaseWithDetailsAndComments(Release $release, int $commentsPage = 1): array
    {
        // informācija par albumu
        $releaseData = $this->getReleaseWithDetails($release);
        // komentāri
        $comments = ReleaseComment::withTrashed()
            ->where('release_id', $releaseData->id)
            ->whereNull('parent_id')
            ->with(['user', 'replies'])
            ->orderBy('created_at', 'desc')
            ->paginate(10, ['*'], 'page', $commentsPage);

        // iegūt visu komentāru skaitu, ieskaitot atbildes
        $totalCommentsCount = ReleaseComment::withTrashed()
            ->where('release_id', $releaseData->id)
            ->count();

        return [
            // Main release data
            'id' => $releaseData->id,
            'title' => $releaseData->title,
            'slug' => $releaseData->slug,
            'cover_url' => $releaseData->cover_url,
            'type' => $releaseData->type,
            'year' => $releaseData->year,
            'description' => $releaseData->description,
            'release_date' => $releaseData->release_date,
            'release_type' => $releaseData->release_type,

            'artists' => $releaseData->artists,
            'genres' => $releaseData->genres,
            'tracks' => $releaseData->tracks,
            'comments' => $comments->items(),
            'similar_releases' => $this->getSimilarReleases($release),

            'comments_pagination' => [
                'current_page' => $comments->currentPage(),
                'last_page' => $comments->lastPage(),
                'total' => $totalCommentsCount,
                'per_page' => $comments->perPage(),
            ]
        ];
    }

    /**
     * @param Release $release
     * @return Release
     */
    public function getReleaseWithDetails(Release $release): Release
    {
        return $release->load([
            'artists:id,name,slug',
            'genres:id,name,slug',
            'tracks' => function ($query) {
                $query->orderBy('tracks_releases.track_position')
                    ->with('artists:id,name,slug');
            }
        ])->loadCount('tracks');
    }

    /**
     * @param Release $release
     * @param int $limit
     * @return \Illuminate\Database\Eloquent\Collection|\Illuminate\Support\Collection
     */
    public function getSimilarReleases(Release $release, int $limit = 5)
    {
        // Eager ielādēt relācijas modelī, ja tās vēl nav Eager ielādētas
        $release->loadMissing('genres');
        $genreIds = $release->genres->pluck('id');
        return Release::with('artists:id,name,slug')
            ->whereHas('genres', function ($query) use ($genreIds) {
                $query->whereIn('genres.id', $genreIds);
            })
            ->where('id', '!=', $release->id)
            ->where('release_type', $release->release_type)
            ->orderBy('release_date', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($similarRelease) {
                return [
                    'id' => $similarRelease->id,
                    'title' => $similarRelease->title,
                    'slug' => $similarRelease->slug,
                    'cover_url' => $similarRelease->cover_url,
                    'release_type' => $similarRelease->release_type,
                ];
            });
    }

    /**
     * @param Artist $artist
     * @param int $perPage
     * @param string|null $search
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public function getPaginatedReleases(Artist $artist, int $perPage = 20, ?string $search = null):
    \Illuminate\Contracts\Pagination\LengthAwarePaginator
    {
        return $artist->releases()
            ->with([
                'artists:id,name,slug',
                'tracks'
            ])
            ->when($search, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->withCount('tracks')
            ->orderBy('release_date', 'desc')
            ->paginate($perPage);
    }

    public function formatForView($paginator): array
    {
        return [
            'releases' => $paginator->items(),
            'totalReleases' => $paginator->total(),
            'paginationLinks' => $paginator->onEachSide(1)->toArray()['links'],
            'currentPage' => $paginator->currentPage(),
            'totalPages' => $paginator->lastPage(),
            'perPage' => $paginator->perPage()
        ];
    }
}
