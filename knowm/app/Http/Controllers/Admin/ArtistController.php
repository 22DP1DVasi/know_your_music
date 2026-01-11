<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Artist;
use App\Services\ArtistService;
use App\Services\ReleaseService;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Storage;

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
//        $artist->slug = $artist->generateUniqueSlug();
        $artist->save();
        return redirect()->route('admin-artists-index')
            ->with('success', __('messages.artist_created'));
    }

    /***
     * Metode priekš Edit.vue lapas.
     * Vaicā informāciju par izvēlēto izpildītāju, lai attēlotu lapā.
     * Izpildītājs + viņa žanri + albumi + dziesmas.
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function edit($id): \Inertia\Response
    {
        $artist = Artist::query()
            ->with([
                'genres:id,name',
                'releases:id,title,release_date,release_type',
                'tracks:id,title,duration',
            ])
            ->findOrFail($id);

        return Inertia::render('Admin/Artists/Edit', [
            'artist' => [
                'id' => $artist->id,
                'name' => $artist->name,
                'slug' => $artist->slug,
                'biography' => $artist->biography,
                'biography_lv' => $artist->biography_lv,
                'formed_year' => $artist->formed_year,
                'disbanded_year' => $artist->disbanded_year,
                'is_active' => $artist->is_active,
                'solo_or_band' => $artist->solo_or_band,
                'popularity' => $artist->popularity,
                'created_at' => $artist->created_at,
                'updated_at' => $artist->updated_at,
                'banner_url' => $artist->banner_url,
                'profile_url' => $artist->profile_url,
                // žanri
                'genres' => $artist->genres->map(fn ($genre) => [
                    'id' => $genre->id,
                    'name' => $genre->name,
                ]),
                // albumi + starptabula
                'releases' => $artist->releases->map(fn ($release) => [
                    'id' => $release->id,
                    'title' => $release->title,
                    'release_date' => $release->release_date,
                    'release_type' => $release->release_type,
                    'role' => $release->pivot->role,
                    'cover_url' => $release->cover_url,
                ]),
                // dziesmas + starptabula
                'tracks' => $artist->tracks->map(fn ($track) => [
                    'id' => $track->id,
                    'title' => $track->title,
                    'duration' => $track->duration,
                    'role' => $track->pivot->role,
                    'cover_url' => $track->cover_url,
                ]),
            ],
            'soloOrBandOptions' => ['solo', 'band'],
        ]);
    }

    /***
     * Rediģēta izpildītāja saglabāšanas metode.
     * Veic validāciju un saglabā jaunus datus izpildītājam.
     *
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(Request $request, int $id): \Illuminate\Http\RedirectResponse
    {
        $artist = Artist::findOrFail($id);
        $currentYear = (int) date('Y');
        $maxYear = $currentYear + 10;
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'biography' => 'nullable|string',
            'biography_lv' => 'nullable|string',
            'formed_year' => "nullable|integer|min:1900|max:{$maxYear}",
            'disbanded_year' => "nullable|integer|min:1900|max:{$maxYear}|gte:formed_year",
            'is_active' => 'required|boolean',
            'solo_or_band' => 'nullable|in:solo,band',
        ]);
        // automātiski atjaunināt slug'u tikai tad, ja ir mainīts nosaukums
//        if ($artist->name !== $validated['name']) {
//            $validated['slug'] = $artist->generateUniqueSlug($validated['name']);
//        }
        $artist->update($validated);
        return redirect()
            ->route('admin-artists-index')
            ->with('success', __('messages.artist_updated'));
    }

    public function destroy($id)
    {
        $artist = Artist::findOrFail($id);
        $artist->delete();
        return redirect()->route('admin-artists-index')
            ->with('success', __('messages.artist_deleted'));
    }

    /***
     * Atjaunināt izpildītāja attēlu (baners vai profils).
     *
     * @param Request $request
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateImage(Request $request, $id): \Illuminate\Http\JsonResponse
    {
        $artist = Artist::findOrFail($id);
        // validācija
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
        $directory = 'artists/' . $artist->id . '/' . $type;
        $path = $directory . '/' . $filename;

        // pārliecināties, vai direktorija pastāv
        Storage::disk('public')->makeDirectory($directory);
        // saglabāt failu ar fiksētu nosaukumu (pārraksta, ja pastāv)
        Storage::disk('public')->put($path, file_get_contents($file));
        // kešatmiņas tīrīšana
        // Artisan::call('cache:clear'); // Optional
        return response()->json([
            'success' => true,
            'message' => ucfirst($type) . __('messages.artist_image_updated'),
            'image_url' => Storage::url($path) . '?t=' . time(), // pievienot timestamp'u, lai novērstu kešdarbi
        ]);
    }
}
