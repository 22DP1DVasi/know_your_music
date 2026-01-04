<?php

namespace App\Traits;

trait HasThreadedComments
{
    public function parent()
    {
        return $this->belongsTo(static::class, 'parent_id');
    }

    public function replies()
    {
        return $this->hasMany(static::class, 'parent_id')
            ->orderBy('created_at', 'asc');
    }

    public function scopeParents($query)
    {
        return $query->whereNull('parent_id');
    }
}
