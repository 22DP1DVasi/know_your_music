<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Artist;
use App\Models\ArtistComment;

class ArtistCommentController extends BaseCommentController
{
    protected string $commentModel = ArtistComment::class;
    protected string $parentKey = 'artist_id';
    protected string $commentsTable = 'comments_artists';

    /**
     * Ielādē nākamo komentāru kopu.
     * @see BaseCommentController::handleGet()
     *
     * @param Artist $artist
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Artist $artist): \Illuminate\Http\JsonResponse
    {
        return $this->handleGet($artist);
    }

    /**
     * Saglabā komentāru tabulā.
     * @see BaseCommentController::handleStore()
     *
     * @param Artist $artist
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Artist $artist, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleStore($artist, $request);
    }

    /**
     * Atjauno dota komentāra tekstu un rediģēšanas laikspiedolu.
     * @see BaseCommentController::handleUpdate()
     *
     * @param Artist $artist
     * @param ArtistComment $comment
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Artist $artist, ArtistComment $comment, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleUpdate($artist, $comment, $request);
    }

    /**
     * Izdzēš doto komentāru.
     * @see BaseCommentController::handleDestroy()
     *
     * @param Artist $artist
     * @param ArtistComment $comment
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Artist $artist, ArtistComment $comment): \Illuminate\Http\JsonResponse
    {
        return $this->handleDestroy($artist, $comment);
    }
}
