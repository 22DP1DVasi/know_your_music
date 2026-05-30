<?php

namespace App\Rules;

use Illuminate\Validation\Rules\Password;

class PasswordRules
{
    public static function defaults(): array
    {
        return [
            'required',
            'confirmed',
            Password::min(12)
                ->letters()
                ->mixedCase()
                ->numbers()
                ->symbols()
                ->uncompromised(),
        ];
    }
}
