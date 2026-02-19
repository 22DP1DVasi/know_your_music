<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Release;
use App\Models\ReleaseComment;

class ReleaseCommentController extends BaseCommentController
{
    protected string $commentModel = ReleaseComment::class;
    protected string $parentKey = 'release_id';
    protected string $commentsTable = 'comments_releases';

    /**
     * Ielādē nākamo komentāru kopu.
     * @see BaseCommentController::handleGet()
     *
     * @param Release $release
     * @return \Illuminate\Http\JsonResponse
     */
    public function get(Release $release): \Illuminate\Http\JsonResponse
    {
        return $this->handleGet($release);
    }

    /**
     * Saglabā komentāru tabulā.
     * @see BaseCommentController::handleStore()
     *
     * @param Release $release
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Release $release, Request $request): \Illuminate\Http\JsonResponse
    {
        return $this->handleStore($release, $request);
    }

    /**
     * Atjauno dota komentāra tekstu un rediģēšanas laikspiedolu.
     * @see BaseCommentController::handleUpdate()
     *
     * @param Release $release
     * @param ReleaseComment $comment
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Release $release, ReleaseComment $comment, Request $request):
    \Illuminate\Http\JsonResponse
    {
        return $this->handleUpdate($release, $comment, $request);
    }

    /**
     * Izdzēš doto komentāru.
     * @see BaseCommentController::handleDestroy()
     *
     * @param Release $release
     * @param ReleaseComment $comment
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Release $release, ReleaseComment $comment): \Illuminate\Http\JsonResponse
    {
        return $this->handleDestroy($release, $comment);
    }
}
