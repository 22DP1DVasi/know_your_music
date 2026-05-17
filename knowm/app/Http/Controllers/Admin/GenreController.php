<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Http\Request;
use Inertia\Inertia;

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
}
