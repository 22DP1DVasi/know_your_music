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

    /**
     * @param $slug
     * @return \Inertia\Response
     * Method for show page
     */

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

    /**
     * @param $genreSlug
     * @return \Inertia\Response
     * Method for showDescription page
     */
    public function showDescription($genreSlug)
    {
        $genre = Genre::where('slug', $genreSlug)->firstOrFail();
        return Inertia::render('Genres/GenreDescription', [
            'genre' => $genre,
        ]);
    }

    /**
     * @param $slug
     * @param Request $request
     * @param GenreService $genreService
     * @return \Inertia\Response|\Inertia\ResponseFactory
     * Method for allArtists page
     */
    public function showAllArtists($slug, Request $request, GenreService $genreService)
    {
        $genre = Genre::where('slug', $slug)->firstOrFail();
        $perPage = $request->input('perPage', 24);
        $data = $genreService->getGenreArtistsPaginated($genre->id, $perPage);
        return inertia('Genres/GenreAllArtists', [
            'genre' => [
                'id' => $genre->id,
                'name' => $genre->name,
                'slug' => $genre->slug
            ],
            'artists' => $data['artists'],
            'paginationLinks' => $data['paginationLinks'],
            'currentPage' => $data['currentPage'],
            'totalPages' => $data['totalPages'],
            'perPage' => $perPage
        ]);
    }

    public function explore(Request $request)
    {
        $searchQuery = $request->input('q', '');
        $perPage = $request->input('perPage', 24);
        $sortOrder = $request->input('sort', 'asc');
        $genres = Genre::query()
            ->when($searchQuery, function ($query) use ($searchQuery) {
                $query->where('name', 'like', "%{$searchQuery}%");
            })
            ->orderBy('name', $sortOrder)
            ->paginate($perPage)
            ->withQueryString();
        return Inertia::render('Genres/GenresExplore', [
            'genres' => $genres->items(),
            'searchQuery' => $searchQuery,
            'paginationLinks' => $genres->toArray()['links'],
            'currentPage' => $genres->currentPage(),
            'totalPages' => $genres->lastPage(),
            'perPage' => $perPage,
            'sortOrder' => $sortOrder,
        ]);
    }
}
