<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Lyric;
/**
 * Builders are a useful tool in queries. They provide autocomplete for query methods,
 * replace runtime errors with IDE warnings and so on. Are useful for complex queries.
*/
use Illuminate\Database\Eloquent\Builder;

class SearchService
{
    public function searchAll(string $query, int $limit = 8)
    {
        $artistsCount = Artist::where('name', 'like', "%{$query}%")->count();
        $releasesCount = $this->getReleasesCount($query);
        $metadataTracksCount = $this->getMetadataTracksCount($query);
        $lyricsTracksCount = $this->getLyricsTracksCount($query);
        $tracksCount = $metadataTracksCount + $lyricsTracksCount;

        return [
            'artists' => $this->searchArtists($query, $limit),
            'releases' => $this->searchReleases($query, $limit),
            'tracks' => [
                'metadata_tracks' => $this->searchTracksByMetadata($query, $limit),
                'lyrics_tracks' => $this->searchTracksByLyrics($query, $limit)
            ],
            'hasMore' => [
                'artists' => $artistsCount > $limit,
                'releases' => $releasesCount > $limit,
                'tracks' => $tracksCount > $limit
            ],
            'counts' => [
                'artists' => $artistsCount,
                'releases' => $releasesCount,
                'tracks' => $tracksCount,
                'metadata_tracks_count' => $metadataTracksCount,
                'lyrics_tracks_count' => $lyricsTracksCount
            ]
        ];
    }

    protected function searchArtists(string $query, int $limit)
    {
        return Artist::where('name', 'like', "%{$query}%")
            ->withCount('tracks')
            ->limit($limit)
            ->get()
            ->map(function ($artist) {
                return [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'tracks_count' => $artist->tracks_count,
                    'banner_url' => $artist->banner_url,
                ];
            });
    }

    protected function searchReleases(string $query, int $limit)
    {
        return Release::where(function($q) use ($query) {
            $q->where('title', 'like', "%{$query}%")
                ->orWhereHas('artists', function($q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
        })
            ->with(['artists'])
            ->withCount('tracks')
            ->limit($limit)
            ->get();
    }


    protected function searchTracksByMetadata(string $query, int $limit)
    {
        return Track::where(function(Builder $q) use ($query) {
            $q->where('title', 'like', "%{$query}%")
                ->orWhereHas('artists', function(Builder $q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
        })
            ->with(['artists', 'releases'])
            ->limit($limit)
            ->get();
    }

    protected function searchTracksByLyrics(string $query, int $limit)
    {
        return Track::whereHas('lyrics', function(Builder $q) use ($query) {
            $q->where('lyrics', 'like', "%{$query}%");
        })
            ->with(['artists', 'lyrics'])
            ->limit($limit)
            ->get()
            ->map(function ($track) use ($query) {
                $track->lyric_snippet = $this->extractLyricSnippet($track->lyrics->lyrics, $query);
                return $track;
            });
    }

    protected function getReleasesCount(string $query)
    {
        return Release::where(function($q) use ($query) {
            $q->where('title', 'like', "%{$query}%")
                ->orWhereHas('artists', function($q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
        })
            ->count();
    }

    protected function getMetadataTracksCount(string $query)
    {
        return Track::where(function(Builder $q) use ($query) {
            $q->where('title', 'like', "%{$query}%")
                ->orWhereHas('artists', function(Builder $q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
        })
            ->count();
    }

    protected function getLyricsTracksCount(string $query)
    {
        return Track::whereHas('lyrics', fn(Builder $q) =>
        $q->where('lyrics', 'like', "%{$query}%")
        )->count();
    }

    public function extractLyricSnippet(string $lyrics, string $query, int $context = 50)
    {
        $cleanedLyrics = (new Lyric())->cleanLyrics($lyrics);

        $position = stripos($cleanedLyrics, $query);
        if ($position === false) {
            return '';
        }

        $start = max(0, $position - $context);
        $length = strlen($query) + ($context * 2);
        $snippet = substr($cleanedLyrics, $start, $length);

        $snippet = preg_replace(
            "/(" . preg_quote($query, '/') . ")/i",
            '<mark>$1</mark>',
            $snippet
        );

        if ($start > 0) $snippet = '...' . $snippet;
        if ($start + $length < strlen($cleanedLyrics)) $snippet = $snippet . '...';

        return $snippet;
    }
}
