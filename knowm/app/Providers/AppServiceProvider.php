<?php

namespace App\Providers;

use App\Services\LastFmService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(LastFmService::class, function () {
            return new LastFmService();
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
//        if (app()->environment('production')) {
//            URL::forceScheme('https');
//        }

        Request::setTrustedProxies(
            ['*'],
            Request::HEADER_X_FORWARDED_FOR |
            Request::HEADER_X_FORWARDED_HOST |
            Request::HEADER_X_FORWARDED_PORT |
            Request::HEADER_X_FORWARDED_PROTO |
            Request::HEADER_X_FORWARDED_AWS_ELB
        );

//        if (env('FORCE_HTTPS', false)) {
//            URL::forceScheme('https');
//        }
        URL::forceScheme('https');
        $this->app['request']->server->set('HTTPS', true);
        URL::forceRootUrl(config('app.url'));

        Vite::prefetch(concurrency: 3);
    }
}
