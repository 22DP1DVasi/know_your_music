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
     * Method for Create.vue page.
     *
     * @return \Inertia\Response
     */
    public function create(): \Inertia\Response
    {
        return Inertia::render('Admin/Tracks/Create');
    }

    /***
     * Stores a new track.
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request): \Illuminate\Http\RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'release_date' => 'required|date',
            'duration' => 'required|date_format:H:i:s',
            'description' => 'nullable|string',
            'description_lv' => 'nullable|string',
        ]);

        Track::create($validated);

        return redirect()->route('admin-tracks-index')
            ->with('success', __('messages.track_created'));
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
                    $query->select('artists.id', 'artists.name', 'artists.slug')
                        ->orderByRaw("
                            CASE artists_tracks.role
                                WHEN 'primary' THEN 1
                                WHEN 'featured' THEN 2
                                WHEN 'producer' THEN 3
                                ELSE 4
                            END
                            ");
                },
                'releases' => function ($query) {
                    $query->with([
                        'artists:id,name,slug'
                    ])->select('releases.id', 'title', 'release_date', 'release_type');
                },
                'lyrics'
            ])
            ->findOrFail($id);

        $lyricsData = null;
        if ($track->lyrics) {
            $lyricsData = [
                'lyrics' => $track->lyrics->lyrics,
                'status' => $track->lyrics->status,
                'last_updated_by_user' => $track->lyrics->lastUpdatedByUser?->name ?? null,
            ];
        }

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
                    'banner_url' => $artist->banner_url,
                    'role' => $artist->pivot->role
                ]),

                'releases' => $track->releases->map(fn ($release) => [
                    'id' => $release->id,
                    'title' => $release->title,
                    'release_date' => $release->release_date,
                    'release_type' => $release->release_type,
                    'cover_url' => $release->cover_url,
                    'artists' => $release->artists->map(fn ($artist) => [
                        'id' => $artist->id,
                        'name' => $artist->name,
                        'slug' => $artist->slug,
                    ]),
                ]),
                'lyrics' => $lyricsData
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

        $trackData = $request->validate([
            'title' => 'required|string|max:255',
            'release_date' => 'required|date',
            'duration' => 'required|date_format:H:i:s',
            'description' => 'nullable|string',
            'description_lv' => 'nullable|string',
        ]);

        $lyricsData = $request->validate([
            'lyrics' => 'nullable|string',
            'lyrics_status' => 'nullable|in:verified,requires verification',
        ]);

        $track->update($trackData);

        // lyrics handling
        $lyricsText = $lyricsData['lyrics'] ?? null;
        $lyricsStatus = $lyricsData['lyrics_status'] ?? 'requires verification';
        $existingLyrics = $track->lyrics;

        if (!$existingLyrics && !empty($lyricsText)) {
            // no lyrics existed and textarea contains text: create new lyrics
            $track->lyrics()->create([
                'lyrics' => $lyricsText,
                'status' => $lyricsStatus,
                'last_updated_by_user' => auth()->id(),
            ]);
        } elseif ($existingLyrics && !empty($lyricsText)) {
            // lyrics already exists and text is updated: update existing
            $existingLyrics->update([
                'lyrics' => $lyricsText,
                'status' => $lyricsStatus,
                'last_updated_by_user' => auth()->id(),
            ]);
        }
        // no lyrics existed and textarea is empty
        // or lyrics exists but textarea is empty
        // do nothing

        return redirect()->route('admin-tracks-edit', $track->id)
            ->with('success', __('messages.track_updated'));
    }

    public function updateArtists(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $track = Track::findOrFail($id);
        $validated = $request->validate([
            'artists' => ['array'],
            'artists.*.id' => ['exists:artists,id'],
            'artists.*.role' => ['in:primary,featured,producer'],
        ]);

        $syncData = collect($validated['artists'])
            ->mapWithKeys(function ($artist) {
                return [
                    $artist['id'] => [
                        'role' => $artist['role']
                    ]
                ];
            })
            ->toArray();
        $track->artists()->sync($syncData ?? []);

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
