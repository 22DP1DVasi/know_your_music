<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TrackComment extends Model
{
    use HasFactory;
    protected $table = 'tracks_comments';

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
        'track_id'
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
     * Get the comment author (if not deleted)
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class)
            ->withGlobalScope('notDeleted', function ($builder) {
                $builder->where('status', '!=', 'deleted');
            });
    }

    /**
     * Get the associated track
     */
    public function track(): BelongsTo
    {
        return $this->belongsTo(Track::class);
    }

    /**
     * Get the display name for comment author
     */
    public function getAuthorNameAttribute(): string
    {
        return $this->deleted_username ??
            ($this->user && $this->user->status !== 'deleted'
                ? $this->user->name
                : '[Deleted User]');
    }

    /**
     * Scope for visible comments
     */
    public function scopeVisible($query)
    {
        return $query->where('status', 'visible');
    }

    /**
     * Mark comment as deleted while preserving metadata
     */
    public function softDelete(): bool
    {
        return $this->update([
            'status' => 'deleted',
            'deleted_username' => $this->deleted_username ?? $this->user?->name
        ]);
    }
}
