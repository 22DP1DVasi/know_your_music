<?php

namespace App\Http\Middleware;

use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        $user = $request->user();
        $userAvatar = $user
            ? $this->generateAvatarGradient($user->name)
            : null;
        return array_merge(parent::share($request), [
            'auth' => [
                'user' => $user
                    ? [
                        'id' => $user->id,
                        'name' => $user->name,
                        'slug' => $user->slug,
                        'email' => $user->email,
                        'avatar_url' => $user->avatar_url,
                        'initial' => $userAvatar['initial'],
                        'avatar_color_1' => $userAvatar['avatar_color_1'],
                        'avatar_color_2' => $userAvatar['avatar_color_2'],
                        'roles' => $user->roles->pluck('name'),
                    ]
                    : null,
            ],
            'flash' => [
                'success' => fn () => $request->session()->get('success'),
                'error' => fn () => $request->session()->get('error'),
            ],
            'locale' => app()->getLocale()
        ]);
    }

    /**
     * Ģenerē sākumburtu un profila avatāra krāsas atkarībā no lietotāja lietotājvārda.
     *
     * @param string $name
     * @return array
     */
    private function generateAvatarGradient(string $name): array
    {
        // heksadecimāla jaucējkoda izveide
        $hash = md5($name);
        // izmantot pirmos baitus tonim (0-360)
        $hue = hexdec(substr($hash, 0, 4)) % 360;

        // saglabāt piesātinājumu un gaišumu jaukos UI drošos diapazonos
        $saturation = 65;
        $lightness = 55;

        // nedaudz nobīdīt tonu un palielināt gaišumu otrajai krāsai
        $hue2 = ($hue + 20) % 360;
        $lightness2 = 65;
        return [
            'initial' => strtoupper(substr($name, 0, 1)),
            'avatar_color_1' => "hsl($hue, {$saturation}%, {$lightness}%)",
            'avatar_color_2' => "hsl($hue2, {$saturation}%, {$lightness2}%)",
        ];
    }
}
