<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Track extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'title',
        'duration',
        'audio_source',
        'release_date'
    ];

    /**
     * The attributes that should be cast
     *
     * @var array<string, string>
     */
    protected $casts = [
        'duration' => 'datetime:H:i:s',
        'release_date' => 'date:Y-m-d',
    ];

    // explicit attribute for covers URL
    protected $appends = ['cover_url'];

    /**
     * Get all genres associated with this track
     */
    public function genres()
    {
        return $this->belongsToMany(Genre::class, 'tracks_genres')
            ->withTimestamps();
    }

    /**
     * Get all releases associated with this track
     */
    public function releases(): BelongsToMany
    {
        return $this->belongsToMany(Release::class, 'tracks_releases')
            ->withPivot('track_position')
            ->withTimestamps();
    }

    /**
     * Get all artists associated with this track
     */
    public function artists(): BelongsToMany
    {
        return $this->belongsToMany(Artist::class, 'artists_tracks')
            ->withPivot('role')
            ->withTimestamps();
    }

    /**
     * Get lyrics for this track.
     */
    public function lyrics()
    {
        return $this->hasOne(Lyric::class);
    }

    /**
     * Get all comments associated with this track
     */
    public function comments()
    {
        return $this->hasMany(TrackComment::class)
            ->visible()
            ->latest();
    }

    /**
     * Collections this track belongs to
     */
    public function userCollections(): BelongsToMany
    {
        return $this->belongsToMany(UserCollection::class, 'user_collections_tracks')
            ->withPivot('track_position');
    }

    /**
     * Get the formated duration (mm:ss)
     */
    public function getFormattedDurationAttribute(): string
    {
        return $this->duration->format('i:s');
    }

    /**
     * Get the audio file URL
     */
    public function getAudioUrlAttribute(): ?string
    {
        return $this->audio_source
            ? asset('storage/tracks/'.$this->audio_source)
            : null;
    }

    /**
     * Get the cover image from associated release
     */
    public function getCoverUrlAttribute()
    {
        // Get the first release that has a cover image
        $release = $this->releases()->first();

        return $release?->cover_url ?? asset('images/default-release-banner.webp');
    }

    /**
     * Scope for searching tracks by title
     */
    public function scopeSearch($query, string $term)
    {
        return $query->where('title', 'like', "%{$term}%");
    }

    /**
     * Scope for recent tracks
     */
    public function scopeRecent($query, int $days = 30)
    {
        return $query->where('release_date', '>=', now()->subDays($days));
    }
}
