<?php

namespace App\Models;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Release extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'title',
        'slug',
        'release_date',
        'cover_image',
        'description',
        'release_type'
    ];

    /**
     * The attributes that should be cast
     *
     * @var array<string, string>
     */
    protected $casts = [
        'release_date' => 'date:Y-m-d',
    ];

    // explicit attributes for covers URL
    protected $appends = ['cover_url'];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($artist) {
            $artist->slug = $artist->generateUniqueSlug();
        });
        static::created(function ($release) {
            Storage::makeDirectory("public/releases/{$release->id}");
        });
        static::deleted(function ($release) {
            Storage::deleteDirectory("public/releases/{$release->id}");
        });
    }

    /**
     * Get the artist that owns this release
     */
    public function artists(): BelongsToMany
    {
        return $this->belongsToMany(Artist::class, 'artists_releases')
            ->withPivot('role')
            ->withTimestamps();
    }

    /**
     * Get all tracks in this release
     */
    public function tracks(): BelongsToMany
    {
        return $this->belongsToMany(Track::class, 'tracks_releases')
            ->withPivot('track_position')
            ->withTimestamps();
    }

    /**
     * Get all genres associated with this release
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
        $slug = $this->customSlugify($this->title);
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
    private function customSlugify(string $title): string
    {
        $slug = mb_strtolower($title);
        $slug = preg_replace('/\s+/u', '-', $slug);
        $slug = preg_replace('/[^\p{L}\p{N}_-]/u', '', $slug);
        return trim($slug, '-');
    }

    /**
     * Scope for albums only
     */
    public function scopeAlbums($query)
    {
        return $query->where('release_type', 'album');
    }

    /**
     * Scope for releases in a given year
     */
    public function scopeYear($query, int $year)
    {
        return $query->whereYear('release_date', $year);
    }

    /**
     * Get cover image attribute for this release
     */
    public function getCoverUrlAttribute()
    {
        $path = "releases/{$this->release_type}/{$this->id}/cover.webp";
        return Storage::disk('public')->exists($path)
            ? Storage::url($path)
            : asset('images/default-release-banner.webp');
    }

    /**
     * Get the release duration in minutes
     */
    public function getDuration(): int
    {
        return (int) $this->tracks()->sum('duration') / 60;
    }
}
