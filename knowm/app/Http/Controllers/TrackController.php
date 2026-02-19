<?php

namespace App\Http\Controllers;

use App\Models\Track;
use App\Services\TrackService;
use Illuminate\Http\Request;

class TrackController extends Controller
{
    protected TrackService $trackService;

    /**
     * Konstruktors.
     *
     * @param TrackService $trackService
     */
    public function __construct(TrackService $trackService)
    {
        $this->trackService = $trackService;
    }

    /**
     * Metode priekš TrackShow.vue lapas.
     * Iegūst datus par dziesmu no datubāzes un daļu no komentāriem un nodod tos lapai.
     *
     * @param Track $track
     * @return \Inertia\Response
     */
    public function show(Track $track): \Inertia\Response
    {
        // iegūt pašreizējo lapu komentāriem no pieprasījuma, noklusējums ir 1
        $commentsPage = request()->input('comments_page', 1);
        $trackData = $this->trackService
            ->getTrackWithDetailsAndComments($track, $commentsPage);

        return inertia('Tracks/TrackShow', [
            'track' => $trackData
        ]);
    }
}
