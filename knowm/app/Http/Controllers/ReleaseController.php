<?php

namespace App\Http\Controllers;

use App\Services\PopularityService;
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

        app(PopularityService::class)
            ->add(
                'release',
                $release->id,
                0.1,
                'view',
                auth()->id()
            );

        return Inertia::render('Releases/ReleaseShow', [
            'release' => $releaseData
        ]);
    }

    /***
     * Metode priekš ReleaseDescription.vue lapas.
     *
     * @param Release $release
     * @return \Inertia\Response
     */
    public function showDescription(Release $release): \Inertia\Response
    {
        return Inertia::render('Releases/ReleaseDescription', [
            'release' => $release->load(['artists', 'tracks']),
        ]);
    }

    /**
     * Metode priekš ReleasesExplore.vue lapas.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function explore(Request $request): \Inertia\Response
    {
        $searchQuery = $request->input('q', '');
        $perPage = $request->input('perPage', 24);
        $sortOrder = $request->input('sort', 'asc');
        $selectedGenres = $request->input('genres', []);
        $dateFrom = $request->input('date_from', null);
        $dateTo = $request->input('date_to', null);

        if (is_string($selectedGenres)) {
            $selectedGenres = $selectedGenres === '' ? [] : explode(',', $selectedGenres);
        }
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
            ->when($dateFrom, function ($query) use ($dateFrom) {
                $query->whereDate('release_date', '>=', $dateFrom);
            })
            ->when($dateTo, function ($query) use ($dateTo) {
                $query->whereDate('release_date', '<=', $dateTo);
            })
            ->withCount('tracks')
            ->with(['artists', 'genres'])
            ->orderBy('title', $sortOrder)
            ->orderBy('popularity', 'desc')
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
            'dateFrom' => $dateFrom,
            'dateTo' => $dateTo,
        ]);
    }
}
