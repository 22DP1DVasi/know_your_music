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
     * Deletes the track.
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id): \Illuminate\Http\RedirectResponse
    {
        $track = Track::findOrFail($id);
        $track->delete();
        return redirect()->route('admin-tracks-index')
            ->with('success', __('messages.track_deleted'));
    }

    /***
     * Method for Edit.vue page.
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function edit($id): \Inertia\Response
    {
        $track = Track::query()
            ->with([
                'genres:id,name',
                'artists' => function ($query) {
                    $query->select('artists.id', 'artists.name', 'artists.slug');
                }
            ])
            ->findOrFail($id);

        return Inertia::render('Admin/Tracks/Edit', [
            'track' => [
                'id' => $track->id,
                'title' => $track->title,
                'slug' => $track->slug,
                'release_date' => $track->release_date,
                'duration' => $track->duration ? $track->duration/*->format('H:i:s')*/ : null,
                'description' => $track->description,
                'description_lv' => $track->description_lv,
                'popularity' => $track->popularity,
                'created_at' => $track->created_at,
                'updated_at' => $track->updated_at,
                'cover_url' => $track->cover_url,

                'genres' => $track->genres->map(fn ($genre) => [
                    'id' => $genre->id,
                    'name' => $genre->name
                ]),

                'artists' => $track->artists->map(fn ($artist) => [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'slug' => $artist->slug,
                    'banner_url' => $artist->banner_url
                ]),
            ]
        ]);
    }

    /***
     * Updates the track (only text attributes).
     *
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(Request $request, $id): \Illuminate\Http\RedirectResponse
    {
        $track = Track::findOrFail($id);

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'release_date' => 'required|date',
            'duration' => 'required|date_format:H:i:s',
            'description' => 'nullable|string',
            'description_lv' => 'nullable|string',
        ]);

        $track->update($validated);

        return redirect()->route('admin-tracks-edit', $track->id)
            ->with('success', __('messages.track_updated'));
    }

    public function updateArtists(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $track = Track::findOrFail($id);
        $validated = $request->validate([
            'artist_ids' => ['array'],
            'artist_ids.*' => ['exists:artists,id']
        ]);
        $track->artists()->sync(
            $validated['artist_ids'] ?? []
        );

        return response()->json([
            'success' => true
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
