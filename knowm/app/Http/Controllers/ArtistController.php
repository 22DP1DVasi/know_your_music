<?php

namespace App\Http\Controllers;

use App\Services\ArtistService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;

class ArtistController extends Controller
{
    protected ArtistService $artistService;

    public function __construct(ArtistService $artistService)
    {
        $this->artistService = $artistService;
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

    public function showAllTracks($slug)
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $perPage = 50;

        $tracks = Track::with(['releases', 'artists'])
            ->whereHas('artists', function($query) use ($artist) {
                $query->where('artist_id', $artist->id);
            })
            ->orderBy('title')
            ->paginate($perPage);

        // Convert paginator to array and format links
        $pagination = $tracks->toArray();

        return Inertia::render('Artists/ArtistAllTracks', [
            'artist' => $artist,
            'tracks' => $tracks->items(),
            'totalTracks' => $tracks->total(),
            'paginationLinks' => $pagination['links'], // Use the formatted links array
            'currentPage' => $tracks->currentPage(),
            'totalPages' => $tracks->lastPage(),
            'perPage' => $perPage,
        ]);
    }

}
