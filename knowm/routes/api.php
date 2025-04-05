<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\User;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Public routes (no authentication needed)
Route::middleware(['throttle:60,1'])->group(function () {
    // Email availability check
    Route::get('/check-email', function (Request $request) {
        $request->validate([
            'email' => 'required|email|max:255'
        ]);

        return response()->json([
            'exists' => User::where('email', $request->email)->exists()
        ]);
    });
});

// Protected routes (require authentication)
Route::middleware('auth:sanctum')->group(function () {
    // Authenticated user data
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Add other protected API endpoints here
});
