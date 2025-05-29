<?php

use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Services\SpotifyService;
use Illuminate\Http\Request;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\ArtistController;
use App\Http\Controllers\ReleaseController;
use App\Http\Controllers\TrackController;
use App\Http\Controllers\GenreController;


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
Route::get('/', [HomeController::class, 'index'])
    ->name('home');

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

Route::get('/privacy-policy', function () {
    return Inertia::render('PrivacyPolicy');
})->name('privacy-policy');

Route::get('/terms-of-service', function () {
    return Inertia::render('TermsOfService');
})->name('terms-of-service');

Route::get('/faq', function () {
    return Inertia::render('FAQ');
})->name('faq');

Route::get('/community-guidelines', function () {
    return Inertia::render('CommunityGuidelines');
})->name('community-guidelines');

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

// page for artist's bio
Route::get('/artists/{artist}/bio', [ArtistController::class, 'showBio'])
    ->name('artist.bio');

// page for all tracks for artist
Route::get('/artists/{artist}/tracks', [ArtistController::class, 'showAllTracks'])
    ->name('artists.tracks');

// page for all releases for artist
Route::get('/artists/{artist}/releases', [ArtistController::class, 'showAllReleases'])
    ->name('artists.releases');

// release page
Route::get('/releases/{release}', [ReleaseController::class, 'show'])
    ->name('releases.show');

// track page
Route::get('/tracks/{track}', [TrackController::class, 'show'])
    ->name('tracks.show');

// genre page
Route::get('/genres/{genre}', [GenreController::class, 'show'])
    ->name('genres.show');

// page for genre's full description
Route::get('/genres/{genre}/description', [GenreController::class, 'showDescription'])
    ->name('genre.description');

// page for all artists associated with a genre
Route::get('/genres/{slug}/artists', [GenreController::class, 'showAllArtists'])
    ->name('genres.artists');

// page for artists explore
Route::get('/explore/artists', [ArtistController::class, 'explore'])
    ->name('explore.artists');

// page for releases explore
Route::get('/explore/releases', [ReleaseController::class, 'explore'])
    ->name('explore.releases');

// page for genres explore
Route::get('/explore/genres', [GenreController::class, 'explore'])
    ->name('explore.genres');

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
//Route::middleware('guest')->group(function () {
//    Route::get('login', [AuthenticatedSessionController::class, 'create'])->name('login')->middleware('auth');
//    Route::post('login', [AuthenticatedSessionController::class, 'store'])->middleware('auth');
//    Route::post('logout', [AuthenticatedSessionController::class, 'destroy'])->name('logout');
//});

// artist and release cover images routes
//Route::middleware(['auth'])->group(function () {
    Route::post('/artists/{artist}/profile-image', [ArtistController::class, 'uploadProfileImage']);
    Route::post('/artists/{artist}/banner-image', [ArtistController::class, 'uploadBannerImage']);
    Route::post('/releases/{release}/cover-image', [ReleaseController::class, 'uploadCoverImage']);
//});

// admin routes
//Route::middleware(['auth', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/admin-dashboard', [AdminController::class, 'dashboard'])->name('admin-dashboard');

    Route::get('/admin-users-index', [App\Http\Controllers\Admin\UserController::class, 'index'])->name('admin-users-index');
    Route::get('/admin-users-create', [App\Http\Controllers\Admin\UserController::class, 'create'])->name('admin-users-create');
    Route::post('/admin-users-store', [App\Http\Controllers\Admin\UserController::class, 'store'])->name('admin-users-store');
    Route::get('/admin-users-edit/{id}', [App\Http\Controllers\Admin\UserController::class, 'edit'])->name('admin-users-edit');
    Route::put('/admin-users-update/{id}', [App\Http\Controllers\Admin\UserController::class, 'update'])->name('admin-users-update');
    Route::delete('/users/{id}', [App\Http\Controllers\Admin\UserController::class, 'destroy'])->name('admin-users-destroy');

    Route::get('/admin-artists-index', [App\Http\Controllers\Admin\ArtistController::class, 'index'])->name('admin-artists-index');
    Route::get('/admin-artists-create', [App\Http\Controllers\Admin\ArtistController::class, 'create'])->name('admin-artists-create');
    Route::post('/admin-artists-store', [App\Http\Controllers\Admin\ArtistController::class, 'store'])->name('admin-artists-store');
    Route::get('/admin-artists-edit/{id}', [App\Http\Controllers\Admin\ArtistController::class, 'edit'])->name('admin-artists-edit');
    Route::put('/admin-artists-update/{id}', [App\Http\Controllers\Admin\ArtistController::class, 'update'])->name('admin-artists-update');
    Route::delete('/artists/{id}', [App\Http\Controllers\Admin\ArtistController::class, 'destroy'])->name('admin-artists-destroy');



//    Route::resource('/admin-users-index', UserController::class)->except(['show']);
//    Route::resource('roles', RoleController::class)->except(['show']);
    Route::resource('artists', ArtistController::class)->except(['show']);
    Route::resource('releases', ReleaseController::class)->except(['show']);
    Route::resource('tracks', TrackController::class)->except(['show']);
//    Route::resource('genres', GenreController::class)->except(['show']);
//    Route::resource('lyrics', LyricController::class)->except(['show']);
//});


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
