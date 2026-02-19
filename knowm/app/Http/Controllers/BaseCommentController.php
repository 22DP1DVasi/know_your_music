<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

abstract class BaseCommentController extends Controller
{
    /**
     * Jādefinē pakārtotajā kontrollerī.
     */
    protected string $commentModel;     // piem., ArtistComment::class
    protected string $parentKey;        // piem., artist_id
    protected string $commentsTable;    // piem., comments_artists

    /**
     * Ielādē nākamo komentāru kopu, izmantojot lapdali un pamatojoties uz vecākatslēgu.
     *
     * @param Model $parent
     * @return \Illuminate\Http\JsonResponse
     */
    protected function handleGet(Model $parent): \Illuminate\Http\JsonResponse
    {
        $page = request()->input('page', 1);
        $commentModel = $this->commentModel;
        $foreignKey = $this->parentKey;
        $comments = $commentModel::withTrashed()
            ->where($foreignKey, $parent->id)
            ->whereNull('parent_id')
            ->with([
                'user',
                'replies',
            ])
            ->orderBy('created_at', 'desc')
            ->paginate(10, ['*'], 'page', $page);
        return response()->json([
            'comments' => $comments->items(),
            'pagination' => [
                'current_page' => $comments->currentPage(),
                'last_page' => $comments->lastPage(),
                'total' => $comments->total(),
            ],
        ]);
    }

    /**
     * Saglabā komentāru attiecīgajā tabulā.
     *
     * @param Model $parent
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    protected function handleStore(Model $parent, Request $request): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'text' => 'required|string|min:1|max:2000',
            'parent_id' => "nullable|exists:{$this->commentsTable},id",
        ]);
        $comment = ($this->commentModel)::create([
            'user_id'   => Auth::id(),
            $this->parentKey => $parent->id,
            'text'      => $request->input('text'),
            'status'    => 'visible',
            'parent_id' => $request->input('parent_id', null),
        ]);
        $comment->load('user');
        return response()->json([
            'success' => true,
            'message' => 'Comment added successfully',
            'comment' => $comment,
        ]);
    }

    /**
     * Atjauno dota komentāra tekstu un rediģēšanas laikspiedolu.
     *
     * @param Model $parent
     * @param Model $comment
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    protected function handleUpdate(Model $parent, Model $comment, Request $request): \Illuminate\Http\JsonResponse
    {
        if ($comment->{$this->parentKey} !== $parent->id) {
            abort(403, 'Comment does not belong to this entity.');
        }
        if ($comment->user_id !== Auth::id()) {
            abort(403, 'You are not authorized to edit this comment.');
        }
        // 15-minute edit window
        if (Carbon::parse($comment->created_at)->diffInMinutes(now()) > 15) {
            abort(403, 'You can only edit comments within 15 minutes of posting.');
        }
        $request->validate([
            'text' => 'required|string|min:1|max:2000',
        ]);
        $comment->update([
            'text' => $request->input('text'),
            'edited_at' => now(),
        ]);
        $comment->load('user');
        return response()->json([
            'success' => true,
            'message' => 'Comment updated successfully',
            'comment' => $comment,
        ]);
    }

    /**
     * Izdzēš doto komentāru.
     *
     * @param Model $parent
     * @param Model $comment
     * @return \Illuminate\Http\JsonResponse
     */
    protected function handleDestroy(Model $parent, Model $comment): \Illuminate\Http\JsonResponse
    {
        if ($comment->{$this->parentKey} !== $parent->id) {
            abort(403, 'Comment does not belong to this entity.');
        }
        if (
            $comment->user_id !== Auth::id()
            && !Auth::user()->hasAnyRole(['comments_moderator', 'super_admin'])
        ) {
            abort(403, 'You are not authorized to delete this comment.');
        }
        if ($comment->isParentComment() && !$comment->replies()->exists()) {
            $comment->forceDelete();
            $deleteType = 'hard';
        } else {
            $comment->delete();
            $deleteType = 'soft';
        }
        return response()->json([
            'success' => true,
            'delete_type' => $deleteType,
            'message' => 'Comment deleted successfully.',
        ]);
    }
}
