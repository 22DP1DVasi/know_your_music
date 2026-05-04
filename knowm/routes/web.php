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
use App\Http\Controllers\ArtistCommentController;
use App\Http\Controllers\ReleaseCommentController;
use App\Http\Controllers\TrackCommentController;
use App\Http\Controllers\GenreCommentController;
use App\Http\Controllers\FavoriteArtistController;
use App\Http\Controllers\UserCollectionController;
//use Illuminate\Support\Facades\App;

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

// lapas ceļi
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

// meklēšanas ceļi
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


// informācijas lapas (izpildītāji, žanri, albumi, dziesmas)


// izpildītāja inf. lapa
Route::get('/artists/{artist}', [ArtistController::class, 'show'])
    ->name('artists.show');

// lapa izpildītāja biogrāfijai
Route::get('/artists/{artist:slug}/bio', [ArtistController::class, 'showBio'])
    ->name('artist.bio');

// izpildītāja visu dziesmu lapa
Route::get('/artists/{artist:slug}/tracks', [ArtistController::class, 'showAllTracks'])
    ->name('artists.tracks');

// izpildītāja visu albumu lapa
Route::get('/artists/{artist:slug}/releases', [ArtistController::class, 'showAllReleases'])
    ->name('artists.releases');

// komentāri izpildītāja lapai
Route::prefix('artists/{artist}')->group(function () {
    Route::get('/comments', [ArtistCommentController::class, 'get']);
    Route::post('/comments', [ArtistCommentController::class, 'store'])
        ->middleware('auth');
    Route::put('/comments/{comment}', [ArtistCommentController::class, 'update'])
        ->middleware('auth');
    Route::delete('/comments/{comment}', [ArtistCommentController::class, 'destroy'])
        ->middleware('auth');
});

// izpildtītāja pievienošana/noņemšana no mīļāko izpildītāju saraksta
Route::post('/artists/{artist}/favorite', [ArtistController::class, 'addFavorite'])
    ->name('artists.favorite.store')
    ->middleware('auth');
Route::delete('/artists/{artist}/favorite', [ArtistController::class, 'removeFavorite'])
    ->name('artists.favorite.destroy')
    ->middleware('auth');


// albuma inf. lapa
Route::get('/releases/{release}', [ReleaseController::class, 'show'])
    ->name('releases.show');

// albuma apraksta lapa
Route::get('/releases/{release:slug}/description', [ReleaseController::class, 'showDescription'])
    ->name('releases.description');

// komentāri albuma lapai
Route::prefix('releases/{release}')->group(function () {
    Route::get('/comments', [ReleaseCommentController::class, 'get']);
    Route::post('/comments', [ReleaseCommentController::class, 'store'])
        ->middleware('auth');
    Route::put('/comments/{comment}', [ReleaseCommentController::class, 'update'])
        ->middleware('auth');
    Route::delete('/comments/{comment}', [ReleaseCommentController::class, 'destroy'])
        ->middleware('auth');
});

// dziesmas inf. lapa
Route::get('/tracks/{track}', [TrackController::class, 'show'])
    ->name('tracks.show');
Route::get('/tracks/{track:slug}/description', [TrackController::class, 'showDescription'])
    ->name('tracks.description');

// komentāri dziesmas lapai
Route::prefix('tracks/{track}')->group(function () {
    Route::get('/comments', [TrackCommentController::class, 'get']);
    Route::post('/comments', [TrackCommentController::class, 'store'])
        ->middleware('auth');
    Route::put('/comments/{comment}', [TrackCommentController::class, 'update'])
        ->middleware('auth');
    Route::delete('/comments/{comment}', [TrackCommentController::class, 'destroy'])
        ->middleware('auth');
});

// žanra inf. lapa
Route::get('/genres/{genre}', [GenreController::class, 'show'])
    ->name('genres.show');

// žanra pilna apraksta lapa
Route::get('/genres/{genre}/description', [GenreController::class, 'showDescription'])
    ->name('genre.description');

// lapa priekš visiem izpildītājiem, kuri ir saistīti ar šo žanru
Route::get('/genres/{genre}/artists', [GenreController::class, 'showAllArtists'])
    ->name('genres.artists');

// komentāri žanra lapai
Route::prefix('genres/{genre}')->group(function () {
    Route::get('/comments', [GenreCommentController::class, 'get']);
    Route::post('/comments', [GenreCommentController::class, 'store'])
        ->middleware('auth');
    Route::put('/comments/{comment}', [GenreCommentController::class, 'update'])
        ->middleware('auth');
    Route::delete('/comments/{comment}', [GenreCommentController::class, 'destroy'])
        ->middleware('auth');
});

// lapa izpildītāju izpētīšanai
Route::get('/explore/artists', [ArtistController::class, 'explore'])
    ->name('explore.artists');

// lapa albumu izpētīšanai
Route::get('/explore/releases', [ReleaseController::class, 'explore'])
    ->name('explore.releases');

// lapa žanru izpētīšanai
Route::get('/explore/genres', [GenreController::class, 'explore'])
    ->name('explore.genres');

// lokalizācija / locale
Route::post('/locale', function (Request $request) {
    $locale = (string) $request->input('locale');
    abort_unless(in_array($locale, ['en', 'lv'], true), 400);
    session(['locale' => $locale]);

    return response()->noContent();
});

// playlist/collection page - out of auth middleware because it is shareable and guests can see it too
Route::get('/{user:slug}/playlists/{playlist:slug}', [UserCollectionController::class, 'show'])
    ->name('playlists.show');

// lietotāja konta ceļi
Route::middleware('auth')->group(function () {
    // pārskats
    Route::get('/dashboard', [ProfileController::class, 'index'])->name('dashboard');

    // profila iestatījumi
    Route::get('/dashboard/settings', [ProfileController::class, 'edit'])->name('settings.edit');
    Route::patch('/dashboard/settings', [ProfileController::class, 'update'])->name('settings.update');
    Route::delete('/dashboard/settings', [ProfileController::class, 'destroy'])->name('settings.destroy');

    Route::post('/dashboard/settings/avatar', [ProfileController::class, 'updateAvatar'])->name('settings.avatar.update');
    Route::delete('/dashboard/settings/avatar', [ProfileController::class, 'destroyAvatar'])->name('settings.avatar.destroy');

    // izlases
    Route::get('/dashboard/favorites/artists', [FavoriteArtistController::class, 'favoriteArtists'])
        ->name('dashboard.favorites.artists');

    // kolekcijas
    Route::get('/dashboard/playlists', [UserCollectionController::class, 'playlists'])
        ->name('dashboard.playlists');

    Route::put('/{user:slug}/playlists/{playlist:slug}', [UserCollectionController::class, 'update'])
        ->name('playlists.update');
    Route::delete('/{user:slug}/playlists/{playlist:slug}', [UserCollectionController::class, 'destroy'])
        ->name('playlists.destroy');
    Route::delete('/{user:slug}/playlists/{playlist:slug}/tracks/{track:id}', [UserCollectionController::class, 'removeTrack'])
        ->name('playlists.tracks.destroy');

    Route::get('/playlists/user/list', [UserCollectionController::class, 'getUserPlaylists'])
        ->name('playlists.user.list');
    Route::post('/playlists/{playlist:slug}/add-track', [UserCollectionController::class, 'addTrackToPlaylist'])
        ->name('playlists.add-track');
    Route::post('/playlists', [UserCollectionController::class, 'createPlaylist'])
        ->name('playlists.store');
    Route::post('/playlists/with-track', [UserCollectionController::class, 'createPlaylistWithTrack'])
        ->name('playlists.store.with-track');
});

// authentication routes
//Route::middleware('guest')->group(function () {
//    Route::get('login', [AuthenticatedSessionController::class, 'create'])->name('login')->middleware('auth');
//    Route::post('login', [AuthenticatedSessionController::class, 'store'])->middleware('auth');
//    Route::post('logout', [AuthenticatedSessionController::class, 'destroy'])->name('logout');
//});

// artist and release cover images routes
//Route::middleware(['auth'])->group(function () {
//    Route::post('/artists/{artist}/profile-image', [ArtistController::class, 'uploadProfileImage']);
//    Route::post('/artists/{artist}/banner-image', [ArtistController::class, 'uploadBannerImage']);
//    Route::post('/releases/{release}/cover-image', [ReleaseController::class, 'uploadCoverImage']);
//});

// admin routes
//Route::middleware(['auth', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/admin-dashboard', [AdminController::class, 'dashboard'])->name('admin-dashboard');

    Route::get('/admin-users-index', [App\Http\Controllers\Admin\UserController::class, 'index'])->name('admin-users-index');
    Route::get('/admin-users-create', [App\Http\Controllers\Admin\UserController::class, 'create'])->name('admin-users-create');
    Route::post('/admin-users-store', [App\Http\Controllers\Admin\UserController::class, 'store'])->name('admin-users-store');
    Route::get('/admin-users-edit/{id}', [App\Http\Controllers\Admin\UserController::class, 'edit'])->name('admin-users-edit');
    Route::put('/admin-users-update/{id}', [App\Http\Controllers\Admin\UserController::class, 'update'])->name('admin-users-update');
    Route::post('/admin/users/{user}/roles', [App\Http\Controllers\Admin\UserController::class, 'storeRoles'])->name('admin-users-roles-store');
    Route::delete('/admin/users/{user}/roles/{role}', [App\Http\Controllers\Admin\UserController::class, 'destroyUserRole'])->name('admin-users-roles-destroy');
    Route::delete('/users/{id}', [App\Http\Controllers\Admin\UserController::class, 'destroy'])->name('admin-users-destroy');

    Route::get('/admin-roles-index', [App\Http\Controllers\Admin\RoleController::class, 'index'])->name('admin-roles-index');
    Route::get('/admin-roles-create', [App\Http\Controllers\Admin\RoleController::class, 'create'])->name('admin-roles-create');
    Route::post('/admin-roles-store', [App\Http\Controllers\Admin\RoleController::class, 'store'])->name('admin-roles-store');
    Route::get('/admin-roles-edit/{id}', [App\Http\Controllers\Admin\RoleController::class, 'edit'])->name('admin-roles-edit');
    Route::put('/admin-roles-update/{id}', [App\Http\Controllers\Admin\RoleController::class, 'update'])->name('admin-roles-update');
    Route::delete('/roles/{id}', [App\Http\Controllers\Admin\RoleController::class, 'destroy'])->name('admin-roles-destroy');

    Route::get('/admin-artists-index', [App\Http\Controllers\Admin\ArtistController::class, 'index'])->name('admin-artists-index');
    Route::get('/admin-artists-create', [App\Http\Controllers\Admin\ArtistController::class, 'create'])->name('admin-artists-create');
    Route::post('/admin-artists-store', [App\Http\Controllers\Admin\ArtistController::class, 'store'])->name('admin-artists-store');
    Route::get('/admin-artists-edit/{id}', [App\Http\Controllers\Admin\ArtistController::class, 'edit'])->name('admin-artists-edit');
    Route::put('/admin-artists-update/{id}', [App\Http\Controllers\Admin\ArtistController::class, 'update'])->name('admin-artists-update');
    Route::delete('/artists/{id}', [App\Http\Controllers\Admin\ArtistController::class, 'destroy'])->name('admin-artists-destroy');
    Route::put('/admin/artists/{id}/update-image', [App\Http\Controllers\Admin\ArtistController::class, 'updateImage'])->name('admin-artists-update-image');



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
