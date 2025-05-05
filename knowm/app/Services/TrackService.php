<?php

namespace App\Services;

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
        return [
            'id' => $track->id,
            'title' => $track->title,
            'slug' => $track->slug,
            'duration' => $track->duration,
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
                    'name' => $genre->name
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
}
