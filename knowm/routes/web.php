<?php

use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Services\SpotifyService;
use Illuminate\Http\Request;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\ArtistController;
use App\Http\Controllers\ReleaseController;
use App\Http\Controllers\TrackController;

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

// searches routes
Route::get('/search', [SearchController::class, 'index'])
    ->name('search');

Route::get('/search/artists', [SearchController::class, 'artists'])
    ->name('search.artists');

Route::get('/search/releases', [SearchController::class, 'releases'])
    ->name('search.releases');

Route::get('/search/tracks', [SearchController::class, 'tracks'])
    ->name('search.tracks');

Route::get('/search/lyrics', [SearchController::class, 'lyrics'])
    ->name('search.lyrics');

// show pages (profiles)
Route::get('/artists/{artist}', [ArtistController::class, 'show'])
    ->name('artists.show');

Route::get('/releases/{release}', [ReleaseController::class, 'show'])
    ->name('releases.show');

Route::get('/tracks/{track}', [TrackController::class, 'show'])
    ->name('tracks.show');

// page for artist's bio
Route::get('/artists/{artist}/bio', [ArtistController::class, 'showBio'])
    ->name('artist.bio');

// page for all tracks for artist
Route::get('/artists/{artist}/tracks', [ArtistController::class, 'showAllTracks'])
    ->name('artists.tracks');

// page for all releases for artist
Route::get('/artists/{artist}/releases', [ArtistController::class, 'showAllReleases'])
    ->name('artists.releases');

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

// artist and release cover images routes
Route::middleware(['auth'])->group(function () {
    Route::post('/artists/{artist}/profile-image', [ArtistController::class, 'uploadProfileImage']);
    Route::post('/artists/{artist}/banner-image', [ArtistController::class, 'uploadBannerImage']);
    Route::post('/releases/{release}/cover-image', [ReleaseController::class, 'uploadCoverImage']);
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
