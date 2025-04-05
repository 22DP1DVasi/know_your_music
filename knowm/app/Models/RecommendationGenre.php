<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class RecommendationGenre extends Model
{
    use HasFactory;

    protected $table = 'recommendations_genres';

    protected $fillable = [
        'recommendation_id',
        'genre_id',
        'user_rating',
    ];

    protected $casts = [
        'user_rating' => 'string',
    ];

    /**
     * The recommendation package this belongs to
     */
    public function recommendation(): BelongsTo
    {
        return $this->belongsTo(Recommendation::class);
    }

    /**
     * The actual genre being recommended
     */
    public function genre(): BelongsTo
    {
        return $this->belongsTo(Genre::class);
    }

    /**
     * Recommended artists for this genre
     */
    public function artists(): HasMany
    {
        return $this->hasMany(RecommendationArtist::class, 'recommendation_genre_id');
    }

    /**
     * Add an artist recommendation to this genre
     */
    public function addArtist(int $artistId): RecommendationArtist
    {
        return $this->artists()->create([
            'artist_id' => $artistId,
        ]);
    }

    /**
     * Rate this genre recommendation
     */
    public function rate(string $rating): void
    {
        $this->update(['user_rating' => $rating]);
    }
}
