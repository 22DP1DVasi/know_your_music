<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;

class ProfileController extends Controller
{
    /**
     * Parāda lietotāja profila veidlapu.
     *
     * @param Request $request
     * @return Response
     */
    public function edit(Request $request): Response
    {
        return Inertia::render('Dashboard/Settings', [
            'mustVerifyEmail' => $request->user() instanceof MustVerifyEmail,
            'status' => session('status'),
        ]);
    }

    /**
     * Dzēš lietotāja profila informāciju.
     *
     * @param ProfileUpdateRequest $request
     * @return RedirectResponse
     */
    public function update(ProfileUpdateRequest $request): RedirectResponse
    {
        $request->user()->fill($request->validated());
        if ($request->user()->isDirty('email')) {
            $request->user()->email_verified_at = null;
        }
        $request->user()->save();
        return Redirect::route('profile.edit');
    }

    /**
     * Atjauninā lietotāja iemiesojumu.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateAvatar(Request $request): \Illuminate\Http\JsonResponse
    {
        $request->validate([
            'avatar' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
        ]);

        $user = $request->user();
        // dzēst veco iemiesojumu, ja tāds pastāv
        if ($user->avatar) {
            Storage::disk('public')->delete($user->avatar);
        }
        // saglabāt jaunu iemiesojumu
        $path = $request->file('avatar')->store('avatars', 'public');
        // atjaunināt lietotāju
        $user->avatar = $path;
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Avatar updated successfully.',
            'avatar_url' => Storage::url($path),
            'avatar_path' => $path,
        ]);
    }

    /**
     * Izdzēš lietotāja iemiesojumu.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroyAvatar(Request $request): \Illuminate\Http\JsonResponse
    {
        $user = $request->user();
        if ($user->avatar) {
            Storage::disk('public')->delete($user->avatar);
            $user->avatar = null;
            $user->save();
        }

        return response()->json([
            'success' => true,
            'message' => 'Avatar removed successfully.',
            'avatar_url' => null,
        ]);
    }

    /**
     * Izdzēš lietotāja kontu.
     *
     * @param Request $request
     * @return RedirectResponse
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validate([
            'password' => ['required', 'current_password'],
        ]);
        $user = $request->user();
        Auth::logout();
        $user->delete();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return Redirect::to('/');
    }
}
