<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;

class SearchService
{
    public function searchAll(string $query, int $limit = 5)
    {
        return [
            'artists' => $this->searchArtists($query, $limit),
            'releases' => $this->searchReleases($query, $limit),
            'tracks' => $this->searchTracks($query, $limit),
            'hasMore' => [
                'artists' => Artist::where('name', 'like', "%{$query}%")->count() > $limit,
                'releases' => Release::where('title', 'like', "%{$query}%")->count() > $limit,
                'tracks' => $this->getTotalTracksCount($query) > $limit
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
        return Release::where('title', 'like', "%{$query}%")
            ->with(['artists' => function($q) {
                $q->where('role', 'primary');
            }])
//            ->with(['artists'])   show all artists
            ->withCount('tracks')
            ->limit($limit)
            ->get();
    }

    protected function searchTracks(string $query, int $limit)
    {
        $tracksByTitle = Track::where('title', 'like', "%{$query}%")
            ->with(['artists' => function($q) {
                $q->where('role', 'primary');
            }])
            ->limit($limit)
            ->get();

        $tracksByLyrics = Track::whereHas('lyrics', function($q) use ($query) {
            $q->where('lyrics', 'like', "%{$query}%");
        })
            ->with(['artists' => function($q) {
                $q->where('role', 'primary');
            }])
            ->limit($limit)
            ->get();

        return $tracksByTitle->merge($tracksByLyrics)->unique('id')->take($limit);
    }

    protected function getTotalTracksCount(string $query)
    {
        return Track::where('title', 'like', "%{$query}%")->count() +
            Track::whereHas('lyrics', fn($q) => $q->where('lyrics', 'like', "%{$query}%"))->count();
    }
}
