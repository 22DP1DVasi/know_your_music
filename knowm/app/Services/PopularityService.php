<?php

namespace App\Services;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Support\Facades\Cache;

class PopularityService
{
    public function add(
        string $entityType,
        int $entityId,
        float $points,
        string $action,
        ?int $userId = null ): void {
        // create a key record
        // userId for authorised users, IP for guests
        $key = sprintf(
            'popularity:%s:%d:%s:%s',
            $entityType,
            $entityId,
            $action,
            $userId ?? request()->ip()
        );

        // anti-spam protection
        // if this exact record already exists in cache - ignore
        if (Cache::has($key)) {
            return;
        }

        // store data in the cache
        Cache::put(
            $key,
            true,
            now()->addHours(12)
        );

        // find exact entity and increment its popularity points
        match ($entityType) {
            'artist' =>
            Artist::whereKey($entityId)
                ->increment('popularity', $points),

            'release' =>
            Release::whereKey($entityId)
                ->increment('popularity', $points),

            'track' =>
            Track::whereKey($entityId)
                ->increment('popularity', $points),

            'genre' =>
            Genre::whereKey($entityId)
                ->increment('popularity', $points),

            default => null
        };
    }
}
