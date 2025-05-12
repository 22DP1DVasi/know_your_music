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
    protected Artist $artist;

    public function __construct(Artist $artist)
    {
        $this->artist = $artist;
    }

    public function index()
    {
        return Inertia::render('Admin/Artists/Index', [
            'artists' => Artist::orderBy('id')->paginate(20)
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
            'formed_year' => "nullable|integer|min:1900|max:{$nextYear}",
            'disbanded_year' => "nullable|integer|min:1900|max:{$nextYear}|gte:formed_year",
            'is_active' => 'required|boolean',
            'solo_or_band' => 'nullable|in:solo,band'
        ]);
        $this->artist->slug = $this->artist->generateUniqueSlug();
        $this->artist->save();
        return redirect()->route('admin-artists-index')
            ->with('success', 'Artist created successfully');
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
            'formed_year' => "nullable|integer|min:1900|max:{$nextYear}",
            'disbanded_year' => "nullable|integer|min:1900|max:{$nextYear}|gte:formed_year",
            'is_active' => 'required|boolean',
            'solo_or_band' => 'nullable|in:solo,band'
        ]);
        if ($artist->name !== $validated['name']) {
            $this->artist->slug = $this->artist->generateUniqueSlug();
            $this->artist->save();
        }
        $artist->update($validated);
        return redirect()->route('admin-artists-index')
            ->with('success', 'Artist updated successfully');
    }


    public function destroy($id)
    {
        $artist = Artist::findOrFail($id);
        $artist->delete();
        return redirect()->route('admin-artists-index')
            ->with('success', 'Artist deleted successfully');
    }
}
