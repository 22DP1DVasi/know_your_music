<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
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

        // main users list
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

        return $pdf->stream('users-report.pdf');
    }
}
