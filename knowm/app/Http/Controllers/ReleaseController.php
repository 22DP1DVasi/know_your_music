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
    protected ReleaseService $releaseService;

    /**
     * Konstruktors.
     *
     * @param ReleaseService $releaseService
     */
    public function __construct(ReleaseService $releaseService)
    {
        $this->releaseService = $releaseService;
    }

    /**
     * Metode priekš ReleaseShow.vue lapas.
     * Iegūst datus par albumu no datubāzes un daļu no komentāriem un nodod tos lapai.
     *
     * @param Release $release
     * @return \Inertia\Response
     */
    public function show(Release $release): \Inertia\Response
    {
        // iegūt pašreizējo lapu komentāriem no pieprasījuma, noklusējums ir 1
        $commentsPage = request()->input('comments_page', 1);
        $releaseData = $this->releaseService->getReleaseWithDetailsAndComments($release, $commentsPage);
        return Inertia::render('Releases/ReleaseShow', [
            'release' => $releaseData
        ]);
    }

    /**
     * @param Request $request
     * @return \Inertia\Response
     */
    public function explore(Request $request): \Inertia\Response
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
