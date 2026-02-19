<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\Track;
use App\Models\TrackComment;

class TrackCommentController extends BaseCommentController
{
    protected string $commentModel = TrackComment::class;
    protected string $parentKey = 'track_id';
    protected string $commentsTable = 'comments_tracks';

    /**
     * Ielādē nākamo komentāru kopu.
     * @see BaseCommentController::handleGet()
     *
     * @param Track $track
     * @return JsonResponse
     */
    public function get(Track $track): \Illuminate\Http\JsonResponse
    {
        return $this->handleGet($track);
    }

    /**
     * Saglabā komentāru tabulā.
     * @see BaseCommentController::handleStore()
     *
     * @param Track $track
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Track $track, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleStore($track, $request);
    }

    /**
     * Atjauno dota komentāra tekstu un rediģēšanas laikspiedolu.
     * @see BaseCommentController::handleUpdate()
     *
     * @param Track $track
     * @param TrackComment $comment
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Track $track, TrackComment $comment, Request $request):
    \Illuminate\Http\JsonResponse
    {
        return $this->handleUpdate($track, $comment, $request);
    }

    /**
     * Izdzēš doto komentāru.
     * @see BaseCommentController::handleDestroy()
     *
     * @param Track $track
     * @param TrackComment $comment
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Track $track, TrackComment $comment): \Illuminate\Http\JsonResponse
    {
        return $this->handleDestroy($track, $comment);
    }
}
