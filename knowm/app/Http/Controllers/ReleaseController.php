<?php

namespace App\Http\Controllers;

use App\Services\ReleaseService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use App\Models\Release;
use App\Models\Genre;
use App\Models\Artist;

class ReleaseController extends Controller
{
    protected $releaseService;

    public function __construct(ReleaseService $releaseService)
    {
        $this->releaseService = $releaseService;
    }

    public function show($slug)
    {
        $release = $this->releaseService->getReleaseWithDetails($slug);
        $similarReleases = $this->releaseService->getSimilarReleases($release->id);

        return Inertia::render('Releases/ReleaseShow', [
            'release' => $release,
            'similar_releases' => $similarReleases
        ]);
    }

    public function uploadCoverImage(Request $request, Release $release)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,webp|max:2048'
        ]);

        $path = $request->file('image')->storeAs(
            "releases/{$release->release_type}/{$release->id}/",
            'cover.webp',
            'public'
        );

        return response()->json([
            'path' => $path,
            'url' => Storage::url($path)
        ]);
    }

    public function explore(Request $request)
    {
        $searchQuery = $request->input('q', '');
        $perPage = $request->input('perPage', 24);
        $sortOrder = $request->input('sort', 'asc');
        $selectedGenres = $request->input('genres', []);
        if (is_string($selectedGenres)) {
            $selectedGenres = $selectedGenres === '' ? [] : explode(',', $selectedGenres);
        }
        //$genreIds = array_map('intval', $selectedGenres);
        $selectedGenres = is_array($selectedGenres) ? $selectedGenres : [];
        $genreIds = array_filter(array_map('intval', $selectedGenres));
        $releases = Release::query()
            ->when($searchQuery, function ($query) use ($searchQuery) {
                $query->where('title', 'like', "%{$searchQuery}%");
            })
            ->when(!empty($genreIds), function ($query) use ($genreIds) {
                $query->whereHas('genres', function ($q) use ($genreIds) {
                    $q->whereIn('genres.id', $genreIds);
                });
            })
            ->withCount('tracks')
            ->with(['artists', 'genres'])
            ->orderBy('title', $sortOrder)
            ->paginate($perPage)
            ->withQueryString();
        $genres = Genre::orderBy('name')->get();
        return Inertia::render('Releases/ReleasesExplore', [
            'releases' => $releases->items(),
            'searchQuery' => $searchQuery,
            'paginationLinks' => $releases->toArray()['links'],
            'currentPage' => $releases->currentPage(),
            'totalPages' => $releases->lastPage(),
            'perPage' => $perPage,
            'allGenres' => $genres,
            'selectedGenres' => $genreIds,
            'sortOrder' => $sortOrder,
        ]);
    }
}
