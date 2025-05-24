<?php

namespace App\Http\Controllers;

use App\Models\Genre;
use App\Services\GenreService;
use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;

class GenreController extends Controller
{
    protected $genreService;

    public function __construct(GenreService $genreService)
    {
        $this->genreService = $genreService;
    }

    public function show($slug)
    {
        $genre = Genre::where('slug', $slug)->firstOrFail();
        $genreData = $this->genreService->getGenreWithDetails($genre->id);
        return Inertia::render('Genres/GenreShow', [
            'genre' => $genreData['genre'],
            'artists' => $genreData['artists'],
            'tracks' => $genreData['tracks'],
            'releases' => $genreData['releases'],
            'totalArtists' => $genreData['total_artists'],
            'totalTracks' => $genreData['total_tracks'],
            'totalReleases' => $genreData['total_releases'],
        ]);
    }

    public function showDescription($genreSlug)
    {
        $genre = Genre::where('slug', $genreSlug)->firstOrFail();
        return Inertia::render('Genres/GenreDescription', [
            'genre' => $genre,
        ]);
    }
}
