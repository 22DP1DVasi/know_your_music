<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

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
            ->when($request->search, function ($query, $search) {
                $query->where('name', 'like', "%{$search}%");
            })
            ->orderBy('name', $request->sort ?? 'asc')
            ->paginate(16)
            ->withQueryString();

        return Inertia::render('Dashboard/FavoriteArtists', [
            'artists' => $artists,
            'filters' => [
                'search' => $request->search,
                'sort' => $request->sort
            ]
        ]);
    }
}
