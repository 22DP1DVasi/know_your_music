<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Users/Index', [
            'users' => User::with('roles')->paginate(10)
        ]);
    }

    public function create()
    {
        return Inertia::render('Admin/Users/Create', [
            'statusOptions' => ['active', 'banned']
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:100|unique:users',
            'email' => 'required|email|max:100|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'status' => 'required|in:active,banned'
        ]);
        $validated['password'] = Hash::make($validated['password']);

        User::create($validated);
        return redirect()->route('admin-users-index')
            ->with('success', 'User created successfully');
    }

    public function edit($id)
    {
        $user = User::findOrFail($id);
        return Inertia::render('Admin/Users/Edit', [
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'status' => $user->status
            ],
            'statusOptions' => ['active', 'banned']
        ]);
    }

    public function update(Request $request, User $user)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:100|unique:users,name,'.$user->id,
            'email' => 'required|email|max:100|unique:users,email,'.$user->id,
            'password' => 'nullable|string|min:8|confirmed',
            'status' => 'required|in:active,banned,deleted'
        ]);
        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']);
        }

        $user->update($validated);
        return redirect()->route('admin-users-index')
            ->with('success', 'User updated successfully');
    }
}
