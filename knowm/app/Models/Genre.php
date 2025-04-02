<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
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
            ->withTimestamps();     // tracks when relationships were created
    }

    /**
     * Get all tracks associated with this genre.
     */
    public function tracks()
    {
        return $this->belongsToMany(Track::class, 'tracks_genres')
            ->withTimestamps();     // tracks when relationships were created
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
