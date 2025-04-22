<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;

class ArtistComment extends Model
{
    use HasFactory;

    protected $table = 'comments_artists';

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
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['author_name'];

    /**
     * Get the user who made the comment.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
//            ->withGlobalScope('notDeleted', function (Builder $builder) {
//                $builder->where('status', '!=', 'deleted');
//            });
    }

    /**
     * Get the artist this comment belongs to.
     */
    public function artist(): BelongsTo
    {
        return $this->belongsTo(Artist::class);
    }

    /**
     * Get the display name for the comment author.
     */
    public function getAuthorNameAttribute(): string
    {
        if ($this->deleted_username) {
            return $this->deleted_username;
        }

        return $this->user?->name ?? '[Deleted User]';
    }

    /**
     * Mark comment as deleted while preserving metadata.
     */
    public function softDelete(): bool
    {
        return $this->update([
            'deleted_username' => $this->user?->name    // preserve username before deletion
        ]);
    }

    /**
     * Scope for visible comments.
     */
    public function scopeVisible(Builder $query): Builder
    {
        return $query->where('status', 'visible');
    }

    /**
     * Scope for comments by admin users.
     */
    public function scopeByAdmins(Builder $query): Builder
    {
        return $query->whereHas('user', function(Builder $q) {
            $q->whereHas('roles', function(Builder $roleQuery) {
                $roleQuery->where('name', 'admin');
            });
        });
    }
}
