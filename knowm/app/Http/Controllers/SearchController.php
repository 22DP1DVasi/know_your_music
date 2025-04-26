<?php

namespace App\Http\Controllers;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Services\SearchService;

class SearchController extends Controller
{
    public function index(Request $request, SearchService $searchService)
    {
        $query = $request->input('q', '');
        $results = $searchService->searchAll($query);
        return Inertia::render('Search', [
            'artists' => $results['artists'],
            'releases' => $results['releases'],
//            'tracks' => $results['tracks'],
            'metadataMatches' => $results['tracks']['metadata_tracks'],
            'lyricsMatches' => $results['tracks']['lyrics_tracks'],
            'searchQuery' => $query,
            'hasMoreArtists' => $results['hasMore']['artists'],
            'hasMoreReleases' => $results['hasMore']['releases'],
            'hasMoreTracks' => $results['hasMore']['tracks'],
//            'artistsCount' => Artist::where('name', 'like', "%{$query}%")->count(),
            'artistsCount' => $results['counts']['artists'],
//            'releasesCount' => Release::where('title', 'like', "%{$query}%")->count(),
            'releasesCount' => $results['counts']['releases'],
//            'tracksCount' => $searchService->getTotalTracksCount($query)
            'tracksCount' => $results['counts']['tracks'],
            'metadataMatchesCount' => $results['counts']['metadata_tracks_count'],
            'lyricsMatchesCount' => $results['counts']['lyrics_tracks_count']
        ]);
    }
}
