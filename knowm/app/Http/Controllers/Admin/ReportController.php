<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Artist;
use App\Models\ArtistComment;
use App\Models\ReleaseComment;
use App\Models\TrackComment;
use App\Models\GenreComment;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ReportController extends Controller
{
    public function index(Request $request): \Inertia\Response
    {
        return Inertia::render('Admin/Reports/Index');
    }

    /***
     * Generates users report.
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function usersReport(Request $request): \Illuminate\Http\Response
    {
        $validated = $request->validate([
            'limit' => ['required', 'integer', 'min:1', 'max:1000'],
            'date_from' => ['nullable', 'date'],
            'date_to' => ['nullable', 'date'],
        ]);

        $query = User::with('roles')
            ->withTrashed();

        // date filters
        if (!empty($validated['date_from'])) {
            $query->whereDate(
                'created_at',
                '>=',
                $validated['date_from']
            );
        }

        if (!empty($validated['date_to'])) {
            $query->whereDate(
                'created_at',
                '<=',
                $validated['date_to']
            );
        }

        // main users list of model objects
        $users = $query
            ->orderByDesc('created_at')
            ->limit($validated['limit'])
            ->get();

        // statistics
        $totalUsers = User::withTrashed()->count();

        $activeUsers = User::where(
            'status',
            'active'
        )
            ->whereNull('deleted_at')
            ->count();

        $bannedUsers = User::where(
            'status',
            'banned'
        )
            ->whereNull('deleted_at')
            ->count();

        $deletedUsers = User::onlyTrashed()->count();

        $pdf = Pdf::loadView(
            'pdf.users-report',
            [
                'users' => $users,
                'totalUsers' => $totalUsers,
                'activeUsers' => $activeUsers,
                'bannedUsers' => $bannedUsers,
                'deletedUsers' => $deletedUsers,
                'generatedAt' => now(),
            ]
        )->setPaper('a4', 'landscape');

        $domPdf = $pdf->getDomPDF();
        $domPdf->render();
        $canvas = $domPdf->getCanvas();

        $font = $domPdf->getFontMetrics()->get_font('DejaVu Sans', 'normal');
        $x = $canvas->get_width() / 2;

        $canvas->page_text(
            $x,
            $canvas->get_height() - 30,
            "{PAGE_NUM} / {PAGE_COUNT}",
            $font,
            10,
            [0, 0, 0],
            0.0,
            0.0,
            'center'
        );

        $fileName = 'users-report-' . now()->format('Y-m-d_H-i-s') . '.pdf';
        return $pdf->stream($fileName);
    }

    /***
     * Generates comments report.
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function commentsReport(Request $request): \Illuminate\Http\Response
    {
        $validated = $request->validate([
            'limit' => ['required', 'integer', 'min:1', 'max:1000'],
            'date_from' => ['nullable', 'date'],
            'date_to' => ['nullable', 'date'],
        ]);

        $artistComments = ArtistComment::with([
            'user',
            'artist'
        ])
            ->withTrashed()
            ->when(
                $validated['date_from'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '>=', $date)
            )
            ->when(
                $validated['date_to'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '<=', $date)
            )
            ->get()
            ->map(function ($comment) {
                return [
                    'id' => $comment->id,
                    'author' => $comment->user?->name ?? '—',
                    'text' => str($comment->text)->limit(340),
                    'status' => $this->getCommentStatus($comment),
                    'created_at' => $comment->created_at,
                    'object' => sprintf(
                        '%s (#%d, %s)',
                        $comment->artist?->name,
                        $comment->artist?->id,
                        __('reports.comments.entity.artist')
                    ),
                    'parent_id' => $comment->parent_id,
                ];
            });

        $releaseComments = ReleaseComment::with([
            'user',
            'release'
        ])
            ->withTrashed()
            ->when(
                $validated['date_from'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '>=', $date)
            )
            ->when(
                $validated['date_to'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '<=', $date)
            )
            ->get()
            ->map(function ($comment) {
                return [
                    'id' => $comment->id,
                    'author' => $comment->user?->name ?? '—',
                    'text' => str($comment->text)->limit(340),
                    'status' => $this->getCommentStatus($comment),
                    'created_at' => $comment->created_at,
                    'object' => sprintf(
                        '%s (#%d, %s)',
                        $comment->release?->title,
                        $comment->release?->id,
                        __('reports.comments.entity.release')
                    ),
                    'parent_id' => $comment->parent_id,
                ];
            });

        $trackComments = TrackComment::with([
            'user',
            'track'
        ])
            ->withTrashed()
            ->when(
                $validated['date_from'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '>=', $date)
            )
            ->when(
                $validated['date_to'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '<=', $date)
            )
            ->get()
            ->map(function ($comment) {
                return [
                    'id' => $comment->id,
                    'author' => $comment->user?->name ?? '—',
                    'text' => str($comment->text)->limit(340),
                    'status' => $this->getCommentStatus($comment),
                    'created_at' => $comment->created_at,
                    'object' => sprintf(
                        '%s (#%d, %s)',
                        $comment->track?->title,
                        $comment->track?->id,
                        __('reports.comments.entity.track')
                    ),
                    'parent_id' => $comment->parent_id,
                ];
            });

        $genreComments = GenreComment::with([
            'user',
            'genre'
        ])
            ->withTrashed()
            ->when(
                $validated['date_from'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '>=', $date)
            )
            ->when(
                $validated['date_to'] ?? null,
                fn ($query, $date) =>
                $query->whereDate('created_at', '<=', $date)
            )
            ->get()
            ->map(function ($comment) {
                return [
                    'id' => $comment->id,
                    'author' => $comment->user?->name ?? '—',
                    'text' => str($comment->text)->limit(340),
                    'status' => $this->getCommentStatus($comment),
                    'created_at' => $comment->created_at,
                    'object' => sprintf(
                        '%s (#%d, %s)',
                        $comment->genre?->name,
                        $comment->genre?->id,
                        __('reports.comments.entity.genre')
                    ),
                    'parent_id' => $comment->parent_id,
                ];
            });

        // merge + sort
        // result is collection of comments
        $comments = $artistComments
            ->merge($releaseComments)
            ->merge($trackComments)
            ->merge($genreComments)
            ->sortByDesc('created_at')
            ->take($validated['limit'])
            ->values();

        $pdf = Pdf::loadView(
            'pdf.comments-report',
            [
                'comments' => $comments,
                'generatedAt' => now(),
            ]
        )->setPaper('a4', 'landscape');

        $domPdf = $pdf->getDomPDF();
        $domPdf->render();

        $canvas = $domPdf->getCanvas();

        $font = $domPdf
            ->getFontMetrics()
            ->get_font('DejaVu Sans', 'normal');

        $x = $canvas->get_width() / 2;

        $canvas->page_text(
            $x,
            $canvas->get_height() - 30,
            "{PAGE_NUM} / {PAGE_COUNT}",
            $font,
            10,
            [0, 0, 0],
            0.0,
            0.0,
            'center'
        );

        $fileName = 'comments-report-' . now()->format('Y-m-d_H-i-s') . '.pdf';
        return $pdf->stream($fileName);
    }

    /***
     * Helper method to get comment status based on deleted_at and status attributes.
     *
     * @param $comment
     * @return string
     */
    private function getCommentStatus($comment): string
    {
        if ($comment->deleted_at !== null) {
            return 'deleted';
        }
        return $comment->status;
    }

    public function popularArtistsReport(Request $request): \Illuminate\Http\Response
    {
        $validated = $request->validate([
            'limit' => ['required', 'integer', 'min:1', 'max:1000'],
            'min_popularity' => ['nullable', 'numeric', 'min:0'],
            'activity_status' => ['nullable', 'in:all,active,inactive'],
        ]);

        $artists = Artist::with('genres')
            ->withCount('favoritedByUsers')
            ->when(
                $validated['min_popularity'] ?? null,
                fn ($query, $value) =>
                $query->where('popularity', '>=', $value)
            )
            ->when(
                ($validated['activity_status'] ?? 'all') !== 'all',
                fn ($query) =>
                $query->where(
                    'is_active',
                    $validated['activity_status'] === 'active'
                )
            )
            ->orderByDesc('popularity')
            ->orderByDesc('favorited_by_users_count')
            ->limit($validated['limit'])
            ->get();

        $pdf = Pdf::loadView(
            'pdf.popular-artists-report',
            [
                'artists' => $artists,
                'generatedAt' => now(),
            ]
        )->setPaper('a4', 'landscape');

        $domPdf = $pdf->getDomPDF();
        $domPdf->render();

        $canvas = $domPdf->getCanvas();

        $font = $domPdf
            ->getFontMetrics()
            ->get_font('DejaVu Sans', 'normal');

        $x = $canvas->get_width() / 2;

        $canvas->page_text(
            $x,
            $canvas->get_height() - 30,
            "{PAGE_NUM} / {PAGE_COUNT}",
            $font,
            10,
            [0, 0, 0],
            0.0,
            0.0,
            'center'
        );

        $fileName = 'popular-artists-report-' . now()->format('Y-m-d_H-i-s') . '.pdf';
        return $pdf->stream($fileName);
    }
}
