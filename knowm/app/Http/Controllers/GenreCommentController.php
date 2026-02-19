<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Genre;
use App\Models\GenreComment;

class GenreCommentController extends BaseCommentController
{
    protected string $commentModel = GenreComment::class;
    protected string $parentKey = 'genre_id';
    protected string $commentsTable = 'comments_genres';

    /**
     * Ielādē nākamo komentāru kopu.
     * @see BaseCommentController::handleGet()
     *
     * @param Genre $genre
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Genre $genre): \Illuminate\Http\JsonResponse
    {
        return $this->handleGet($genre);
    }

    /**
     * Saglabā komentāru tabulā.
     * @see BaseCommentController::handleStore()
     *
     * @param Genre $genre
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Genre $genre, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleStore($genre, $request);
    }

    /**
     * Atjauno dota komentāra tekstu un rediģēšanas laikspiedolu.
     * @see BaseCommentController::handleUpdate()
     *
     * @param Genre $genre
     * @param GenreComment $comment
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Genre $genre, GenreComment $comment, Request $request):
    \Illuminate\Http\JsonResponse
    {
        return $this->handleUpdate($genre, $comment, $request);
    }

    /**
     * Izdzēš doto komentāru.
     * @see BaseCommentController::handleDestroy()
     *
     * @param Genre $genre
     * @param GenreComment $comment
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Genre $genre, GenreComment $comment): \Illuminate\Http\JsonResponse
    {
        return $this->handleDestroy($genre, $comment);
    }
}
