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
            'name' => [
                'required',
                'string',
                'max:255',
                'unique:users,name',
                'regex:/^[a-zA-Z0-9_]+$/', // restrict to alphanumeric + underscore
                ],
            'email' => [
                'required',
                'string',
                'lowercase',
                'email',
                'max:100',
                'unique:users,email'
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
            'name.unique' => __('messages.signup.name_unique'),
            'name.regex' => __('messages.signup.name_regex'),
            'email.unique' => __('messages.signup.email_unique'),
            'password.confirmed' => __('messages.signup.password_confirmed')
        ];
    }
}
