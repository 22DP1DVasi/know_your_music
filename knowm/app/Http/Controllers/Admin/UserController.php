<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        $users = User::with('roles')
            ->orderBy('name')
            ->paginate(8);

        return Inertia::render('Admin/Users/Index', [
            'users' => $users
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
        $user = User::with('roles')->findOrFail($id);

        return Inertia::render('Admin/Users/Edit', [
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'status' => $user->status,
                'roles' => $user->roles->pluck('id')->toArray()
            ],
            'statusOptions' => ['active', 'banned', 'deleted'],
            'allRoles' => Role::all()->map(function ($role) {
                return [
                    'id' => $role->id,
                    'name' => $role->name
                ];
            })
        ]);
    }

    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);
        $validated = $request->validate([
            'name' => 'required|string|max:100|unique:users,name,'.$user->id,
            'email' => 'required|email|max:100|unique:users,email,'.$user->id,
            'password' => 'nullable|string|min:8|confirmed',
            'status' => 'required|in:active,banned,deleted',
            'roles' => 'nullable|array',
            'roles.*' => 'exists:roles,id'
        ]);
        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']);
        }
        $user->update($validated);
        if (array_key_exists('roles', $validated)) {
            $user->roles()->sync($validated['roles']);
        }
        return redirect()->route('admin-users-index')
            ->with('success', 'User updated successfully');
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        if ($user->id === auth()->id()) {
            return redirect()->back()
                ->with('error', 'You cannot delete your own account');
        }
        $user->delete();
        return redirect()->route('admin-users-index')
            ->with('success', 'User deleted successfully');
    }
}
