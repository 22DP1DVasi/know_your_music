<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Role;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

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

    /***
     * Metode priekš Create.vue lapas.
     * Atveido vue lapu.
     *
     * @return \Inertia\Response
     */
    public function create(): \Inertia\Response
    {
        return Inertia::render('Admin/Roles/Create');
    }

    /***
     * Metode, kas saglabā jaunu lomu datubāzē.
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request): \Illuminate\Http\RedirectResponse
    {
        // validācija
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:80',
                'unique:roles',
            ],
            'description' => [
                'nullable',
                'string',
                'max:255'
            ]
        ]);
        $role = Role::create($validated);
        return redirect()->route('admin-roles-index', $role->id)
            ->with('success', __('messages.role_created'));
    }

    /***
     * Metode priekš Edit.vue lapas.
     * Šī metode ņēm datus par rediģējāmo lomu, lai attēlotu UI.
     *
     * @param int $id
     * @return \Inertia\Response
     */
    public function edit(int $id): \Inertia\Response
    {
        $role = Role::select('id', 'name', 'description')
            ->findOrFail($id);
        return Inertia::render('Admin/Roles/Edit', [
            'role' => $role,
        ]);
    }

    /***
     * Rediģētas lomas saglabāšanas metode.
     * Veic validāciju un saglabā jaunus datus lomai.
     *
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(Request $request, int $id): \Illuminate\Http\RedirectResponse
    {
        $role = Role::findOrFail($id);
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:80',
                'unique:roles,name,' . $role->id,
            ],
            'description' => [
                'nullable',
                'string',
                'max:255',
            ],
        ]);
        $role->update($validated);
        return redirect()
            ->route('admin-roles-index')
            ->with('success', __('messages.role_updated'));
    }

    /***
     * Metode, kas dzēš lomu.
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        $role = Role::findOrFail($id);
        $role->delete();
        return redirect()->route('admin-roles-index')
            ->with('success', __('messages.role_deleted'));
    }

}
