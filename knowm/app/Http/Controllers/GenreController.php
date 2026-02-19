<?php

namespace App\Http\Controllers;

use App\Models\Genre;
use App\Services\GenreService;
use Inertia\Inertia;
use Illuminate\Http\Request;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Inertia\Response;
use Inertia\ResponseFactory;

class GenreController extends Controller
{
    protected GenreService $genreService;

    /**
     * Konstruktors.
     *
     * @param GenreService $genreService
     */
    public function __construct(GenreService $genreService)
    {
        $this->genreService = $genreService;
    }

    /**
     * @param Genre $genre
     * @return Response
     */
    public function show(Genre $genre)
    {
        // iegūt pašreizējo lapu komentāriem no pieprasījuma, noklusējums ir 1
        $commentsPage = request()->input('comments_page', 1);
        $genreData = $this->genreService
            ->getGenreWithDetailsAndComments($genre, $commentsPage);

        return Inertia::render('Genres/GenreShow', [
            'genre' => $genreData
        ]);
    }

    /**
     * @param $genreSlug
     * @return Response
     */
    public function showDescription(Genre $genre): Response
    {
        return Inertia::render('Genres/GenreDescription', [
            'genre' => $genre,
        ]);
    }

    /**
     * @param Genre $genre
     * @param Request $request
     * @param GenreService $genreService
     * @return Response|ResponseFactory
     */
    public function showAllArtists(Genre $genre, Request $request, GenreService $genreService)
    {
        $perPage = $request->input('perPage', 24);
        $data = $genreService->getGenreArtistsPaginated($genre, $perPage);
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

    /**
     * @param Request $request
     * @return Response
     */
    public function explore(Request $request): Response
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
