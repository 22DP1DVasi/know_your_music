<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'status'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'status' => 'string'
    ];

    /**
     * Relationship with ArtistComment model
     */
    public function artistComments()
    {
        return $this->hasMany(ArtistComment::class);
    }

    /**
     * Relationship with ReleaseComment model
     */
    public function releaseComments()
    {
        return $this->hasMany(ReleaseComment::class);
    }

    /**
     * Relationship with TrackComment model
     */
    public function trackComments()
    {
        return $this->hasMany(TrackComment::class);
    }

    /**
     * Remember comment's author's username when they get deleted
     */
    protected static function booted()
    {
        static::deleting(function ($user) {
            // Store usernames in artist comments
            $user->artistComments()->update([
                'deleted_username' => $user->name
            ]);

            // Store usernames in release comments
            $user->releaseComments()->update([
                'deleted_username' => $user->name
            ]);
        });
    }

    /**
     * Get the favorite artists for the user.
     */
    public function favoriteArtists()
    {
        return $this->belongsToMany(Artist::class, 'user_favorite_artists')
            ->withPivot(['sort_order', 'added_at'])
            ->orderBy('sort_order');
    }

    /**
     * Mark user as deleted.
     */
    public function markAsDeleted(): bool
    {
        return $this->update([
            'status' => 'deleted',
            'email' => 'deleted_' . $this->id . '_' . $this->email, // prevent email reuse
            'name' => 'Deleted User'
        ]);
    }

    /**
     * Scope to filter active users.
     */
    public function scopeActive($query)
    {
        return $query->where('status', 'active');
    }
}
