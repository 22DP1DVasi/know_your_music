<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;

class SetLocale
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next)
    {
        $locale = session('locale', config('app.locale'));
        // force it to string safely
        if ($locale instanceof \Illuminate\Support\Stringable) {
            $locale = $locale->toString();
        }

        app()->setLocale($locale);

        return $next($request);
    }
}
