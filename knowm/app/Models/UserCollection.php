<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class UserCollection extends Model
{
    use HasFactory;

    protected $table = 'user_collections';

    protected $fillable = [
        'user_id',
        'name',
        'description',
        'is_private',
    ];

    protected $casts = [
        'is_private' => 'boolean',
    ];

    /**
     * The user who owns this collection
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Tracks in this collection
     */
    public function tracks(): BelongsToMany
    {
        return $this->belongsToMany(Track::class, 'user_collections_tracks')
            ->withPivot('track_position')
            ->orderBy('user_collections_tracks.track_position');
    }

    /**
     * Add a track to the collection
     */
    public function addTrack(Track $track, ?int $position = null): void
    {
        $this->tracks()->attach($track, [
            'track_position' => $position ?? 0 // let the trigger handle auto-positioning if 0
        ]);
    }

    /**
     * Remove a track from the collection
     */
    public function removeTrack(Track $track): void
    {
        $this->tracks()->detach($track);
    }

    /**
     * Reorder tracks in the collection
     */
    public function reorderTracks(array $trackIds): void
    {
        foreach ($trackIds as $position => $trackId) {
            $this->tracks()->updateExistingPivot($trackId, [
                'track_position' => $position + 1
            ]);
        }
    }
}
