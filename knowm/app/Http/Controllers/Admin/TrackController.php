<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Track;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TrackController extends Controller
{
    /***
     * Method for Index.vue page.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request): \Inertia\Response
    {
        $tracks = Track::query()
            ->with('artists:id,name')
            ->when($request->search_title, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->orderBy('title')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Admin/Tracks/Index', [
            'tracks' => $tracks,
            'filters' => $request->only(['search_title'])
        ]);
    }

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
