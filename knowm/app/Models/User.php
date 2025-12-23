<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
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
        'created_at' => 'datetime:Y-m-d H:i:s',
        'updated_at' => 'datetime:Y-m-d H:i:s',
    ];

    /**
     * Remember comment's author's username when they get deleted
     */
    protected static function booted()
    {
        static::deleting(function ($user) {
            // update all comments where this user is the author
            ArtistComment::where('user_id', $user->id)
                ->update(['deleted_username' => $user->name]);
            ReleaseComment::where('user_id', $user->id)
                ->update(['deleted_username' => $user->name]);
            TrackComment::where('user_id', $user->id)
                ->update(['deleted_username' => $user->name]);
        });
    }

    /**
     * Relationship with ArtistComment model
     */
    public function artistComments(): HasMany
    {
        return $this->hasMany(ArtistComment::class);
    }

    /**
     * Relationship with ReleaseComment model
     */
    public function releaseComments(): HasMany
    {
        return $this->hasMany(ReleaseComment::class);
    }

    /**
     * Relationship with TrackComment model
     */
    public function trackComments(): HasMany
    {
        return $this->hasMany(TrackComment::class);
    }

    /**
     * Roles assigned to this user
     */
    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(Role::class, 'users_roles')
            ->withPivot('created_at')
            ->withTimestamps();
    }

    /**
     * Collections owned by this user
     */
    public function collections(): HasMany
    {
        return $this->hasMany(UserCollection::class);
    }

    /**
     * Assign role to this user
     */
    public function assignRole($role): void
    {
        if (is_string($role)) {
            $role = Role::whereName($role)->firstOrFail();
        }
        $this->roles()->syncWithoutDetaching($role);
    }

    /**
     * Check if this user has a certain role
     */
    public function hasRole($roleName): bool
    {
        return $this->roles()->where('name', $roleName)->exists();
    }

    /**
     * Check if this user has any of the given roles
     */
    public function hasAnyRole(array $roles): bool
    {
        return $this->roles()->whereIn('name', $roles)->isNotEmpty();
    }

    /**
     * Create a new collection for this user
     */
    public function createCollection(array $data): UserCollection
    {
        return $this->collections()->create($data);
    }

    /**
     * Get the favorite artists for the user.
     */
    public function favoriteArtists(): BelongsToMany
    {
        return $this->belongsToMany(Artist::class, 'user_favorite_artists')
            ->using(UserFavoriteArtist::class)
            ->withPivot('sort_order')
            ->orderBy('user_favorite_artists.sort_order');
    }

    /**
     * Get recommendations packages for the user
     */
    public function recommendations(): HasMany
    {
        return $this->hasMany(Recommendation::class);
    }

    /**
     * Get the latest recommendations package for the user
     */
    public function latestRecommendations(): HasOne
    {
        return $this->hasOne(Recommendation::class)->latest();
    }

    /**
     * Mark user as deleted.
     */
    public function markAsDeleted(): bool
    {
        return $this->update([
            'status' => 'deleted',
            'email' => 'deleted_' . $this->id . '_' . $this->email,  // prevent email reuse
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

    /**
     * Scope to filter users by role.
     */
    public function scopeWithRole($query, $role)
    {
        return $query->whereHas('roles', function ($q) use ($role) {
            $q->where('name', $role);
        });
    }
}
