<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RecommendationArtist extends Model
{
    use HasFactory;

    protected $table = 'recommendations_artists';

    protected $fillable = [
        'recommendation_genre_id',
        'artist_id',
    ];

    /**
     * The genre recommendation this belongs to
     */
    public function recommendationGenre(): BelongsTo
    {
        return $this->belongsTo(RecommendationGenre::class, 'recommendation_genre_id');
    }

    /**
     * The actual artist being recommended
     */
    public function artist(): BelongsTo
    {
        return $this->belongsTo(Artist::class);
    }
}
