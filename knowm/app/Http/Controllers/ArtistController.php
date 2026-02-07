<?php

namespace App\Http\Controllers;

use App\Services\ArtistService;
use App\Services\ReleaseService;
use App\Services\TrackService;
use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Carbon\Carbon;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use App\Models\ArtistComment;

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

    /**
     * Izpildītāja lapas atveidošana.
     *
     * @return \Inertia\Response
     */
    public function index(): \Inertia\Response
    {
        return Inertia::render('Admin/Artists/Index', [
            'artists' => Artist::query()
                ->latest()
                ->paginate(10)
        ]);
    }

    /**
     * @param Request $request
     * @param Artist $artist
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadBannerImage(Request $request, Artist $artist): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'image' => 'required|image|mimes:webp|max:5120'
        ]);
        $path = $request->file('image')->storeAs(
            "artists/{$artist->id}/banner",
            'banner.webp',
            'public'
        );
        return response()->json([
            'path' => $path,
            'url' => Storage::url($path)
        ]);
    }

    /**
     * @param Request $request
     * @param Artist $artist
     * @return \Illuminate\Http\JsonResponse
     */
    public function uploadProfileImage(Request $request, Artist $artist): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'image' => 'required|image|mimes:webp|max:2048'
        ]);
        $path = $request->file('image')->storeAs(
            "artists/{$artist->id}/profile",
            'profile.webp',
            'public'
        );
        return response()->json([
            'path' => $path,
            'url' => Storage::url($path)
        ]);
    }

    /***
     * Metode priekš ArtistShow.vue lapas.
     * Iegūst datus par izpildītāju no datubāzes un daļu no komentāriem, kā arī
     * autentificēta lietotāja informāciju, un nodod tos lapai.
     *
     * @param Artist $artist
     * @return \Inertia\Response
     */
    public function show(Artist $artist): \Inertia\Response
    {
        // iegūt pašreizējo lapu komentāriem no pieprasījuma, noklusējums ir 1
        $commentsPage = request()->input('comments_page', 1);

        $data = $this->artistService->getArtistWithDetailsAndComments($artist->id, $commentsPage);
        return Inertia::render('Artists/ArtistShow', [
            'artist' => $data
        ]);
    }

    /**
     * Atveido izpildītāja biogrāfijas lapu.
     *
     * @param $artistSlug
     * @return \Inertia\Response
     */
    public function showBio($artistSlug): \Inertia\Response
    {
        $artist = Artist::where('slug', $artistSlug)->firstOrFail();
        return Inertia::render('Artists/ArtistBio', [
            'artist' => $artist,
        ]);
    }

    /**
     * Atveido izpildītāja visu albumu lapu.
     *
     * @param $slug
     * @return \Inertia\Response
     */
    public function showAllReleases($slug): \Inertia\Response
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $releases = $this->releaseService->getPaginatedReleases(
            $slug,
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
     * @param $slug
     * @return \Inertia\Response
     */
    public function showAllTracks($slug): \Inertia\Response
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $tracks = $this->trackService->getPaginatedTracks(
            $slug,
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
