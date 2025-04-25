<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;

class SearchService
{
    public function searchAll(string $query, int $limit = 5)
    {
        $artistsCount = Artist::where('name', 'like', "%{$query}%")->count();
        $releasesCount = $this->getReleasesCount($query);
        $tracksCount = $this->getTotalTracksCount($query);

        return [
            'artists' => $this->searchArtists($query, $limit),
            'releases' => $this->searchReleases($query, $limit),
            'tracks' => $this->searchTracks($query, $limit),
            'hasMore' => [
                'artists' => $artistsCount > $limit,
                'releases' => $releasesCount > $limit,
                'tracks' => $tracksCount > $limit
            ],
            'counts' => [
                'artists' => $artistsCount,
                'releases' => $releasesCount,
                'tracks' => $tracksCount
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

    protected function searchTracks(string $query, int $limit)
    {
        $tracksByTitleOrArtist = Track::where(function($q) use ($query) {
            $q->where('title', 'like', "%{$query}%")
                ->orWhereHas('artists', function($q) use ($query) {
                    $q->where('name', 'like', "%{$query}%");
                });
        })
            ->with(['artists'])
            ->limit($limit)
            ->get();

        $tracksByLyrics = Track::whereHas('lyrics', function($q) use ($query) {
            $q->where('lyrics', 'like', "%{$query}%");
        })
            ->with(['artists'])
            ->limit($limit)
            ->get();

        return $tracksByTitleOrArtist->merge($tracksByLyrics)
            ->unique('id')
            ->take($limit);
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

    protected function getTotalTracksCount(string $query)
    {
        return Track::where(function($q) use ($query) {
                $q->where('title', 'like', "%{$query}%")
                    ->orWhereHas('artists', function($q) use ($query) {
                        $q->where('name', 'like', "%{$query}%");
                    });
            })->count() +
            Track::whereHas('lyrics', fn($q) => $q->where('lyrics', 'like', "%{$query}%"))->count();
    }
}
