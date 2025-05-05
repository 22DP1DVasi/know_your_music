<?php

namespace App\Http\Controllers;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Database\Eloquent\Builder;
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

    /**
     * TODO: try to use similar method in SearchService instead of making new query
     */
    public function artists(Request $request, SearchService $searchService)
    {
        $query = $request->input('q', '');
        $perPage = $request->input('perPage', 24);

        $artists = Artist::where('name', 'like', "%{$query}%")
            ->withCount('tracks')
            ->orderBy('name')
            ->paginate($perPage)
            ->appends(['q' => $query, 'perPage' => $perPage]);

        return Inertia::render('Artists/ArtistsSearchResults', [
            'artists' => $artists->items(),
            'searchQuery' => $query,
            'paginationLinks' => $artists->links()->elements[0], // pagination links
            'currentPage' => $artists->currentPage(),
            'totalPages' => $artists->lastPage(),
            'perPage' => $perPage
        ]);
    }

    /**
     * TODO: try to use similar method in SearchService instead of making new query
     */
    public function releases(Request $request)
    {
        $query = $request->input('q', '');
        $type = $request->input('type', 'title');
        $perPage = $request->input('perPage', 24);

        $releases = Release::when($type === 'title', function($q) use ($query) {
            $q->where('title', 'like', "%{$query}%");
        })
            ->when($type === 'artist', function($q) use ($query) {
                $q->whereHas('artists', function($q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
            })
            ->with(['artists'])
            ->withCount('tracks')
            ->orderBy('release_date', 'desc')
            ->paginate($perPage)
            ->appends(['q' => $query, 'type' => $type, 'perPage' => $perPage]);

        return Inertia::render('Releases/ReleasesSearchResults', [
            'releases' => $releases->items(),
            'searchQuery' => $query,
            'searchType' => $type,
            'paginationLinks' => $releases->toArray()['links'],
            'currentPage' => $releases->currentPage(),
            'totalPages' => $releases->lastPage(),
            'perPage' => $perPage
        ]);
    }

    /**
     * TODO: try to use similar method in SearchService instead of making new query
     */
    public function tracks(Request $request)
    {
        $query = $request->input('q', '');
        $type = $request->input('type', 'title');
        $perPage = $request->input('perPage', 20);

        $tracks = Track::when($type === 'title', function($q) use ($query) {
            $q->where('title', 'like', "%{$query}%");
        })
            ->when($type === 'artist', function($q) use ($query) {
                $q->whereHas('artists', function($q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
            })
            ->with(['artists'])
            ->orderBy('title')
            ->paginate($perPage)
            ->appends(['q' => $query, 'type' => $type, 'perPage' => $perPage]);

        return Inertia::render('Tracks/TracksSearchResults', [
            'tracks' => $tracks->items(),
            'searchQuery' => $query,
            'searchType' => $type,
            'paginationLinks' => $tracks->toArray()['links'],
            'currentPage' => $tracks->currentPage(),
            'totalPages' => $tracks->lastPage(),
            'perPage' => $perPage
        ]);
    }

    /**
     * TODO: try to use similar method in SearchService instead of making new query
     */
    public function lyrics(Request $request, SearchService $searchService)
    {
        $query = $request->input('q', '');
        $perPage = $request->input('perPage', 20);

        $tracks = Track::whereHas('lyrics', function($q) use ($query) {
            $q->where('lyrics', 'like', "%{$query}%");
        })
            ->with(['artists', 'lyrics'])
            ->orderBy('title')
            ->paginate($perPage)
            ->appends(['q' => $query, 'perPage' => $perPage]);

        $tracks->getCollection()->transform(function($track) use ($query, $searchService) {
            $lyricsText = $track->lyrics->pluck('lyrics')->implode("\n");
            $track->lyric_snippet = $searchService->extractLyricSnippet(
                $lyricsText,
                $query,
                50
            );
            return $track;
        });

        return Inertia::render('LyricsSearchResults', [
            'tracks' => $tracks->items(),
            'searchQuery' => $query,
            'paginationLinks' => $tracks->toArray()['links'],
            'currentPage' => $tracks->currentPage(),
            'totalPages' => $tracks->lastPage(),
            'perPage' => $perPage
        ]);
    }
}
