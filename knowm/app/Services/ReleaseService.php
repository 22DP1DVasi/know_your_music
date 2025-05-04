<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Support\Facades\DB;

class ReleaseService
{
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
