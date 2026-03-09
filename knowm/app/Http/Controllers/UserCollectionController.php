<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class UserCollectionController extends Controller
{
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
}
