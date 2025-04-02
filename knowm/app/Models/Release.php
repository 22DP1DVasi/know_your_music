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
    public function artist(): BelongsTo
    {
        return $this->belongsTo(Artist::class);
    }

    /**
     * Get all tracks in this release.
     */
    public function tracks(): HasMany
    {
        return $this->hasMany(Track::class)->orderBy('track_position');
    }

    /**
     * Get all genres associated with this release.
     */
    public function genres(): BelongsToMany
    {
        return $this->belongsToMany(Genre::class, 'release_genres')
            ->withTimestamps();
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
