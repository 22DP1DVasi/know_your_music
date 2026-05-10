<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use Illuminate\Http\Request;

class GenreController extends Controller
{
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
        return response()->json(['message' => 'Genres updated successfully']);
    }
}
