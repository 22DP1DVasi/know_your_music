<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Storage;

class ReleaseController extends Controller
{
    /***
     * For Index.vue page.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request): \Inertia\Response
    {
        $releases = Release::query()
            ->with('artists:id,name')
            ->when($request->search_title, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->when($request->filter_type, function ($query, $type) {
                $query->where('release_type', $type);
            })
            ->orderBy('title')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Admin/Releases/Index', [
            'releases' => $releases,
            'filters' => $request->only(['search_title', 'filter_type'])
        ]);
    }

    /***
     * Deletes the album.
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id): \Illuminate\Http\RedirectResponse
    {
        $release = Release::findOrFail($id);
        $release->delete();
        return redirect()->route('admin-releases-index')
            ->with('success', __('messages.release_deleted'));
    }

    public function edit($id): \Inertia\Response
    {
        $release = Release::query()
            ->with([
                'genres:id,name',
                'artists' => function ($query) {
                    $query->select('artists.id', 'artists.name', 'artists.slug');
                },
                'tracks' => function ($query) {
                    $query->with([
                        'artists:id,name,slug'
                    ])->select('tracks.id', 'tracks.title', 'tracks.slug', 'tracks.duration');
                }
            ])
            ->findOrFail($id);

        return Inertia::render('Admin/Releases/Edit', [
            'release' => [
                'id' => $release->id,
                'title' => $release->title,
                'slug' => $release->slug,
                'release_date' => $release->release_date,
                'release_type' => $release->release_type,
                'description' => $release->description,
                'description_lv' => $release->description_lv,
                'popularity' => $release->popularity,
                'created_at' => $release->created_at,
                'updated_at' => $release->updated_at,
                'cover_url' => $release->cover_url,

                'genres' => $release->genres->map(fn ($genre) => [
                    'id' => $genre->id,
                    'name' => $genre->name,
                ]),

                'artists' => $release->artists->map(fn ($artist) => [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'slug' => $artist->slug,
                    'banner_url' => $artist->banner_url
                ]),

                'tracks' => $release->tracks->sortBy('pivot.track_position')->values()->map(fn ($track) => [
                    'id' => $track->id,
                    'title' => $track->title,
                    'slug' => $track->slug,
                    'duration' => $track->duration,
                    'track_position' => $track->pivot->track_position,
                    'artists' => $track->artists->map(fn ($artist) => [
                        'id' => $artist->id,
                        'name' => $artist->name,
                        'slug' => $artist->slug,
                    ]),
                ]),
            ],
            'releaseTypes' => ['album', 'ep', 'single', 'compilation'],
        ]);
    }

    public function update(Request $request, $id): \Illuminate\Http\RedirectResponse
    {
        $release = Release::findOrFail($id);

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'release_date' => 'nullable|date',
            'release_type' => 'required|in:album,ep,single,compilation',
            'description' => 'nullable|string',
            'description_lv' => 'nullable|string',
        ]);

        $release->update($validated);

        return redirect()->route('admin-releases-edit', $release->id)
            ->with('success', 'Release updated successfully.');
    }

    public function updateCover(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $release = Release::findOrFail($id);
        $request->validate([
            'cover' => 'required|file|mimes:webp|max:2048',
        ]);
        $filename = 'cover.webp';
        $directory = "releases/{$release->release_type}/{$release->id}";
        $path = $directory . '/' . $filename;
        // ensure directory exists
        Storage::disk('public')->makeDirectory($directory);
        // get uploaded file
        $file = $request->file('cover');
        // store file with fixed name
        Storage::disk('public')->put($path, file_get_contents($file));

        return response()->json([
            'success' => true,
            'cover_url' => Storage::url($path) . '?t=' . time(),
        ]);
    }

    public function updateArtists(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $release = Release::findOrFail($id);
        $validated = $request->validate([
            'artist_ids' => ['array'],
            'artist_ids.*' => ['exists:artists,id']
        ]);
        $release->artists()->sync(
            $validated['artist_ids'] ?? []
        );

        return response()->json([
            'success' => true
        ]);
    }

    /***
     * Updates release's tracklist.
     *
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Throwable
     */
    public function updateTracks(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $release = Release::findOrFail($id);
        $validated = $request->validate([
            'tracks' => ['array'],
            'tracks.*.id' => [
                'required',
                'exists:tracks,id'
            ],
            'tracks.*.track_position' => [
                'required',
                'integer',
                'min:1'
            ],
        ]);

        DB::transaction(function () use ($release, $validated) {
            $submittedTrackIds = collect($validated['tracks'])
                                ->pluck('id')
                                ->toArray();

            // step 1: remove tracks deleted from UI
            $release->tracks()
                ->whereNotIn('tracks.id', $submittedTrackIds)
                ->detach();

            // step 2: attach newly added tracks
            $existingTrackIds = $release->tracks()
                                ->pluck('tracks.id')
                                ->toArray();
            foreach ($validated['tracks'] as $trackData) {
                if (!in_array($trackData['id'], $existingTrackIds)) {
                    $release->tracks()->attach(
                        $trackData['id'],
                        [
                            'track_position' =>
                                $trackData['track_position']
                        ]
                    );
                }
            }

            // step 3: move all positions away temporarily
            foreach ($release->tracks as $track) {
                $release->tracks()->updateExistingPivot(
                    $track->id,
                    [
                        'track_position' =>
                            $track->pivot->track_position + 1000
                    ]
                );
            }
            // step 4: apply final positions
            foreach ($validated['tracks'] as $trackData) {
                $release->tracks()->updateExistingPivot(
                    $trackData['id'],
                    [
                        'track_position' =>
                            $trackData['track_position']
                    ]
                );
            }
        });

        return response()->json([
            'success' => true
        ]);
    }
}
