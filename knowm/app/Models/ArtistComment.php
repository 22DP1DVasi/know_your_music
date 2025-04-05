<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ArtistComment extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'text',
        'status',
        'deleted_username',
        'user_id',
        'artist_id'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:i:s',
        'updated_at' => 'datetime:Y-m-d H:i:s',
    ];

    /**
     * Get the user who made the comment.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class)->withTrashed();
    }

    /**
     * Get the artist this comment belongs to.
     */
    public function artist(): BelongsTo
    {
        return $this->belongsTo(Artist::class);
    }

    /**
     * Scope for visible comments.
     */
    public function scopeVisible($query)
    {
        return $query->where('status', 'visible');
    }

    /**
     * Get the display name for the comment author.
     */
    public function getAuthorNameAttribute(): string
    {
        return $this->deleted_username ?? $this->user?->name ?? '[Deleted User]';
    }

    /**
     * Mark comment as deleted while preserving metadata.
     */
    public function softDelete(): bool
    {
        return $this->update([
            'status' => 'deleted',
            'deleted_username' => $this->deleted_username ?? $this->user?->name
        ]);
    }
}
