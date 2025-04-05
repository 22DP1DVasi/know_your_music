<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserFavoriteArtist extends Model
{
    use HasFactory;

    protected $table = 'user_favorite_artists';

    protected $fillable = [
        'user_id',
        'artist_id',
        'sort_order',
    ];

    protected $casts = [
        'sort_order' => 'integer',
    ];

    /**
     * The user who favorited this artist
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * The artist that was favorited
     */
    public function artist(): BelongsTo
    {
        return $this->belongsTo(Artist::class);
    }

    /**
     * Scope to get favorites for a specific user
     */
    public function scopeForUser($query, $userId)
    {
        return $query->where('user_id', $userId)
            ->orderBy('sort_order')
            ->orderBy('created_at');
    }
}
