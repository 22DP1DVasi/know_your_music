<?php

namespace App\Http\Controllers;

use Auth;
use Inertia\Inertia;
use Request;

class FavoriteArtistController
{
    /**
     * Saņēm lietotāja mīļakos izpildītājus.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function favoriteArtists(Request $request): \Inertia\Response
    {
        $user = Auth::user();
        $artists = $user->favoriteArtists()
            ->orderBy('name')
            ->paginate(20)
            ->withQueryString();

        return Inertia::render('Dashboard/FavoriteArtists', [
            'artists' => $artists
        ]);
    }
}
