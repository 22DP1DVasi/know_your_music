<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\UserCollection;
use App\Models\Track;
use Illuminate\Support\Str;

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
            $query->orderBy('user_collections_tracks.track_position')
                ->limit(1);
        }])
            ->orderBy('created_at', 'desc')
            ->paginate(20)
            ->withQueryString();

        return Inertia::render('Dashboard/UserPlaylists', [
            'playlists' => $playlists
        ]);
    }

    public function show(UserCollection $playlist)
    {
        if ($playlist->is_private && $playlist->user_id !== Auth::id()) {
            abort(403, 'This playlist is private.');
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
            ],
            'tracks' => $tracks,
            'canEdit' => $playlist->user_id === Auth::id(),
        ]);
    }

    /**
     * Atjaunināt norādīto atskaņošanas sarakstu.
     */
    public function update(Request $request, UserCollection $playlist)
    {
        // pārbaudīt, vai lietotājam pieder atskaņošanas saraksts
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
        // atjaunināt atsk. sarakstu
        $playlist->update($validated);

        return redirect()->route('playlists.show', $playlist->fresh())
            ->with('success', 'Playlist updated successfully.');
    }

    public function removeTrack(UserCollection $playlist, Track $track)
    {
        // pārbaudīt, vai lietotājam pieder kolekcija
        if ($playlist->user_id !== Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'You are not authorized to remove tracks from this playlist.'
            ], 403);
        }

        // pārbaudīt, vai kolekcijā ir šī dziesma
        if (!$playlist->tracks()->where('track_id', $track->id)->exists()) {
            return response()->json([
                'success' => false,
                'message' => 'This track is not in the playlist.'
            ], 404);
        }

        // moņemt dziesmu
        $playlist->tracks()->detach($track->id);

        // pārkārtot atlikušās dziesmas
        $remainingTracks = $playlist->tracks()
            ->orderBy('track_position')
            ->get();

        foreach ($remainingTracks as $index => $remainingTrack) {
            $playlist->tracks()->updateExistingPivot($remainingTrack->id, [
                'track_position' => $index + 1
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Track removed successfully.'
        ]);
    }

    /**
     * Iegūst lietotāja atskaņošanas sarakstus priekš AddToPlaylistModal.vue mod. logam.
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
     * Pievieno dziesmu esošam atskaņošanas sarakstam.
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
        // pārbaudīt, vai dziesma jau pastāv atsk. sarakstā
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

    /**
     * Izveidot jaunu atsk. sarakstu un pievienot tam dziesmu.
     */
    public function createPlaylistWithTrack(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'is_private' => 'required|boolean',
            'track_id' => 'required|exists:tracks,id'
        ]);

        // izveidot sarakstu
        $playlist = UserCollection::create([
            'user_id' => Auth::id(),
            'name' => $request->name,
//            'slug' => Str::slug($request->name) . '-' . Str::random(6),
            'description' => null,
            'is_private' => $request->is_private,
        ]);
        // pievienot dziesmu
        $playlist->tracks()->attach($request->track_id, [
            'track_position' => 1
        ]);
        // ielādēt dziesmu skaitu atbildei
        $playlist->loadCount('tracks');
        // Get cover_url from the added track
//        $track = Track::find($request->track_id);
//        $coverUrl = $track->cover_url;

        return response()->json([
            'success' => true,
            'message' => 'Playlist created and track added successfully.',
            'playlist' => [
                'id' => $playlist->id,
                'name' => $playlist->name,
                'slug' => $playlist->slug,
                'is_private' => $playlist->is_private,
                'tracks_count' => $playlist->tracks_count,
                'cover_url' => $playlist->cover_url
            ]
        ]);
    }
}
