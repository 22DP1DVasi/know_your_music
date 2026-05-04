<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\UserCollection;
use App\Models\Track;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Throwable;

class UserCollectionController extends Controller
{
    /***
     * Metode priekš UserPlaylists.vue lapas.
     * Saņem lietotāja kolekcijas attēlošanai kopīgā sarakstā.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function playlists(Request $request): \Inertia\Response
    {
        $user = Auth::user();
        $playlists = $user->collections()
        ->with(['tracks' => function($query) {
            $query->orderBy('user_collections_tracks.track_position');
        }])
            ->orderBy('created_at', 'desc')
            ->paginate(20)
            ->withQueryString();

        return Inertia::render('Dashboard/UserPlaylists', [
            'playlists' => $playlists
        ]);
    }

    /***
     * Metode priekš UserPlaylistShow.vue lapas.
     *
     * @param User $user
     * @param UserCollection $playlist
     * @return \Inertia\Response
     */
    public function show(User $user, UserCollection $playlist): \Inertia\Response
    {
        if ($playlist->is_private && $playlist->user_id !== Auth::id()) {
            abort(404);
        }
        $tracks = $playlist->tracks()
            ->with(['artists:id,name,slug'])
            ->orderBy('user_collections_tracks.track_position')
            ->paginate(20);

        return Inertia::render('Dashboard/UserPlaylistShow', [
            'playlist' => [
                'id' => $playlist->id,
                'name' => $playlist->name,
                'slug' => $playlist->slug,
                'description' => $playlist->description,
                'is_private' => $playlist->is_private,
                'cover_url' => $playlist->cover_url,
                'created_at' => $playlist->created_at,
                'updated_at' => $playlist->updated_at,
                'user' => [
                    'id' => $playlist->user->id,
                    'slug' => $playlist->user->slug,
                ],
            ],
            'tracks' => $tracks
        ]);
    }

    /***
     * Atjaunināt norādīto kolekciju.
     *
     * @param Request $request
     * @param User $user
     * @param UserCollection $playlist
     * @return JsonResponse|\Illuminate\Http\RedirectResponse
     */
    public function update(Request $request, User $user, UserCollection $playlist): JsonResponse|\Illuminate\Http\RedirectResponse
    {
        // pārbaudīt, vai lietotājam pieder kolekcija
        if ($playlist->user_id !== Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to edit this playlist.'
            ], 403);
        }
        // validācija
        $validated = $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string|max:255',
            'is_private' => 'required|boolean',
        ]);
        // ja tika nomainīts nosaukums, jāmaina arī tekstveida identifikators
        if ($validated['name'] !== $playlist->name) {
            $validated['slug'] = $playlist->generateUniqueSlug($validated['name']);
        }
        // atjaunināt kolekciju
        $playlist->update($validated);

        return redirect()->route('playlists.show', [
            'user' => $playlist->user->slug,
            'playlist' => $playlist->slug,
        ])->with('success', 'Playlist updated successfully.');
    }

    /***
     * Dzēst kolekciju.
     *
     * @param User $user
     * @param UserCollection $playlist
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(User $user, UserCollection $playlist): \Illuminate\Http\RedirectResponse
    {
        // pārbaudīt, vai lietotājam pieder atskaņošanas saraksts
        if ($playlist->user_id !== Auth::id()) {
            abort(403, 'You are not authorized to delete this playlist.');
        }
        // dzēst visas dziesmu relācijas
        $playlist->tracks()->detach();
        // dzēst kolekciju
        $playlist->delete();
        return redirect()->route('dashboard.playlists')
            ->with('success', 'Playlist deleted successfully.');
    }

    /***
     * Noņem ierakstu no kolekcijas.
     *
     * @param User $user
     * @param UserCollection $playlist
     * @param Track $track
     * @return JsonResponse
     * @throws Throwable
     */
    public function removeTrack(User $user, UserCollection $playlist, Track $track): \Illuminate\Http\JsonResponse
    {
        if ($playlist->user_id !== auth()->id()) {
            abort(403, 'You are not authorized to edit this playlist.');
        }
        DB::transaction(function () use ($playlist, $track) {
            // iegūt pašreizējo pozīciju
            $pivot = DB::table('user_collections_tracks')
                ->where('user_collection_id', $playlist->id)
                ->where('track_id', $track->id)
                ->first();
            if (!$pivot) {
                return;
            }
            $removedPosition = $pivot->track_position;

            // noņemt dziesmu
            $playlist->tracks()->detach($track->id);
            // pārbīdīt dziesmu pozīcijas
            DB::table('user_collections_tracks')
                ->where('user_collection_id', $playlist->id)
                ->where('track_position', '>', $removedPosition)
                ->decrement('track_position');
        });
        return response()->json([
            'success' => true
        ]);
    }

    /**
     * Iegūst lietotāja kolekcijas priekš AddToPlaylistModal.vue mod. logam.
     */
    public function getUserPlaylists(Request $request)
    {
        $trackId = $request->input('track_id');
        $playlists = Auth::user()->collections()
            ->withCount('tracks')
            ->withCount([
                'tracks as contains_track' => function ($query) use ($trackId) {
                    $query->where('tracks.id', $trackId);
                }
            ])
            ->orderBy('name')
            ->get()
            ->map(function($playlist) {
                return [
                    'id' => $playlist->id,
                    'name' => $playlist->name,
                    'slug' => $playlist->slug,
                    'is_private' => $playlist->is_private,
                    'tracks_count' => $playlist->tracks_count,
                    'cover_url' => $playlist->cover_url,
                    'contains_track' => (bool) $playlist->contains_track,
                ];
            });

        return response()->json([
            'playlists' => $playlists
        ]);
    }

    /**
     * Pievieno dziesmu esošai kolekcijai.
     */
    public function addTrackToPlaylist(Request $request, UserCollection $playlist)
    {
        if ($playlist->user_id !== Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to modify this playlist.'
            ], 403);
        }
        $request->validate([
            'track_id' => 'required|exists:tracks,id'
        ]);
        // pārbaudīt, vai dziesma jau pastāv kolekcijā
        // nestrādā?
        if ($playlist->tracks()->where('track_id', $request->track_id)->exists()) {
            return response()->json([
                'success' => false,
                'message' => 'Track already exists in this playlist.'
            ], 422);
        }

        // iegūt nākamo pozīciju
        $maxPosition = $playlist->tracks()->max('track_position') ?? 0;
        $nextPosition = $maxPosition + 1;
        // pievienot dziesmu
        $playlist->tracks()->attach($request->track_id, [
            'track_position' => $nextPosition
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Track added to playlist successfully.'
        ]);
    }

    /***
     * Creates new playlist.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function createPlaylist(Request $request): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string|max:255',
            'is_private' => 'required|boolean',
        ]);

        $playlist = UserCollection::create([
            'user_id' => Auth::id(),
            'name' => $request->name,
            'description' => $request->description,
            'is_private' => $request->is_private,
        ]);

        $playlist->loadCount('tracks');
        return response()->json([
            'success' => true,
            'message' => 'Playlist created successfully.',
            'playlist' => [
                'id' => $playlist->id,
                'name' => $playlist->name,
                'slug' => $playlist->slug,
                'description' => $playlist->description,
                'is_private' => $playlist->is_private,
                'tracks_count' => $playlist->tracks_count,
                'cover_url' => $playlist->cover_url,
                'created_at' => $playlist->created_at,
                'updated_at' => $playlist->updated_at,
            ]
        ]);
    }

    /***
     * Creates new playlist and adds selected track to it.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function createPlaylistWithTrack(Request $request): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'description' => 'nullable|string|max:255',
            'is_private' => 'required|boolean',
            'track_id' => 'required|exists:tracks,id'
        ]);
        $playlist = UserCollection::create([
            'user_id' => Auth::id(),
            'name' => $request->name,
            'description' => $request->description,
            'is_private' => $request->is_private,
        ]);

        // pievienot dziesmu
        $playlist->tracks()->attach($request->track_id, [
            'track_position' => 1
        ]);

        $playlist->loadCount('tracks');
        return response()->json([
            'success' => true,
            'message' => 'Playlist created and track added successfully.',
            'playlist' => [
                'id' => $playlist->id,
                'name' => $playlist->name,
                'slug' => $playlist->slug,
                'description' => $playlist->description,
                'is_private' => $playlist->is_private,
                'tracks_count' => $playlist->tracks_count,
                'cover_url' => $playlist->cover_url,
                'created_at' => $playlist->created_at,
                'updated_at' => $playlist->updated_at,
            ]
        ]);
    }
}
