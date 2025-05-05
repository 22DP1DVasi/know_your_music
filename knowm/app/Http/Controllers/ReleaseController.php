<?php

namespace App\Http\Controllers;

use App\Models\Release;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class ReleaseController extends Controller
{

    public function show(Release $release)
    {
        $data = $this->artistService->getArtistWithDetails($release->id);

        return Inertia::render('Artists/ArtistShow', [
            'artist' => $data
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
