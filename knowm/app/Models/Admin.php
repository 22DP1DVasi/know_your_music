<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class Admin extends Authenticatable
{
    use HasFactory, Notifiable;

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
     * Polymorphic relationship with ArtistComment model
     */
    public function artistComments()
    {
        return $this->morphMany(ArtistComment::class, 'commenter');
    }

    /**
     * Polymorphic relationship with ReleaseComment model
     */
    public function releaseComments()
    {
        return $this->morphMany(ReleaseComment::class, 'commenter');
    }

    /**
     * Polymorphic relationship with TrackComment model
     */
    public function trackComments()
    {
        return $this->morphMany(TrackComment::class, 'commenter');
    }

    /**
     * Scope for active admins
     */
    public function scopeActive($query)
    {
        return $query->where('status', 'active');
    }

    /**
     * Scope for banned admins
     */
    public function scopeBanned($query)
    {
        return $query->where('status', 'banned');
    }

    /**
     * Remember admin's username when they get deleted from comments
     */
    protected static function booted()
    {
        static::deleting(function ($admin) {
            // update all comments where this user is the commenter
            ArtistComment::where('commenter_type', self::class)
                ->where('commenter_id', $admin->id)
                ->update(['deleted_username' => $admin->name]);

            ReleaseComment::where('commenter_type', self::class)
                ->where('commenter_id', $admin->id)
                ->update(['deleted_username' => $admin->name]);

            TrackComment::where('commenter_type', self::class)
                ->where('commenter_id', $admin->id)
                ->update(['deleted_username' => $admin->name]);
        });
    }
}
