<?php

namespace App\Models;

use App\Enums\CommentDeletedBy;
use App\Enums\CommentDeleteReason;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use App\Traits\HasThreadedComments;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasOneOrMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ArtistComment extends Model
{
    use HasFactory, HasThreadedComments, SoftDeletes;
    protected $table = 'comments_artists';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'text',
        'status',
//        'deleted_username',
        'deleted_by',
        'delete_reason',
        'user_id',
        'artist_id',
        'parent_id'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'deleted_by' => CommentDeletedBy::class,
        'delete_reason' => CommentDeleteReason::class,
        'created_at' => 'datetime:Y-m-d H:i:s',
        'updated_at' => 'datetime:Y-m-d H:i:s',
        'deleted_at' => 'datetime:Y-m-d H:i:s',
        'edited_at' => 'datetime:Y-m-d H:i:s'
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
        return $this->belongsTo(User::class)->withTrashed();
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
     * Saistība ar citiem komentāriem/atbildēm.
     * Saņemt atbildes rekursīvi.
     *
     * @return HasOneOrMany
     */
    public function replies(): HasOneOrMany
    {
        return $this->hasMany(self::class, 'parent_id')
            ->withTrashed()
            ->with('replies', 'user');
    }

    /***
     * Saistība ar vecākkomentāru.
     * Komentārs var būt kā atbilde uz citu komentāru.
     *
     * @return HasOne
     */
    public function parentComment(): HasOne
    {
        return $this->hasOne(self::class, 'id', 'parent_id');
    }

    /**
     * Pārbauda, vai komentārs ir atbilde.
     *
     * @return bool
     */
    public function isReply(): bool
    {
        return !is_null($this->parent_id);
    }

    /**
     * Pārbauda, vai komentārs ir vecākkomentārs.
     *
     * @return bool
     */
    public function isParentComment(): bool
    {
        return is_null($this->parent_id);
    }

//    public function hasReplies()

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

    /**
     * Scope for comments on a specific artist.
     */
    public function scopeForTrack(Builder $query, int $artistId): Builder
    {
        return $query->where('artist_id', $artistId);
    }
}
