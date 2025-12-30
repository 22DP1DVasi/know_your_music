<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Role;
use Inertia\Inertia;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    /***
     * Metode priekš Index.vue lapas.
     * Šī metode uzskaita visas lomas ar lietotiem meklēšanas
     * vai filtrēšanas parametriem no pieprasījuma ($request).
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request): \Inertia\Response
    {
        $roles = Role::query()
            ->when($request->search_name, function ($query, $search) {
                $query->where('name', 'like', "%{$search}%");
            })
            ->when($request->search_description, function ($query, $search) {
                $query->where('description', 'like', "%{$search}%");
            })
            ->when(
                in_array($request->sort_order, ['asc', 'desc']),
                fn ($query) => $query->orderBy('name', $request->sort_order),
                fn ($query) => $query->orderBy('name', 'asc')
            )
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Admin/Roles/Index', [
            'roles' => $roles,
            'filters' => $request->only([
                'search_name',
                'search_description',
                'sort_order',
            ]),
        ]);
    }

}
