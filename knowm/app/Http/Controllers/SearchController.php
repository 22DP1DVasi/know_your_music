<?php

namespace App\Http\Controllers;

use App\Models\Artist;
use App\Models\Release;
use App\Models\Track;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Services\SearchService;

class SearchController extends Controller
{
    public function index(Request $request, SearchService $searchService)
    {
        $results = $searchService->searchAll($request->input('q', ''));

        return Inertia::render('Search', array_merge($results, [
            'searchQuery' => $request->input('q', '')
        ]));
    }
}
