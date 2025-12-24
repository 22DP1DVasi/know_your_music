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
        $user = User::with(['roles' => function ($query) {
            $query->select('roles.id', 'roles.name', 'roles.description')
                ->withPivot('created_at');
        }])->findOrFail($id);
        return Inertia::render('Admin/Users/Edit', [
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'status' => $user->status,
                'roles' => $user->roles->map(fn ($role) => [
                    'id' => $role->id,
                    'name' => $role->name,
                    'description' => $role->description,
                    'assigned_at' => $role->pivot->created_at,
                ]),
            ],
            'statusOptions' => ['active', 'banned', 'deleted'],
            'allRoles' => Role::select('id', 'name', 'description')->get(),
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


    /***
     * Metode, kas saglabā visas piešķirtās lomas lietotājam.
     *
     * @param Request $request
     * @param User $user
     * @return \Illuminate\Http\RedirectResponse
     */
    public function storeRoles(Request $request, User $user)
    {
        $validated = $request->validate([
            'roles' => ['required', 'array'],
            'roles.*' => ['integer', 'exists:roles,id'],
        ]);

        // pievienot lomas, nenoņemot esošās lomas
        $user->roles()->syncWithoutDetaching($validated['roles']);
        return redirect()->back()->with('success', 'Roles assigned successfully');
    }

    /**
     * Metode, kas dzēš (noņem) lomu no lietotāja.
     *
     * @param $userId
     * @param $roleId
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroyUserRole($userId, $roleId)
    {
        $user = User::findOrFail($userId);
//        $role = Role::findOrFail($roleId);
        // Neļaut dzēst administratora lomu no sevis
//        if ($user->id === auth()->id() && $role->name === 'admin') {
//            return redirect()->back()
//                ->with('error', 'You cannot remove your own admin role.');
//        }
        // lomas atvienošana no lietotāja (pivot tabula)
        $user->roles()->detach($roleId);
        return redirect()->route('admin-users-edit', ['id' => $userId])
            ->with('success', 'Role removed successfully.');
    }
}
