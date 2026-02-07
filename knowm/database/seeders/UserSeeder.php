<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    /**
     * Palaist datu bāzes seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            'name' => Str::random(8),
            'email' => Str::random(18).'@example.com',
            'password' => Hash::make('password'),
            'status' => 'active'
        ]);
    }
}
