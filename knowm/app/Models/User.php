<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Support\Facades\DB;
use App\Models\CommentArtist;

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
     * Get the favorite artists for the user.
     */
    public function favoriteArtists()
    {
        return $this->belongsToMany(Artist::class, 'user_favorite_artists')
            ->withPivot(['sort_order', 'added_at'])
            ->orderBy('sort_order');
    }

    /**
     * Relationship with ArtistComment model
     */
    public function artistComments()
    {
        return $this->hasMany(ArtistComment::class);
    }

    /**
     * Remember comment's author's username when they get deleted
     */
    protected static function saveDeletedUsername()
    {
        static::deleting(function ($user) {
            ArtistComment::where('user_id', $user->id)
                ->update(['deleted_username' => $user->name]);
        });
    }

    /**
     * Scope to filter active users.
     */
    public function scopeActive($query)
    {
        return $query->where('status', 'active');
    }
}
