<?php

use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Services\SpotifyService;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Lyrics;
use Illuminate\Http\Request;
use App\Http\Controllers\SearchController;

//Route::get('/', function () {
//    return Inertia::render('Welcome', [
//        'canLogin' => Route::has('login'),
//        'canRegister' => Route::has('register'),
//        'laravelVersion' => Application::VERSION,
//        'phpVersion' => PHP_VERSION,
//    ]);
//});
//
//Route::get('/dashboard', function () {
//    return Inertia::render('Dashboard');
//})->middleware(['auth', 'verified'])->name('dashboard');
//
//Route::middleware('auth')->group(function () {
//    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
//    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
//    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
//});

// pages routes
Route::get('/', function () {
    return Inertia::render('HomeView');
})->name('home');

Route::get('/login', function () {
    return Inertia::render('Login');
})->name('login');

Route::get('/signup', function () {
    return Inertia::render('Auth/Register');
})->name('signup');

Route::get('/about', function () {
    return Inertia::render('AboutUs');
})->name('about');

Route::get('/contact', function () {
    return Inertia::render('ContactUs');
})->name('contact');

Route::get('/faq', function () {
    return Inertia::render('FAQ');
})->name('faq');

// search route
Route::get('/search', [SearchController::class, 'index'])
    ->name('search');

// user account settings
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', function () {
        return inertia('Dashboard');
    })->name('dashboard');

    // profile routes
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// authentication routes
Route::middleware('guest')->group(function () {
    Route::get('login', [AuthenticatedSessionController::class, 'create'])->name('login');
    Route::post('login', [AuthenticatedSessionController::class, 'store']);
    Route::post('logout', [AuthenticatedSessionController::class, 'destroy'])->name('logout');
});

// testing Spotify API
Route::get('/test-spotify', function () {
    $spotify = new SpotifyService();

    // Test token
    $token = $spotify->getAccessToken();
    echo "Token: $token<br><br>";

    // Test artist search
    $results = $spotify->searchArtists('Radiohead');
    echo "<pre>";
    print_r($results);
    echo "</pre>";

    // If you want to see a specific artist's albums:
    if (!empty($results->artists->items)) {
        $artistId = $results->artists->items[0]->id;
        $albums = $spotify->getArtistAlbums($artistId);
        print_r($albums);
    }
});

require __DIR__.'/auth.php';
