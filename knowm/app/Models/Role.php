<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'description'
    ];

    /**
     * The users that belong to the role.
     */
    public function users()
    {
        return $this->belongsToMany(User::class)->withTimestamps();
    }

    /**
     * Scope for admin role.
     */
    public function scopeAdmin($query)
    {
        return $query->where('name', 'admin');
    }

    /**
     * Check if role is admin.
     */
    public function isAdmin(): bool
    {
        return $this->name === 'admin';
    }
}
