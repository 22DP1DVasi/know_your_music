<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;
use App\Models\Artist;

class HomeController
{
    public function index()
    {
        $artists = Artist::query()
            ->whereIn('id', [1, 2, 3, 74])
            ->orderBy('name')
            ->get();

        return Inertia::render('HomeView', [
            'artists' => $artists
        ]);
    }

}
