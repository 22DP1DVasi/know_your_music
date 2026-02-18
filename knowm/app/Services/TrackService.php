<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Lyric;
use App\Models\TrackComment;

class TrackService
{
    /**
     * Iegūst informāciju par dziesmu kopā ar noteiktu komentāru lapu.
     *
     * @param Track $track
     * @param int $commentsPage
     * @return array
     */
    public function getTrackWithDetailsAndComments(Track $track, int $commentsPage = 1): array
    {
        // informācija par dziesmu
        $track->load([
            'artists:id,name,slug',
            'genres:id,name,slug',
            'releases' => function ($query) {
                $query->select('releases.id', 'title', 'slug', 'release_date')
                    ->orderBy('release_date');
            }
        ]);
        // saistīto albumu saraksts kopā ar attēliem
        $track->releases->each->append('cover_url');
        // dziesmas teksts
        $lyrics = $track->lyrics()->firstOrNew([]);
        // komentāri
        $comments = TrackComment::withTrashed()
            ->where('track_id', $track->id)
            ->whereNull('parent_id')
            ->with(['user', 'replies'])
            ->orderBy('created_at', 'desc')
            ->paginate(10, ['*'], 'page', $commentsPage);

        // iegūt visu komentāru skaitu, ieskaitot atbildes
        $totalCommentsCount = TrackComment::withTrashed()
            ->where('track_id', $track->id)
            ->count();

        return [
            'id' => $track->id,
            'title' => $track->title,
            'slug' => $track->slug,
            'cover_url' => $track->cover_url,
            'duration' => $track->duration,
            'description' => $track->description,
            'release_date' => $track->release_date,

            'artists' => $track->artists,
            'genres' => $track->genres,
            'releases' => $track->releases,

            'lyrics' => $this->formatLyricsData($lyrics),

            'comments' => $comments->items(),

            'comments_pagination' => [
                'current_page' => $comments->currentPage(),
                'last_page' => $comments->lastPage(),
                'total' => $totalCommentsCount,
                'per_page' => $comments->perPage(),
            ]
        ];
    }

    /**
     * Formatē dziesmas teksta datus.
     *
     * @param Lyric $lyrics
     * @return array
     */
    protected function formatLyricsData(Lyric $lyrics): array
    {
        return [
            'id' => $lyrics->id ?? null,
            'text' => $lyrics->lyrics ?? null,
            'status' => $lyrics->status ?? 'requires verification',
            'track_id' => $lyrics->track_id ?? null
        ];
    }

    /**
     * @param Artist $artist
     * @param $perPage
     * @param $search
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public function getPaginatedTracks(Artist $artist, $perPage = 40, $search = null): \Illuminate\Contracts\Pagination\LengthAwarePaginator
    {
//        $artist = Artist::where('slug', $artistSlug)->firstOrFail();
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

    /**
     * @param $paginator
     * @return array
     */
    public function formatForView($paginator): array
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
