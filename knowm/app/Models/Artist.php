<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Artist extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'biography',
        'formed_year',
        'disbanded_year',
        'image',
        'solo_or_band'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'formed_year' => 'integer',
        'disbanded_year' => 'integer',
    ];

    /**
     * Get all genres associated with this artist.
     */
    public function genres()
    {
        return $this->belongsToMany(Genre::class, 'artists_genres')
            ->withTimestamps(); // tracks when relationships were created
    }

    /**
     * Get all releases by this artist.
     */
    public function releases(): HasMany
    {
        return $this->hasMany(Release::class);
    }

    /**
     * Get all tracks by this artist.
     */
    public function tracks(): HasMany
    {
        return $this->hasMany(Track::class);
    }

    /**
     * Relationship with ArtistComment model
     */
    public function comments()
    {
        return $this->hasMany(ArtistComment::class)
            ->visible() // default to only visible comments
            ->latest();
    }

    /**
     * Get all comments for the artist
     */
    public function allComments()
    {
        return $this->hasMany(ArtistComment::class)
            ->with('user') // eager load user
            ->latest();
    }

    /**
     * Get all recommendations packages this artist is in
     */
    public function recommendedIn(): HasMany
    {
        return $this->hasMany(RecommendationArtist::class);
    }

    /**
     * Scope for active artists (not disbanded).
     */
    public function scopeActive($query)
    {
        return $query->whereNull('disbanded_year');
    }

    /**
     * Scope for bands only.
     */
    public function scopeBands($query)
    {
        return $query->where('solo_or_band', 'band');
    }

    /**
     * Get the artist's active years.
     */
    public function getActiveYearsAttribute(): ?string
    {
        if (!$this->formed_year) return null;

        return $this->disbanded_year
            ? "{$this->formed_year} - {$this->disbanded_year}"
            : "{$this->formed_year} - Present";
    }

    /**
     * Get the image URL (accessor).
     */
    public function getImageUrlAttribute(): ?string
    {
        return $this->image ? asset('storage/artists/'.$this->image) : null;
    }
}
