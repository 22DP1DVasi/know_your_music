<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;
use App\Models\User;

class RegisterUserRequest extends FormRequest
{
    public function authorize()
    {
        return true; // registration is open to all
    }

    public function rules()
    {
        return [
            'name' => ['required', 'string', 'max:100'],
            'email' => [
                'required',
                'string',
                'lowercase',
                'email',
                'max:100',
                'unique:'.User::class
            ],
            'password' => ['required', 'confirmed',
                Password::defaults()
                    ->letters()
                    ->mixedCase()
                    ->numbers()
                    ->symbols()
                    ->uncompromised()],
            'website' => ['bail', 'nullable', 'string', 'max:0'],   // honeypot
        ];
    }

    public function messages()
    {
        return [
            'email.unique' => 'This email is already registered. Please login or use a different email.',
            'password.confirmed' => 'Password confirmation does not match.',
        ];
    }
}
