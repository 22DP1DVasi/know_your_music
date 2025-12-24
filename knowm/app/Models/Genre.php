<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;

class Genre extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'slug',
        'description',
        'description_lv',
        'origin_year',
        'origin_country',
        'image',
        'popularity'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'origin_year' => 'integer',
        'popularity' => 'decimal:2',
    ];

    // explicit attributes for images URL
    protected $appends = ['profile_url', 'banner_url'];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($genre) {
            $genre->slug = $genre->generateUniqueSlug();
        });
        // create folder for images when this genre is created
        static::created(function ($genre) {
            Storage::makeDirectory("public/genres/{$genre->id}/profile");
            Storage::makeDirectory("public/genres/{$genre->id}/banner");
        });
        // delete folder when this genre is deleted
        static::deleted(function ($genre) {
            Storage::deleteDirectory("public/genres/{$genre->id}");
        });
    }

    /**
     * Get all artists associated with this genre.
     */
    public function artists()
    {
        return $this->belongsToMany(Artist::class, 'artists_genres')
            ->withTimestamps();     // tracks when relationships were created
    }

    /**
     * Get all releases associated with this genre.
     */
    public function releases()
    {
        return $this->belongsToMany(Release::class, 'releases_genres')
            ->withTimestamps();
    }

    /**
     * Get all tracks associated with this genre.
     */
    public function tracks()
    {
        return $this->belongsToMany(Track::class, 'tracks_genres')
            ->withTimestamps();
    }

    /**
     * Get all recommendations packages this genre is in
     */
    public function recommendedIn(): HasMany
    {
        return $this->hasMany(RecommendationGenre::class);
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
     * Get banner image attribute for this genre
     */
    public function getBannerUrlAttribute()
    {
        $path = "genres/{$this->id}/banner/banner.webp";
        if (Storage::disk('public')->exists($path)) {
            return Storage::url($path);
        }
        return asset('images/default-genre-banner.webp');
    }

    /**
     * Get profile image attribute for this genre
     */
    public function getProfileUrlAttribute()
    {
        $path = "genres/{$this->id}/profile/profile.webp";
        if (Storage::disk('public')->exists($path)) {
            return Storage::url($path);
        }
        return '';
    }

    /**
     * Scope for searching genres by name.
     */
    public function scopeSearch($query, string $term)
    {
        return $query->where('name', 'like', "%{$term}%");
    }

    /**
     * Get the image URL (accessor).
     */
    public function getImageUrlAttribute(): ?string
    {
        return $this->image ? asset('storage/genres/'.$this->image) : null;
    }
}
