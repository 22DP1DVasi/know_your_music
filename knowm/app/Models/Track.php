<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Track extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
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
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'duration' => 'datetime:H:i:s', // Cast to time format
        'release_date' => 'date:Y-m-d',
    ];

    /**
     * Get all genres associated with this track.
     */
    public function genres()
    {
        return $this->belongsToMany(Genre::class, 'tracks_genres')
            ->withTimestamps();  // tracks when relationships were created
    }

    /**
     * Get all releases associated with this track.
     */
    public function releases(): BelongsToMany
    {
        return $this->belongsToMany(Release::class, 'tracks_releases')
            ->withPivot('track_position')
            ->withTimestamps();
    }

    /**
     * Get all artists associated with this track.
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
     * Get all comments associated with this track.
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
     * Get the formatted duration (mm:ss).
     */
    public function getFormattedDurationAttribute(): string
    {
        return $this->duration->format('i:s');
    }

    /**
     * Get the audio file URL (accessor).
     */
    public function getAudioUrlAttribute(): ?string
    {
        return $this->audio_source
            ? asset('storage/tracks/'.$this->audio_source)
            : null;
    }

    /**
     * Scope for searching tracks by title.
     */
    public function scopeSearch($query, string $term)
    {
        return $query->where('title', 'like', "%{$term}%");
    }

    /**
     * Scope for recent tracks.
     */
    public function scopeRecent($query, int $days = 30)
    {
        return $query->where('release_date', '>=', now()->subDays($days));
    }
}
