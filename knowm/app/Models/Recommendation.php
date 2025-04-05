<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Recommendation extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'is_checked_by_user',
    ];

    protected $casts = [
        'is_checked_by_user' => 'boolean',
    ];

    /**
     * The user who owns these recommendations
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Recommended genres in this package
     */
    public function genres(): HasMany
    {
        return $this->hasMany(RecommendationGenre::class);
    }

    /**
     * Mark recommendation as checked by user
     */
    public function markAsChecked(): void
    {
        $this->update(['is_checked_by_user' => true]);
    }

    /**
     * Create a new recommendation package for a user
     */
    public static function createForUser(int $userId): Recommendation
    {
        return static::create([
            'user_id' => $userId,
            'is_checked_by_user' => false,
        ]);
    }
}
