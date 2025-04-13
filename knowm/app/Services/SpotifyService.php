<?php

namespace App\Services;

use SpotifyWebAPI\Session;
use SpotifyWebAPI\SpotifyWebAPI;
use Illuminate\Support\Facades\Cache;

class SpotifyService
{
    private $session;
    private $api;

    public function __construct()
    {
        $this->session = new Session(
            config('spotify.client_id'),
            config('spotify.client_secret')
        );

        $this->api = new SpotifyWebAPI();
    }

    /**
     * Get an access token using Client Credentials flow
     */
    public function getAccessToken(): string
    {
        if (Cache::has('spotify_access_token')) {
            return Cache::get('spotify_access_token');
        }

        $this->session->requestCredentialsToken();
        $token = $this->session->getAccessToken();

        // Cache for 55 minutes (tokens expire in 1 hour)
        Cache::put('spotify_access_token', $token, now()->addMinutes(55));

        return $token;
    }

    /**
     * Get the API client with access token set
     */
    public function getApi(): SpotifyWebAPI
    {
        $this->api->setAccessToken($this->getAccessToken());
        return $this->api;
    }

    /**
     * Search for artists
     */
    public function searchArtists(string $query, int $limit = 10)
    {
        return $this->getApi()->search($query, 'artist', [
            'limit' => $limit
        ]);
    }

    /**
     * Get artist by ID
     */
    public function getArtist(string $artistId)
    {
        return $this->getApi()->getArtist($artistId);
    }

    /**
     * Get artist's albums
     */
    public function getArtistAlbums(string $artistId, int $limit = 10)
    {
        return $this->getApi()->getArtistAlbums($artistId, [
            'limit' => $limit,
            'album_type' => 'album,single'
        ]);
    }
}
