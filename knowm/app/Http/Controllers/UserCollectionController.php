<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\UserCollection;
use App\Models\Track;

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

        $firstTrack = $playlist->tracks()
            ->orderBy('user_collections_tracks.track_position')
            ->first();

        return Inertia::render('Dashboard/UserPlaylistShow', [
            'playlist' => [
                'id' => $playlist->id,
                'name' => $playlist->name,
                'slug' => $playlist->slug,
                'description' => $playlist->description,
                'is_private' => $playlist->is_private,
                'cover_url' => $firstTrack->cover_url,
                'created_at' => $playlist->created_at,
                'updated_at' => $playlist->updated_at,
            ],
            'tracks' => $tracks,
            'canEdit' => $playlist->user_id === Auth::id(),
        ]);
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
}
