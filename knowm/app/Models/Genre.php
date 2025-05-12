<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

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
        'description',
        'origin_year',
        'origin_country',
        'image'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'origin_year' => 'integer',
    ];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($genre) {
            $genre->slug = $genre->generateUniqueSlug();
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
