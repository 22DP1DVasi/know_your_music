<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Services\ArtistService;
use App\Services\ReleaseService;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ArtistController extends Controller
{
    /***
     * Metode priekš Index.vue lapas.
     * Šī metode uzskaita visus mūziķus ar lietotiem meklēšanas
     * vai filtrēšanas parametriem no pieprasījuma ($request).
     *
     * @param Request $request
     * @return \Inertia\Response
     */
    public function index(Request $request)
    {
        $artists = Artist::query()
            ->when($request->search_name, function ($query, $search) {
                $query->where('name', 'like', "%{$search}%");
            })
            ->when($request->filter_type, function ($query, $type) {
                $query->where('solo_or_band', $type);
            })
            ->when($request->filter_status !== null, function ($query) use ($request) {
                $query->where('is_active', $request->filter_status);
            })
            ->orderBy('name')
            ->paginate(10)
            ->withQueryString();

        return Inertia::render('Admin/Artists/Index', [
            'artists' => $artists,
            'filters' => $request->only([
                'search_name',
                'filter_type',
                'filter_status'
            ])
        ]);
    }

    public function create()
    {
        return Inertia::render('Admin/Artists/Create', [
            'soloOrBandOptions' => ['solo', 'band']
        ]);
    }

    public function store(Request $request)
    {
        $nextYear = date('Y', strtotime('+1 year'));
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'biography' => 'nullable|string',
            'biography_lv' => 'nullable|string',
            'formed_year' => "nullable|integer|min:1900|max:{$nextYear}",
            'disbanded_year' => "nullable|integer|min:1900|max:{$nextYear}|gte:formed_year", // gte -> greater than or equal / lielāks vai vienāds
            'is_active' => 'required|boolean',
            'solo_or_band' => 'nullable|in:solo,band'
        ]);
        // izveidot izpildītāju ar validētiem datiem
        $artist = Artist::create($validated);
        // ģenerēt un saglabāt slug'u
        $artist->slug = $artist->generateUniqueSlug();
        $artist->save();
        return redirect()->route('admin-artists-index')
            ->with('success', __('messages.artist_created'));
    }

    public function edit($id)
    {
        $artist = Artist::findOrFail($id);
        return Inertia::render('Admin/Artists/Edit', [
            'artist' => $artist,
            'soloOrBandOptions' => ['solo', 'band']
        ]);
    }

    public function update(Request $request, $id)
    {
        $artist = Artist::findOrFail($id);
        $nextYear = date('Y', strtotime('+1 year'));
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'biography' => 'nullable|string',
            'biography_lv' => 'nullable|string',
            'formed_year' => "nullable|integer|min:1900|max:{$nextYear}",
            'disbanded_year' => "nullable|integer|min:1900|max:{$nextYear}|gte:formed_year",
            'is_active' => 'required|boolean',
            'solo_or_band' => 'nullable|in:solo,band'
        ]);
        // pārbaudiet, vai nosaukums ir mainīts
        if ($artist->name !== $validated['name']) {
            $validated['slug'] = $artist->generateUniqueSlug($validated['name']);
        }
        $artist->update($validated);
        return redirect()->route('admin-artists-index')
            ->with('success', __('messages.artist_updated'));
    }

    public function destroy($id)
    {
        $artist = Artist::findOrFail($id);
        $artist->delete();
        return redirect()->route('admin-artists-index')
            ->with('success', __('messages.artist_deleted'));
    }
}
