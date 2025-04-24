<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;

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

    //
    protected $appends = ['banner_url'];

    protected static function booted()
    {
        // create folders for images when this artist is created
        static::created(function ($artist) {
            Storage::makeDirectory("public/artists/{$artist->id}/profile");
            Storage::makeDirectory("public/artists/{$artist->id}/banner");
        });

        // delete folders for images when this artist is deleted
        static::deleted(function ($artist) {
            Storage::deleteDirectory("public/artists/{$artist->id}");
        });
    }

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
    public function releases(): BelongsToMany
    {
        return $this->belongsToMany(Release::class, 'artists_releases')
            ->withPivot('role')
            ->withTimestamps();
    }

    /**
     * Get all tracks by this artist.
     */
    public function tracks(): BelongsToMany
    {
        return $this->belongsToMany(Track::class, 'artists_tracks')
            ->withPivot('role')
            ->withTimestamps();
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
     * Get profile image attribute for this artst
     */
    public function getBannerUrlAttribute()
    {
        $path = "artists/{$this->id}/banner/banner.webp";

        // Check for WebP first, fallback to JPG if needed
        if (Storage::disk('public')->exists($path)) {
            return Storage::url($path);
        }

        // Fallback to default image
        return asset('images/default-artist.webp');
    }

    /**
     * Get banner image attribute for this artst
     */
    public function getProfileUrlAttribute()
    {
        $path = "artists/{$this->id}/profile/profile.jpg";
        return Storage::disk('public')->exists($path)
            ? Storage::url($path)
            : asset('images/default-artist.jpg');
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
}
