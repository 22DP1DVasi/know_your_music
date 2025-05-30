<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Lyric;

class TrackService
{
    public function getTrackWithDetails(Track $track)
    {
        $track->load([
            'artists',
            'genres',
            'releases' => function($query) {
                $query->select('releases.id', 'title', 'slug', 'release_date')
                    ->orderBy('release_date');
            }
        ]);
        $track->releases->each->append('cover_url');
        $lyrics = $track->lyrics()->firstOrNew([]);
        return [
            'track' => $this->formatTrackData($track),
            'lyrics' => $this->formatLyricsData($lyrics)
        ];
    }

    protected function formatTrackData(Track $track)
    {
        // format duration from TIME to H:i:s
        $duration = $track->duration ? $track->duration->format('H:i:s') : null;
        return [
            'id' => $track->id,
            'title' => $track->title,
            'slug' => $track->slug,
            'duration' => $duration,
            'description' => $track->description,
            'cover_url' => $track->cover_url,
            'release_date' => $track->release_date,
            'artists' => $track->artists->map(function($artist) {
                return [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'slug' => $artist->slug,
                    'role' => $artist->pivot->role ?? null
                ];
            }),
            'genres' => $track->genres->map(function($genre) {
                return [
                    'id' => $genre->id,
                    'name' => $genre->name,
                    'slug' => $genre->slug
                ];
            }),
            'releases' => $track->releases->map(function($release) {
                return [
                    'id' => $release->id,
                    'title' => $release->title,
                    'slug' => $release->slug,
                    'cover_url' => $release->cover_url,
                    'release_date' => $release->release_date,
                    'track_position' => $release->pivot->track_position
                ];
            })
        ];
    }

    protected function formatLyricsData(Lyric $lyrics)
    {
        return [
            'id' => $lyrics->id ?? null,
            'text' => $lyrics->lyrics ?? null,
            'status' => $lyrics->status ?? 'requires verification',
            'track_id' => $lyrics->track_id ?? null
        ];
    }

    public function getPaginatedTracks($artistSlug, $perPage = 40, $search = null)
    {
        $artist = Artist::where('slug', $artistSlug)->firstOrFail();
        return Track::with(['releases', 'artists'])
            ->whereHas('artists', function($query) use ($artist) {
                $query->where('artist_id', $artist->id);
            })
            ->when(request('search'), function($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->orderBy('title')
            ->paginate($perPage);
    }

    public function formatForView($paginator)
    {
        return [
            'tracks' => $paginator->items(),
            'totalTracks' => $paginator->total(),
            'paginationLinks' => $paginator->onEachSide(1)->toArray()['links'],
            'currentPage' => $paginator->currentPage(),
            'totalPages' => $paginator->lastPage(),
            'perPage' => $paginator->perPage()
        ];
    }
}
