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
use Illuminate\Database\Eloquent\SoftDeletes;
use Storage;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'slug',
        'email',
        'password',
        'status',
        'avatar'
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
        'deleted_at' => 'datetime:Y-m-d H:i:s',
    ];

    protected $appends = ['avatar_url', 'initial', 'avatar_color_1', 'avatar_color_2'];

    /**
     * Remember comment's author's username when they get deleted
     */
    protected static function booted()
    {
        static::creating(function ($user) {
            $user->slug = $user->generateUniqueSlug($user->name);
        });
        static::updating(function ($user) {
            if ($user->isDirty('name')) {
                $user->slug = $user->generateUniqueSlug($user->name);
            }
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
     * Helper method to freely use 'playlist' name in routes.
     *
     * @return HasMany
     */
    public function playlists()
    {
        return $this->hasMany(UserCollection::class);
    }

    /**
     * @return string|null
     */
    public function getAvatarUrlAttribute(): ?string
    {
//        if (!$this->avatar) {
//            return asset('images/default-user-avatar.png');
//        }
//
//        return Storage::url($this->avatar);
        if ($this->avatar) {
            return asset('storage/' . $this->avatar);
        }
        return null;
    }

    /***
     * Dabūt 'initial' (sākumburta) atribūtu.
     *
     * @return string
     */
    public function getInitialAttribute(): string
    {
        return strtoupper(substr($this->name, 0, 1));
    }

    /***
     * Dabūt 'avatar_color_1' atribūtu.
     *
     * @return string
     */
    public function getAvatarColor1Attribute(): string
    {
        // heksadecimāla jaucējkoda izveide
        $hash = $this->getHashFromName($this->name);

        // izmantot pirmos baitus tonim (0-360)
        $hue = hexdec(substr($hash, 0, 4)) % 360;

        // saglabāt piesātinājumu un gaišumu jaukos UI drošos diapazonos
        $saturation = 65;
        $lightness = 55;
        return "hsl($hue, {$saturation}%, {$lightness}%)";
    }

    /***
     * Dabūt 'avatar_color_2' atribūtu.
     *
     * @return string
     */
    public function getAvatarColor2Attribute(): string
    {
        // heksadecimāla jaucējkoda izveide
        $hash = $this->getHashFromName($this->name);

        // izmantot pirmos baitus tonim (0-360)
        $hue = hexdec(substr($hash, 0, 4)) % 360;

        // nedaudz nobīdīt tonu un palielināt gaišumu otrajai krāsai
        $hue2 = ($hue + 20) % 360;
        $saturation = 65;
        $lightness = 65;
        return "hsl($hue2, {$saturation}%, {$lightness}%)";
    }

    /***
     * Veido heksadecimālo jaucējkodu no dota vārda.
     *
     * @param string $name
     * @return string
     */
    private function getHashFromName(string $name): string
    {
        // heksadecimāla jaucējkoda izveide
        return md5($name);
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
        return $this->roles()
            ->whereIn('name', $roles)
            ->exists();
    }

    /***
     * Pārbauda, vai lietotājam ir superadministratora loma.
     *
     * @return bool
     */
    public function isSuperAdmin(): bool
    {
        return $this->roles()
            ->where('name', 'super_admin')
            ->exists();
    }

    /***
     * Check if user can access the admin panel.
     *
     * @return bool
     */
    public function canAccessAdminPanel(): bool
    {
        return $this->roles()
            ->whereIn('name',['super_admin'])
            ->exists();
    }

    /***
     * Pārbauda, vai lietotājam ir komentāru regulētāja loma.
     *
     * @return bool
     */
    public function hasCommentAdminRole(): bool
    {
        return $this->roles()
            ->where('name', 'comments_moderator')
            ->exists();
    }

    /**
     * Iegūt tekstveida identifikatora vērtību (tiek izmantota kā maršruta atslēga lietotāju lapai)
     */
    public function getRouteKeyName()
    {
        return 'slug';
    }

    /**
     * Ģenerēt unikālu tekstveida identifikatoru.
     */
    public function generateUniqueSlug($name = null)
    {
        $nameToUse = $name ?? $this->name;
        $slug = $this->customSlugify($nameToUse);
        $originalSlug = $slug;
        $counter = 1;
        while (static::where('slug', $slug)
            ->where('id', '!=', $this->id) // atjaunināšanas laikā izslēgt pašreizējo izpildītāju
            ->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }
        return $slug;
    }

    /**
     * Pielāgot vārdu tekstveida identifikatoram
     */
    private function customSlugify(string $name): string
    {
        $slug = mb_strtolower($name);
        $slug = preg_replace('/\s+/u', '-', $slug);
        $slug = preg_replace('/[^\p{L}\p{N}]+/u', '-', $slug);
        return trim($slug, '-');
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
    public function favoriteArtists()
    {
        return $this->belongsToMany(Artist::class, 'user_favorite_artists')
            ->withTimestamps();
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
