<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ReleaseController extends Controller
{
    /***
     * For Index.vue page.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request): \Inertia\Response
    {
        $releases = Release::query()
            ->with('artists:id,name')
            ->when($request->search_title, function ($query, $search) {
                $query->where('title', 'like', "%{$search}%");
            })
            ->when($request->filter_type, function ($query, $type) {
                $query->where('release_type', $type);
            })
            ->orderBy('title')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Admin/Releases/Index', [
            'releases' => $releases,
            'filters' => $request->only(['search_title', 'filter_type'])
        ]);
    }

    /***
     * Deletes the album.
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id): \Illuminate\Http\RedirectResponse
    {
        $release = Release::findOrFail($id);
        $release->delete();
        return redirect()->route('admin-releases-index')
            ->with('success', __('messages.release_deleted'));
    }
}
