<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Lyric extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'lyrics',
        'status',
        'track_id',
        'last_updated_by_user'
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'status' => 'string',
    ];

    /**
     * Get the track associated with these lyrics.
     */
    public function track(): BelongsTo
    {
        return $this->belongsTo(Track::class);
    }

    /**
     * Get the admin who last updated these lyrics.
     */
    public function lastUpdatedBy(): BelongsTo
    {
        return $this->belongsTo(Admin::class, 'last_updated_by_user');
    }

    /**
     * Scope for verified lyrics.
     */
    public function scopeVerified($query)
    {
        return $query->where('status', 'verified');
    }

    /**
     * Scope for lyrics needing verification.
     */
    public function scopeNeedsVerification($query)
    {
        return $query->where('status', 'requires verification');
    }

    /**
     * Update lyrics and track the admin.
     */
    public function updateLyrics(string $content, Admin $admin): bool
    {
        return $this->update([
            'lyrics' => $content,
            'status' => 'requires verification',
            'last_updated_by_user' => $admin->id
        ]);
    }

    /**
     * Verify lyrics (admin action).
     */
    public function verify(Admin $admin): bool
    {
        return $this->update([
            'status' => 'verified',
            'last_updated_by_user' => $admin->id
        ]);
    }
}
