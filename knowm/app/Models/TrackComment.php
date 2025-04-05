<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

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
        'commenter_id',
        'commenter_type',
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
     * Get the commenter (user or admin) who made the comment.
     */
    public function commenter(): MorphTo
    {
        return $this->morphTo()
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
        if ($this->deleted_username) {
            return $this->deleted_username;
        }

        return $this->commenter?->name;
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
        ]);
    }
}
