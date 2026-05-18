<?php

namespace App\Services;

use App\Models\ArtistComment;
use App\Models\ReleaseComment;
use App\Models\TrackComment;
use App\Models\GenreComment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class CommentService
{
    public const ENTITIES = [
        'artists' => ArtistComment::class,
        'releases' => ReleaseComment::class,
        'tracks' => TrackComment::class,
        'genres' => GenreComment::class,
    ];

    /***
     * Finds the entity under which the comment was made.
     *
     * @param string $entityType
     * @return Model
     */
    public function getModel(string $entityType): Model
    {
        if (!array_key_exists($entityType, self::ENTITIES)) {
            abort(400, 'Invalid comment type.');
        }
        $class = self::ENTITIES[$entityType];
        return new $class();
    }

    /***
     * Gets
     *
     * @param Request $request
     * @param string $entityType
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public function getComments(Request $request, string $entityType)
    {
        $model = $this->getModel($entityType);
        $query = $model->newQuery()->with('user');

        // status filter based on status field and deleted_at
        if ($request->status === 'visible') {
            $query->whereNull('deleted_at')->where('status', 'visible');
        } elseif ($request->status === 'hidden') {
            $query->whereNull('deleted_at')->where('status', 'hidden');
        } elseif ($request->status === 'deleted') {
            $query->whereNotNull('deleted_at')->withTrashed();
        } else {
            $query->withTrashed();
        }

        // search: by ID or text
        if ($request->filled('search')) {
            $search = $request->search;
            if (is_numeric($search)) {
                $query->where('id', $search);
            } else {
                $query->where('text', 'like', '%' . addcslashes($search, '%_') . '%');
            }
        }

        $comments = $query->orderByDesc('created_at')->paginate(20)->withQueryString();
        return $comments;
    }

    public function updateStatus(string $entityType, int $commentId, string $newStatus): void
    {
        $model = $this->getModel($entityType);
        $comment = $model->withTrashed()->findOrFail($commentId);
        // cannot change status of a deleted comment
        if ($comment->trashed()) {
            abort(403, 'Cannot change status of a deleted comment.');
        }

        // only update if status is different and valid
        if (in_array($newStatus, ['visible', 'hidden'])) {
            $comment->status = $newStatus;
            $comment->save();
        } else {
            abort(400, 'Invalid status value.');
        }
    }
}
