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
            'cover' => 'required|image|mimes:webp|max:2048', // 2MB max, only webp
        ]);

        // Build directory path: releases/{release_type}/{release_id}
        $directory = "releases/{$release->release_type}/{$release->id}";
        $fullPath = Storage::disk('public')->path($directory);

        // Create directory if it doesn't exist
        if (!file_exists($fullPath)) {
            mkdir($fullPath, 0755, true);
        }

        // Store the file as cover.webp
        $file = $request->file('cover');
        $filename = 'cover.webp';
        $path = $file->storeAs($directory, $filename, 'public');

        // Update the release's cover_url if needed (optional, but we keep consistent)
        // The model accessor will automatically return the correct URL based on path.
        // We can optionally set a 'cover' attribute but it's not required if we always derive.

        // For consistency, you might store the relative path in the DB (e.g., 'cover_path')
        // but the requirement says cover_url is read-only and derived. So just return the new URL.

        $coverUrl = Storage::disk('public')->url($path);

        return response()->json([
            'success' => true,
            'cover_url' => $coverUrl,
        ]);
    }
}
