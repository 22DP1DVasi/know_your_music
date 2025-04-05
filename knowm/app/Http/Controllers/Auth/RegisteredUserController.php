<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\RegisterUserRequest;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;
use Inertia\Response;

class RegisteredUserController extends Controller
{
    /**
     * Display the registration view.
     */
    public function create(): Response
    {
        // Inertia.js - library
        // Inertia::render() renders the specified component from resources/js/Pages
        return Inertia::render('Auth/Register');
    }

    /**
     * Handle an incoming registration request.
     */
    // Request automatically validates data before the method is executed
    public function store(RegisterUserRequest $request): RedirectResponse
    {
        $user = User::create([
            'name' => $request->validated('name'),
            'email' => $request->validated('email'),
            'password' => Hash::make($request->validated('password')),
        ]);

        event(new Registered($user));   // triggers built-in request

        Auth::login($user);     // logins newly created user

        return redirect(route('home', absolute: false));    // redirects to home page with relative URL
    }
}
