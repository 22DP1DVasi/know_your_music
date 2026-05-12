<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Storage;

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

    public function edit($id): \Inertia\Response
    {
        $release = Release::findOrFail($id);

        return Inertia::render('Admin/Releases/Edit', [
            'release' => $release,
            'releaseTypes' => ['album', 'ep', 'single', 'compilation'],
        ]);
    }

    public function update(Request $request, $id): \Illuminate\Http\RedirectResponse
    {
        $release = Release::findOrFail($id);

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'release_date' => 'nullable|date',
            'release_type' => 'required|in:album,ep,single,compilation',
            'description' => 'nullable|string',
            'description_lv' => 'nullable|string',
        ]);

        $release->update($validated);

        return redirect()->route('admin-releases-edit', $release->id)
            ->with('success', 'Release updated successfully.');
    }

    public function updateCover(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $release = Release::findOrFail($id);
        $request->validate([
            'cover' => 'required|file|mimes:webp|max:2048',
        ]);
        $filename = 'cover.webp';
        $directory = "releases/{$release->release_type}/{$release->id}";
        $path = $directory . '/' . $filename;
        // ensure directory exists
        Storage::disk('public')->makeDirectory($directory);
        // get uploaded file
        $file = $request->file('cover');
        // store file with fixed name
        Storage::disk('public')->put($path, file_get_contents($file));

        return response()->json([
            'success' => true,
            'cover_url' => Storage::url($path) . '?t=' . time(),
        ]);
    }
}
