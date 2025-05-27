<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Genre;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Support\Facades\DB;

class ReleaseService
{
    public function getReleaseWithDetails($slug)
    {
        return Release::with([
            'artists' => function($query) {
                $query->select('artists.id', 'artists.name', 'artists.slug');
            },
            'genres' => function($query) {
                $query->select('genres.id', 'genres.name', 'genres.slug');
            },
            'tracks' => function($query) {
                $query->with(['artists' => function($q) {
                    $q->select('artists.id', 'artists.name', 'artists.slug');
                }])
                    ->select('tracks.*')
                    ->orderBy('tracks_releases.track_position');
            }
        ])
            ->withCount('tracks')
            ->where('slug', $slug)
            ->firstOrFail();
    }

    public function getSimilarReleases($releaseId, $limit = 5)
    {
        $release = Release::findOrFail($releaseId);
        // get releases with the same primary genre
        return Release::with(['artists'])
            ->whereHas('genres', function($query) use ($release) {
                $query->whereIn('genres.id', $release->genres->pluck('id'));
            })
            ->where('id', '!=', $releaseId)
            ->where('release_type', $release->release_type)
            ->orderBy('release_date', 'desc')
            ->limit($limit)
            ->get()
            ->map(function($release) {
                return [
                    'id' => $release->id,
                    'title' => $release->title,
                    'slug' => $release->slug,
                    'cover_url' => $release->cover_url,
                    'release_type' => $release->release_type
                ];
            });
    }

    public function getPaginatedReleases($artistSlug, $perPage = 20, $search = null)
    {
        $artist = Artist::where('slug', $artistSlug)->firstOrFail();
        return Release::with(['artists', 'tracks'])
            ->whereHas('artists', function($query) use ($artist) {
                $query->where('artist_id', $artist->id);
            })
            ->when($search, function($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->withCount('tracks')
            ->orderBy('release_date', 'desc')
            ->paginate($perPage);
    }

    public function formatForView($paginator)
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
