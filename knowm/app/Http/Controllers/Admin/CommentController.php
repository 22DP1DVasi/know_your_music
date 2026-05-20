<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Services\CommentService;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CommentController extends Controller
{
    protected CommentService $commentService;

    public function __construct(CommentService $commentService)
    {
        $this->commentService = $commentService;
    }

    /***
     * Method for Index.vue page.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request): \Inertia\Response
    {
        $entityType = $request->get('type', 'artists');
        $comments = $this->commentService->getComments($request, $entityType);

        return Inertia::render('Admin/Comments/Index', [
            'comments' => $comments,
            'filters' => $request->only(['type', 'status', 'search']),
        ]);
    }

    /***
     * Updates comment's status.
     *
     * @param Request $request
     * @param string $type
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateStatus(Request $request, string $type, int $id): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'status' => 'required|in:visible,hidden',
        ]);
        $this->commentService->updateStatus($type, $id, $request->status);

        return response()->json(['success' => true]);
    }
}
