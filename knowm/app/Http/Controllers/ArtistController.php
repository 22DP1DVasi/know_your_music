<?php

namespace App\Http\Controllers;

use App\Services\ArtistService;
use App\Services\ReleaseService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;

class ArtistController extends Controller
{
    protected ArtistService $artistService;

    public function __construct(ArtistService $artistService, ReleaseService $releaseService)
    {
        $this->artistService = $artistService;
        $this->releaseService = $releaseService;
    }

    public function index()
    {
        return Inertia::render('Admin/Artists/Index', [
            'artists' => Artist::query()
                ->latest()
                ->paginate(10)
        ]);
    }

    public function create()
    {
        return Inertia::render('Admin/Artists/Create');
    }

    public function store(StoreArtistRequest $request)
    {
        Artist::create($request->validated());

        return redirect()->route('admin-artists-index')
            ->with('success', 'Artist created successfully');
    }

    public function edit(Artist $artist)
    {
        return Inertia::render('Admin/Artists/Edit', [
            'artist' => $artist
        ]);
    }

    public function update(UpdateArtistRequest $request, Artist $artist)
    {
        $artist->update($request->validated());

        return redirect()->route('admin.artists.index')
            ->with('success', 'Artist updated successfully');
    }

    public function destroy(Artist $artist)
    {
        $artist->delete();

        return redirect()->route('admin.artists.index')
            ->with('success', 'Artist deleted successfully');
    }

    public function show(Artist $artist)
    {
        $data = $this->artistService->getArtistWithDetails($artist->id);

        return Inertia::render('Artists/ArtistShow', [
            'artist' => $data
        ]);
    }

    public function uploadBannerImage(Request $request, Artist $artist)
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

    public function uploadProfileImage(Request $request, Artist $artist)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,webp|max:2048'
        ]);
        $path = $request->file('image')->storeAs(
            "artists/{$artist->id}/profile",
            'profile.jpg',
            'public'
        );
        return response()->json([
            'path' => $path,
            'url' => Storage::url($path)
        ]);
    }

    public function showBio($artistSlug)
    {
        $artist = Artist::where('slug', $artistSlug)->firstOrFail();

        return Inertia::render('Artists/ArtistBio', [
            'artist' => $artist->load(['genres']),
            'title' => "{$artist->name} - Biography"
        ]);
    }

    public function showAllReleases($slug)
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $service = new ReleaseService();

        $releases = $service->getPaginatedReleases(
            $slug,
            20,
            request('search')
        );

        return Inertia::render('Artists/ArtistAllReleases', [
            'artist' => $artist,
            ...$service->formatForView($releases),
            'filters' => request()->only(['search'])
        ]);
    }

    public function showAllTracks($slug)
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $perPage = 40;

        $tracks = Track::with(['releases', 'artists'])
            ->whereHas('artists', function($query) use ($artist) {
                $query->where('artist_id', $artist->id);
            })
            ->when(request('search'), function($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->orderBy('title')
            ->paginate($perPage);

        $pagination = $tracks->toArray();

        return Inertia::render('Artists/ArtistAllTracks', [
            'artist' => $artist,
            'tracks' => $tracks->items(),
            'totalTracks' => $tracks->total(),
            'paginationLinks' => $pagination['links'],
            'currentPage' => $tracks->currentPage(),
            'totalPages' => $tracks->lastPage(),
            'perPage' => $perPage,
            'filters' => request()->only(['search'])
        ]);
    }

}
