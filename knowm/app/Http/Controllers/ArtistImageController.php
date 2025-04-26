<?php

namespace App\Http\Controllers;

use App\Models\Artist;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ArtistImageController extends Controller
{
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
}
