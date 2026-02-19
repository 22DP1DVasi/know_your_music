<?php

namespace App\Http\Controllers;

use App\Services\ArtistService;
use App\Services\ReleaseService;
use App\Services\TrackService;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Artist;
use App\Models\Genre;
use Inertia\Response;

class ArtistController extends Controller
{
    protected ArtistService $artistService;
    protected ReleaseService $releaseService;
    protected TrackService $trackService;

    /**
     * Konstruktors.
     *
     * @param ArtistService $artistService
     * @param ReleaseService $releaseService
     * @param TrackService $trackService
     */
    public function __construct(ArtistService $artistService, ReleaseService $releaseService, TrackService $trackService)
    {
        $this->artistService = $artistService;
        $this->releaseService = $releaseService;
        $this->trackService = $trackService;
    }

    /***
     * Metode priekš ArtistShow.vue lapas.
     * Iegūst datus par izpildītāju no datubāzes un daļu no komentāriem un nodod tos lapai.
     *
     * @param Artist $artist
     * @return \Inertia\Response
     */
    public function show(Artist $artist): \Inertia\Response
    {
        // iegūt pašreizējo lapu komentāriem no pieprasījuma, noklusējums ir 1
        $commentsPage = request()->input('comments_page', 1);
        $artistData = $this->artistService->getArtistWithDetailsAndComments($artist, $commentsPage);
        return Inertia::render('Artists/ArtistShow', [
            'artist' => $artistData
        ]);
    }

    /**
     * Atveido izpildītāja biogrāfijas lapu.
     *
     * @param Artist $artist
     * @return Response
     */
    public function showBio(Artist $artist): \Inertia\Response
    {
        return Inertia::render('Artists/ArtistBio', [
            'artist' => $artist,
        ]);
    }

    /**
     * Atveido izpildītāja visu albumu lapu.
     *
     * @param Artist $artist
     * @return Response
     */
    public function showAllReleases(Artist $artist): \Inertia\Response
    {
        $releases = $this->releaseService->getPaginatedReleases(
            $artist,
            20,
            request('search')
        );
        return Inertia::render('Artists/ArtistAllReleases', [
            'artist' => $artist,
            ...$this->releaseService->formatForView($releases),
            'filters' => request()->only(['search'])
        ]);
    }

    /**
     * Atveido izpildītāja visu dziesmu lapu.
     *
     * @param Artist $artist
     * @return Response
     */
    public function showAllTracks(Artist $artist): \Inertia\Response
    {
        $tracks = $this->trackService->getPaginatedTracks(
            $artist,
            40,
            request('search')
        );
        return Inertia::render('Artists/ArtistAllTracks', [
            'artist' => $artist,
            ...$this->trackService->formatForView($tracks),
            'filters' => request()->only(['search'])
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
        $selectedGenres = is_array($selectedGenres) ? $selectedGenres : [];
        $genreIds = array_filter(array_map('intval', $selectedGenres));
        $artists = Artist::query()
            ->when($searchQuery, function ($query) use ($searchQuery) {
                $query->where('name', 'like', "%{$searchQuery}%");
            })
            ->when(!empty($genreIds), function ($query) use ($genreIds) {
                $query->whereHas('genres', function ($q) use ($genreIds) {
                    $q->whereIn('genres.id', $genreIds);
                });
            })
            ->withCount('tracks')
            ->with('genres')
            ->orderBy('name', $sortOrder)
            ->paginate($perPage)
            ->withQueryString();
        $genres = Genre::orderBy('name')->get();
        return Inertia::render('Artists/ArtistsExplore', [
            'artists' => $artists->items(),
            'searchQuery' => $searchQuery,
            'paginationLinks' => $artists->toArray()['links'],
            'currentPage' => $artists->currentPage(),
            'totalPages' => $artists->lastPage(),
            'perPage' => $perPage,
            'allGenres' => $genres,
            'selectedGenres' => $genreIds,
            'sortOrder' => $sortOrder
        ]);
    }

}
