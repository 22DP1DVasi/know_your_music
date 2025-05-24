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
     * The attributes that are mass assignable
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'slug',
        'biography',
        'formed_year',
        'disbanded_year',
        'image',
        'solo_or_band',
    ];

    /**
     * The attributes that should be cast
     *
     * @var array<string, string>
     */
    protected $casts = [
        'formed_year' => 'integer',
        'disbanded_year' => 'integer',
        'is_active' => 'boolean',
        'created_at' => 'datetime:Y-m-d H:i:s',
        'updated_at' => 'datetime:Y-m-d H:i:s',
    ];

    // explicit attributes for images URL
    protected $appends = ['profile_url', 'banner_url'];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($artist) {
            $artist->slug = $artist->generateUniqueSlug();
        });
        // create folder for images when this artist is created
        static::created(function ($artist) {
            Storage::makeDirectory("public/artists/{$artist->id}/profile");
            Storage::makeDirectory("public/artists/{$artist->id}/banner");
        });
        // delete folder when this artist is deleted
        static::deleted(function ($artist) {
            Storage::deleteDirectory("public/artists/{$artist->id}");
        });
    }

    /**
     * Get all genres associated with this artist
     */
    public function genres()
    {
        return $this->belongsToMany(Genre::class, 'artists_genres')
            ->withTimestamps(); // tracks when relationships were created
    }

    /**
     * Get all releases by this artist
     */
    public function releases(): BelongsToMany
    {
        return $this->belongsToMany(Release::class, 'artists_releases')
            ->withPivot('role')
            ->withTimestamps();
    }

    /**
     * Get all tracks by this artist
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
     * Get a slug value (used as route key)
     */
    public function getRouteKeyName()
    {
        return 'slug';
    }

    /**
     * Generate unique slugs
    */
    public function generateUniqueSlug()
    {
        $slug = $this->customSlugify($this->name);
        $originalSlug = $slug;
        $counter = 1;
        while (static::where('slug', $slug)->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }
        return $slug;
    }

    /**
     * Generate a slug
    */
    private function customSlugify(string $name): string
    {
        $slug = mb_strtolower($name);
        $slug = preg_replace('/\s+/u', '-', $slug);
        $slug = preg_replace('/[^\p{L}\p{N}_-]/u', '', $slug);
        return trim($slug, '-');
    }

    /**
     * Get banner image attribute for this artist
     */
    public function getBannerUrlAttribute()
    {
        $path = "artists/{$this->id}/banner/banner.webp";
        if (Storage::disk('public')->exists($path)) {
            return Storage::url($path);
        }
        return asset('images/default-artist-banner.webp');
    }

    /**
     * Get profile image attribute for this artist
     */
    public function getProfileUrlAttribute()
    {
        $path = "artists/{$this->id}/profile/profile.webp";
        if (Storage::disk('public')->exists($path)) {
            return Storage::url($path);
        }
        return asset('images/default-artist-profile.webp');
    }

    /**
     * Scope for active artists (not disbanded)
     */
    public function scopeActive($query)
    {
        return $query->whereNull('disbanded_year');
    }

    /**
     * Scope for bands only
     */
    public function scopeBands($query)
    {
        return $query->where('solo_or_band', 'band');
    }
}
