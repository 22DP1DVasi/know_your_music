<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Genre;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Builder;
use App\Traits\HasThreadedComments;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasOneOrMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class GenreComment extends Model
{
    use HasFactory, HasThreadedComments, SoftDeletes;
    protected $table = 'comments_genres';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'text',
        'status',
//        'deleted_username',
        'user_id',
        'genre_id',
        'parent_id'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:i:s',
        'updated_at' => 'datetime:Y-m-d H:i:s',
        'deleted_at' => 'datetime:Y-m-d H:i:s',
        'edited_at' => 'datetime:Y-m-d H:i:s'
    ];

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
     * Get the genre this comment belongs to.
     */
    public function genre(): BelongsTo
    {
        return $this->belongsTo(Genre::class);
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
