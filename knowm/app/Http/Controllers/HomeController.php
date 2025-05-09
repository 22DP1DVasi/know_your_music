<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;

class HomeController
{
    public function index()
    {
        return Inertia::render('HomeView', [
            'auth' => [
                'user' => auth()->check() ? auth()->user()->load('roles') : null
            ],
            'isAdmin' => auth()->check() && auth()->user()->roles()->where('id', 1)->exists()
        ]);
    }

}
