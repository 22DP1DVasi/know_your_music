<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\User;
use App\Models\Track;

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

    protected $appends = ['clean_lyrics', 'original_lyrics'];

    /**
     * Get the track associated with these lyrics.
     */
    public function track(): BelongsTo
    {
        return $this->belongsTo(Track::class);
    }

    /**
     * Get the user (admin) who last updated these lyrics.
     */
    public function lastUpdatedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'last_updated_by_user');
    }

    /**
     * Get cleaned lyrics
     * @deprecated after placing standard to save lyrics to table without control characters
     */
    public function getCleanLyricsAttribute(): string
    {
        return $this->cleanLyrics();
    }

    /**
     * Get original lyrics
     * @deprecated after placing standard to save lyrics to table without control characters
     */
    public function getOriginalLyricsAttribute(): string
    {
        return $this->lyrics;
    }

    /**
     * Clean lyrics from control characters and normalize whitespace
     * @deprecated after placing standard to save lyrics to table without control characters
     */
    public function cleanLyrics(string $lyrics = null): string
    {
        $lyrics = $lyrics ?? $this->lyrics;
        $cleaned = preg_replace('/[\x00-\x09\x0B\x0C\x0E-\x1F\x7F]/u', '', $lyrics);
        $cleaned = str_replace(['\r\n', '\r', '\n'], ' ', $cleaned);
        $cleaned = preg_replace('/\R+/u', ' ', $cleaned);
        $cleaned = preg_replace('/\s+/', ' ', $cleaned);
        return trim($cleaned);
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
    public function updateLyrics(string $content, User $user): bool
    {
        return $this->update([
            'lyrics' => $content,
            'status' => 'requires verification',
            'last_updated_by_user' => $user->id
        ]);
    }

    /**
     * Verify lyrics (admin action).
     */
    public function verify(User $user): bool
    {
        return $this->update([
            'status' => 'verified',
            'last_updated_by_user' => $user->id
        ]);
    }
}
