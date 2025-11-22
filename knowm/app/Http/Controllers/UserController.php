<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use App\Models\User;


class UserController extends Controller
{
    /**
     * Display the specified user.
     */
    public function show(User $user)
    {
        $user->load('roles');

        return Inertia::render('Users/Show', [
            'user' => $user,
            'isAdmin' => $user->roles()->where('role_id', 1)->exists(),
            'roles' => $user->roles,
        ]);
    }
}
