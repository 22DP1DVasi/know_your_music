<?php

namespace App\Http\Controllers;

use App\Models\Artist;
use App\Models\Release;
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
            'metadataMatches' => $results['tracks']['metadata_tracks'],
            'lyricsMatches' => $results['tracks']['lyrics_tracks'],
            'searchQuery' => $query,
            'hasMoreArtists' => $results['hasMore']['artists'],
            'hasMoreReleases' => $results['hasMore']['releases'],
            'hasMoreTracks' => $results['hasMore']['tracks'],
            'artistsCount' => $results['counts']['artists'],
            'releasesCount' => $results['counts']['releases'],
            'tracksCount' => $results['counts']['tracks'],
            'metadataMatchesCount' => $results['counts']['metadata_tracks_count'],
            'lyricsMatchesCount' => $results['counts']['lyrics_tracks_count']
        ]);
    }

    public function artists(Request $request, SearchService $searchService)
    {
        $query = $request->input('q', '');
        $perPage = 24;
        $artists = Artist::where('name', 'like', "%{$query}%")
            ->withCount('tracks')
            ->orderBy('name')
            ->paginate($perPage);

        return Inertia::render('ArtistsSearchResults', [
            'artists' => $artists->items(),
            'searchQuery' => $query,
            'paginationLinks' => $artists->links()->elements[0], // pagination links
            'currentPage' => $artists->currentPage(),
            'totalPages' => $artists->lastPage()
        ]);
    }

    public function releases(Request $request)
    {
        $query = $request->input('q', '');
        $perPage = 24;

        $releases = Release::where('title', 'like', "%{$query}%")
            ->with(['artists'])
            ->withCount('tracks')
            ->orderBy('release_date', 'desc')
            ->paginate($perPage);

        return Inertia::render('ReleasesSearchResults', [
            'releases' => $releases->items(),
            'searchQuery' => $query,
            'paginationLinks' => $releases->links()->elements[0],
            'currentPage' => $releases->currentPage(),
            'totalPages' => $releases->lastPage()
        ]);
    }
}
