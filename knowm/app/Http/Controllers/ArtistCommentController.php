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

    public function get(Artist $artist): \Illuminate\Http\JsonResponse
    {
        return $this->handleGet($artist);
    }

    public function store(Artist $artist, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleStore($artist, $request);
    }

    public function update(Artist $artist, ArtistComment $comment, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleUpdate($artist, $comment, $request);
    }

    public function destroy(Artist $artist, ArtistComment $comment): \Illuminate\Http\JsonResponse
    {
        return $this->handleDestroy($artist, $comment);
    }
}
