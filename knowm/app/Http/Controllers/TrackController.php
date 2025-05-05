<?php

namespace App\Http\Controllers;

use App\Models\Track;
use App\Services\TrackService;
use Illuminate\Http\Request;

class TrackController extends Controller
{
    protected $trackService;

    public function __construct(TrackService $trackService)
    {
        $this->trackService = $trackService;
    }

    public function show(Track $track)
    {
        $trackData = $this->trackService->getTrackWithDetails($track);

        return inertia('Tracks/TrackShow', [
            'track' => $trackData['track'],
            'lyrics' => $trackData['lyrics']
        ]);
    }
}
