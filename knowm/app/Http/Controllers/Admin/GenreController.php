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

class GenreController extends Controller
{
    /***
     * Method for Index.vue page.
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request): \Inertia\Response
    {
        $genres = Genre::query()
            ->when($request->search_name, function ($query, $search) {
                $query->where('name', 'like', "%{$search}%");
            })
            ->when($request->origin_year, function ($query, $year) {
                $query->where('origin_year', $year);
            })
            ->orderBy('name')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Admin/Genres/Index', [
            'genres' => $genres,
            'filters' => $request->only(['search_name', 'origin_year'])
        ]);
    }

    /***
     * Deletes the given genre.
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id): \Illuminate\Http\RedirectResponse
    {
        $genre = Genre::findOrFail($id);
        $genre->delete();
        return redirect()->route('admin-genres-index')
            ->with('success', __('messages.genre_deleted'));
    }

    /***
     * Method for Edit.vue.
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function edit($id): \Inertia\Response
    {
        $genre = Genre::query()
            ->with([
                'tracks' => fn ($query) => $query
                    ->with('artists:id,name,slug')
                    ->latest()
                    ->limit(25)
            ])
            ->findOrFail($id);

        return Inertia::render('Admin/Genres/Edit', [
            'genre' => [
                'id' => $genre->id,
                'name' => $genre->name,
                'slug' => $genre->slug,
                'origin_year' => $genre->origin_year,
                'origin_country' => $genre->origin_country,
                'description' => $genre->description,
                'description_lv' => $genre->description_lv,
                'popularity' => $genre->popularity,
                'created_at' => $genre->created_at,
                'updated_at' => $genre->updated_at,
                'banner_url' => $genre->banner_url,
                'profile_url' => $genre->profile_url,

                'initial_tracks' => $genre->tracks->map(fn ($track) => [
                    'id' => $track->id,
                    'title' => $track->title,
                    'slug' => $track->slug,
                    'duration' => $track->duration,
                    'cover_url' => $track->cover_url,

                    'artists' => $track->artists->map(fn ($artist) => [
                        'id' => $artist->id,
                        'name' => $artist->name,
                        'slug' => $artist->slug,
                    ]),
                ]),
            ]
        ]);
    }

    /***
     * Updates the track's record.
     *
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(Request $request, $id): \Illuminate\Http\RedirectResponse
    {
        $genre = Genre::findOrFail($id);
        $currentYear = (int) date('Y');
        $maxYear = $currentYear + 10;
        $validated = $request->validate([
            'name' => 'required|string|max:100|unique:genres,name,' . $id,
            'origin_year' => "nullable|integer|min:1900|max:{$maxYear}",
            'origin_country' => 'nullable|string|max:100',
            'description' => 'nullable|string',
            'description_lv' => 'nullable|string',
        ]);

        $genre->update($validated);

        return redirect()->route('admin-genres-edit', $genre->id)
            ->with('success', __('messages.genre_updated'));
    }

    public function updateImage(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $genre = Genre::findOrFail($id);
        $request->validate([
            'type' => 'required|in:banner,profile',
            'banner' => 'required_if:type,banner|file|mimes:webp|max:2048',
            'profile' => 'required_if:type,profile|file|mimes:webp|max:2048',
        ]);
        $type = $request->type;
        // iegūt failu no pieprasījuma
        $fileField = $type;    // 'banner' vai 'profile'
        $file = $request->file($fileField);
        // Storage ceļa definēšana ar fiksētu faila nosaukumu
        $filename = $type . '.webp';    // banner.webp or profile.webp
        $directory = 'genres/' . $genre->id . '/' . $type;
        $path = $directory . '/' . $filename;

        // pārliecināties, vai direktorija pastāv
        Storage::disk('public')->makeDirectory($directory);
        // saglabāt failu ar fiksētu nosaukumu (pārraksta, ja pastāv)
        Storage::disk('public')->put($path, file_get_contents($file));
        return response()->json([
            'success' => true,
            'image_url' => Storage::url($path) . '?t=' . time(), // pievienot timestamp'u, lai novērstu kešdarbi
        ]);
    }

    /***
     * Sinhronizē žanrus dotajam entitījam.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function sync(Request $request): \Illuminate\Http\JsonResponse
    {
        $data = $request->validate([
            'entity_type' => 'required|in:artist,release,track',
            'entity_id' => 'required|integer',
            'genre_ids' => 'array',
            'genre_ids.*' => 'exists:genres,id'
        ]);

        $model = match ($data['entity_type']) {
            'artist' => Artist::class,
            'release' => Release::class,
            'track' => Track::class,
        };
        $entity = $model::findOrFail($data['entity_id']);
        $entity->genres()->sync($data['genre_ids']);
        return response()->json(['success' => true]);
    }

    /***
     * Searches for tracks related to the genre.
     *
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function searchTracks(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $genre = Genre::findOrFail($id);
        $query = trim($request->get('q', ''));
        if (mb_strlen($query) < 2) {
            return response()->json([]);
        }
        $tracks = $genre->tracks()
            ->with([
                'artists:id,name,slug'
            ])
            ->where('title', 'like', "%{$query}%")
            ->orderBy('title')
            ->limit(50)
            ->get();

        return response()->json(
            $tracks->map(fn ($track) => [
                'id' => $track->id,
                'title' => $track->title,
                'slug' => $track->slug,
                'duration' => $track->duration,
                'cover_url' => $track->cover_url,
                'artists' => $track->artists->map(fn ($artist) => [
                    'id' => $artist->id,
                    'name' => $artist->name,
                    'slug' => $artist->slug,
                ])
            ])
        );
    }
}
