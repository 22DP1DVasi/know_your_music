<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Release extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'title',
        'release_date',
        'cover_image',
        'description',
        'release_type'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'release_date' => 'date:Y-m-d',
    ];

    /**
     * Get the artist that owns this release.
     */
    public function artists(): BelongsToMany
    {
        return $this->belongsToMany(Artist::class, 'artists_releases')
            ->withPivot('role')
            ->withTimestamps();
    }

    /**
     * Get all tracks in this release.
     */
    public function tracks(): BelongsToMany
    {
        return $this->belongsToMany(Track::class, 'tracks_releases')
            ->withPivot('track_position')
            ->withTimestamps();
    }

    /**
     * Get all genres associated with this release.
     */
    public function genres()
    {
        return $this->belongsToMany(Genre::class, 'releases_genres')
            ->withTimestamps(); // tracks when relationships were created
    }

    /**
     * Relationship with ReleaseComment model
     */
    public function comments()
    {
        return $this->hasMany(ReleaseComment::class);
    }

    /**
     * Get all comments for release
     */
    public function allComments()
    {
        return $this->hasMany(ReleaseComment::class)
            ->with('user')
            ->latest();
    }

    /**
     * Scope for albums only.
     */
    public function scopeAlbums($query)
    {
        return $query->where('release_type', 'album');
    }

    /**
     * Scope for releases in a given year.
     */
    public function scopeYear($query, int $year)
    {
        return $query->whereYear('release_date', $year);
    }

    /**
     * Get the cover image URL (accessor).
     */
    public function getCoverUrlAttribute(): ?string
    {
        return $this->cover_image
            ? asset('storage/releases/'.$this->cover_image)
            : asset('images/default-release-cover.jpg');
    }

    /**
     * Get the release duration in minutes.
     */
    public function getDurationAttribute(): int
    {
        return (int) $this->tracks()->sum('duration') / 60;
    }
}
