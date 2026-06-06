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
            ->orderBy('popularity', 'desc')
            ->limit(4)
            ->get();

        return Inertia::render('HomeView', [
            'artists' => $artists
        ]);
    }

}
