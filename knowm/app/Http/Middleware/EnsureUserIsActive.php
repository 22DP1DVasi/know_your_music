<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class EnsureUserIsActive
{
    public function handle($request, Closure $next)
    {
        if (auth()->check() && auth()->user()->status === 'banned') {

            Auth::logout();

            $request->session()->invalidate();
            $request->session()->regenerateToken();

            if ($request->expectsJson()) {
                return response()->json([
                    'message' => 'Account banned'
                ], 403);
            }

            return redirect()->route('account-banned');
        }
        return $next($request);
    }
}
