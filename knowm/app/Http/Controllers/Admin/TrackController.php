<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Storage;

class TrackController extends Controller
{
    /***
     * Search for tracks whose titles match the given query.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request): \Illuminate\Http\JsonResponse
    {
        $query = $request->string('q')->toString();
        $releaseArtistIds = $request->input('release_artist_ids', []);
        $tracks = Track::query()
            ->with(['artists'])
            ->where('title', 'like', "%{$query}%")
            ->withCount([
                'artists as matching_artists_count' => function ($q) use ($releaseArtistIds) {
                    $q->whereIn(
                        'artists.id',
                        $releaseArtistIds
                    );
                }
            ])
            ->orderByDesc('matching_artists_count')

            ->orderBy('title')
            ->limit(20)
            ->get()
            ->map(fn ($track) => [
                'id' => $track->id,
                'title' => $track->title,
                'slug' => $track->slug,
                'duration' => $track->duration,
                'artists' => $track->artists->map(fn ($artist) => [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'slug' => $artist->slug,
                ]),
            ]);

        return response()->json($tracks);
    }
}
