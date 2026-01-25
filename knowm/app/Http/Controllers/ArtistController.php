<?php

namespace App\Http\Controllers;

use App\Services\ArtistService;
use App\Services\ReleaseService;
use App\Services\TrackService;
use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Carbon\Carbon;
use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use App\Models\Genre;
use App\Models\ArtistComment;

class ArtistController extends Controller
{
    protected ArtistService $artistService;
    protected ReleaseService $releaseService;
    protected TrackService $trackService;

    public function __construct(ArtistService $artistService, ReleaseService $releaseService, TrackService $trackService)
    {
        $this->artistService = $artistService;
        $this->releaseService = $releaseService;
        $this->trackService = $trackService;
    }

    public function index(): \Inertia\Response
    {
        return Inertia::render('Admin/Artists/Index', [
            'artists' => Artist::query()
                ->latest()
                ->paginate(10)
        ]);
    }

    public function uploadBannerImage(Request $request, Artist $artist): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'image' => 'required|image|mimes:webp|max:5120'
        ]);
        $path = $request->file('image')->storeAs(
            "artists/{$artist->id}/banner",
            'banner.webp',
            'public'
        );
        return response()->json([
            'path' => $path,
            'url' => Storage::url($path)
        ]);
    }

    public function uploadProfileImage(Request $request, Artist $artist): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'image' => 'required|image|mimes:webp|max:2048'
        ]);
        $path = $request->file('image')->storeAs(
            "artists/{$artist->id}/profile",
            'profile.webp',
            'public'
        );
        return response()->json([
            'path' => $path,
            'url' => Storage::url($path)
        ]);
    }

    /***
     * Metode priekš ArtistShow.vue lapas.
     * Iegūst datus par izpildītāju no datubāzes un daļu no komentāriem, kā arī
     * autentificēta lietotāja informāciju, un nodod tos lapai.
     *
     * @param Artist $artist
     * @return \Inertia\Response
     */
    public function show(Artist $artist): \Inertia\Response
    {
        // iegūt pašreizējo lapu komentāriem no pieprasījuma, noklusējums ir 1
        $commentsPage = request()->input('comments_page', 1);

        $data = $this->artistService->getArtistWithDetailsAndComments($artist->id, $commentsPage);
        return Inertia::render('Artists/ArtistShow', [
            'artist' => $data
        ]);
    }

    public function showBio($artistSlug): \Inertia\Response
    {
        $artist = Artist::where('slug', $artistSlug)->firstOrFail();
        return Inertia::render('Artists/ArtistBio', [
            'artist' => $artist,
        ]);
    }

    public function showAllReleases($slug): \Inertia\Response
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $releases = $this->releaseService->getPaginatedReleases(
            $slug,
            20,
            request('search')
        );
        return Inertia::render('Artists/ArtistAllReleases', [
            'artist' => $artist,
            ...$this->releaseService->formatForView($releases),
            'filters' => request()->only(['search'])
        ]);
    }

    public function showAllTracks($slug): \Inertia\Response
    {
        $artist = Artist::where('slug', $slug)->firstOrFail();
        $tracks = $this->trackService->getPaginatedTracks(
            $slug,
            40,
            request('search')
        );
        return Inertia::render('Artists/ArtistAllTracks', [
            'artist' => $artist,
            ...$this->trackService->formatForView($tracks),
            'filters' => request()->only(['search'])
        ]);
    }

    public function explore(Request $request): \Inertia\Response
    {
        $searchQuery = $request->input('q', '');
        $perPage = $request->input('perPage', 24);
        $sortOrder = $request->input('sort', 'asc');
        $selectedGenres = $request->input('genres', []);
        if (is_string($selectedGenres)) {
            $selectedGenres = $selectedGenres === '' ? [] : explode(',', $selectedGenres);
        }
        $selectedGenres = is_array($selectedGenres) ? $selectedGenres : [];
        $genreIds = array_filter(array_map('intval', $selectedGenres));
        $artists = Artist::query()
            ->when($searchQuery, function ($query) use ($searchQuery) {
                $query->where('name', 'like', "%{$searchQuery}%");
            })
            ->when(!empty($genreIds), function ($query) use ($genreIds) {
                $query->whereHas('genres', function ($q) use ($genreIds) {
                    $q->whereIn('genres.id', $genreIds);
                });
            })
            ->withCount('tracks')
            ->with('genres')
            ->orderBy('name', $sortOrder)
            ->paginate($perPage)
            ->withQueryString();
        $genres = Genre::orderBy('name')->get();
        return Inertia::render('Artists/ArtistsExplore', [
            'artists' => $artists->items(),
            'searchQuery' => $searchQuery,
            'paginationLinks' => $artists->toArray()['links'],
            'currentPage' => $artists->currentPage(),
            'totalPages' => $artists->lastPage(),
            'perPage' => $perPage,
            'allGenres' => $genres,
            'selectedGenres' => $genreIds,
            'sortOrder' => $sortOrder
        ]);
    }

    /***
     * Atgriež komentārus ar lapdales formātēšanu.
     *
     * @param Artist $artist
     * @return \Illuminate\Http\JsonResponse
     */
    public function getComments(Artist $artist): \Illuminate\Http\JsonResponse
    {
        $page = request()->input('page', 1);
        $comments = ArtistComment::withTrashed()
            ->where('artist_id', $artist->id)
            ->whereNull('parent_id')
            ->with(['user', 'replies'])
            ->orderBy('created_at', 'desc')
            ->paginate(10, ['*'], 'page', $page);

        return response()->json([
            'comments' => $comments->items(),
            'pagination' => [
                'current_page' => $comments->currentPage(),
                'last_page' => $comments->lastPage(),
                'total' => $comments->total(),
            ]
        ]);
    }

    /***
     * Saglabā jaunu komentāru ArtistShow lapā.
     *
     * @param Artist $artist
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function storeComment(Artist $artist, Request $request): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'text' => 'required|string|min:1|max:2000',
            'parent_id' => 'nullable|exists:comments_artists,id'
        ]);
        $comment = ArtistComment::create([
            'user_id' => Auth::id(),
            'artist_id' => $artist->id,
            'text' => $request->input('text'),
            'status' => 'visible',
            'parent_id' => $request->input('parent_id', null)
        ]);
        // ielādēt lietotāja relāciju atbildei
        $comment->load('user');
        // tā kā nav nepieciešams rādīt kādu paziņojumu par veiksmīgu operāciju,
        // vienkārši atgriež to pašu lapu ar kādu default paziņojumu
        return response()->json([
            'success' => true,
            'message' => 'Comment added successfully',
            'comment' => $comment
        ]);
    }

    public function updateComment(Artist $artist, ArtistComment $comment, Request $request)
    {
        if ($comment->artist_id !== $artist->id) {
            abort(403, 'Comment does not belong to this artist.');
        }
        if ($comment->user_id !== Auth::id()) {
            abort(403, 'You are not authorized to edit this comment.');
        }
        // pārbaudīt, vai 15 minūšu laikā pēc izveides
        $createdAt = Carbon::parse($comment->created_at);
        $now = Carbon::now();
        $minutesDiff = $createdAt->diffInMinutes($now, false);
        if ($minutesDiff > 15) {
            abort(403, 'You can only edit comments within 15 minutes of posting.');
        }
        // validācija
        $request->validate([
            'text' => 'required|string|min:1|max:2000',
        ]);
        // atjaunināt komentāru
        $comment->text = $request->input('text');
        $comment->edited_at = now();
        $comment->save();
        // ielādēt lietotāja relāciju atbildei
        $comment->load('user');
        return response()->json([
            'success' => true,
            'message' => 'Comment updated successfully',
            'comment' => $comment
        ]);
    }

    /***
     * Izdzēš komentāru.
     * Ja komentārs ir vecākkomentārs un tam nav atbilžu vēstures - forceDelete.
     * Ja komentāram ir atbilžu vēsture vai tas ir atbilde - softDelete.
     *
     * @param Artist $artist
     * @param ArtistComment $comment
     * @return \Illuminate\Http\JsonResponse
     */
    public function deleteComment(Artist $artist, ArtistComment $comment): \Illuminate\Http\JsonResponse
    {
        if ($comment->artist_id !== $artist->id) {
            abort(403, 'Comment does not belong to this artist.');
        }
        if ($comment->user_id !== Auth::id() && !Auth::user()->hasAnyRole(['comments_moderator', 'super_admin'])) {
            abort(403, 'You are not authorized to delete this comment.');
        }
        $deleteType = '';
        // ja tas ir augstākā līmeņa komentārs bez atbildēm → hard delete
        if ($comment->isParentComment() && !$comment->replies()->exists()) {
            $comment->forceDelete();
            $deleteType = 'hard';
        } else {
            // citādi → soft delete
            $comment->delete();
            $deleteType = 'soft';
        }
        return response()->json([
            'success' => true,
            'delete_type' => $deleteType,
            'message' => 'Comment deleted successfully.'
        ]);
    }

}
