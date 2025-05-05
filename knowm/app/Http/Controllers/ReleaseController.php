<?php

namespace App\Http\Controllers;

use App\Models\Release;
use App\Services\ReleaseService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

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
}
