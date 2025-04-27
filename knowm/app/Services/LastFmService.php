<?php

namespace App\Services;

use GuzzleHttp\Client;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;

class LastFmService
{
    protected $client;
    protected $apiKey;
    protected $baseUrl = 'http://ws.audioscrobbler.com/2.0/';

    public function __construct()
    {
        $this->client = new Client();
        $this->apiKey = config('services.last_fm.api_key');

        if (empty($this->apiKey)) {
            throw new \RuntimeException('Last.fm API key not configured');
        }
    }

    public function getArtistInfo(string $artistName)
    {
        try {
            $response = $this->client->get($this->baseUrl, [
                'query' => [
                    'method' => 'artist.getinfo',
                    'artist' => urlencode($artistName), // Encode special characters
                    'api_key' => $this->apiKey,
                    'format' => 'json',
                    'autocorrect' => 1
                ],
                'headers' => [
                    'User-Agent' => 'YourMusicApp/1.0' // Some APIs require user agent
                ]
            ]);

            $data = json_decode($response->getBody()->getContents(), true);

            // Check if artist was autocorrected
            if (isset($data['artist']['name']) && strtolower($data['artist']['name']) !== strtolower(urldecode($artistName))) {
                $this->info("Artist name autocorrected from {$artistName} to {$data['artist']['name']}");
            }

            return $data;
        } catch (\Exception $e) {
            Log::error("Last.fm artist info error for {$artistName}: " . $e->getMessage());
            return ['error' => $e->getMessage()];
        }
    }

    public function getArtistTopAlbums(string $artistName, int $limit = 10)
    {
        try {
            $response = $this->client->get($this->baseUrl, [
                'query' => [
                    'method' => 'artist.gettopalbums',
                    'artist' => urlencode($artistName),
                    'api_key' => $this->apiKey,
                    'format' => 'json',
                    'autocorrect' => 1,
                    'limit' => $limit
                ]
            ]);

            return json_decode($response->getBody()->getContents(), true);
        } catch (\Exception $e) {
            Log::error("Last.fm top albums error for {$artistName}: " . $e->getMessage());
            return ['error' => $e->getMessage()];
        }
    }

    public function getAlbumInfo(string $artistName, string $albumName)
    {
        try {
            $response = $this->client->get($this->baseUrl, [
                'query' => [
                    'method' => 'album.getinfo',
                    'artist' => $artistName,
                    'album' => $albumName,
                    'api_key' => $this->apiKey,
                    'format' => 'json',
                    'autocorrect' => 1
                ]
            ]);

            return json_decode($response->getBody()->getContents(), true);
        } catch (\Exception $e) {
            Log::error("Last.fm album info error: " . $e->getMessage());
            return null;
        }
    }

    public function getArtistTags(string $artistName): ?array
    {
        $response = Http::get('http://ws.audioscrobbler.com/2.0/', [
            'method' => 'artist.getTags',
            'artist' => $artistName,
            'api_key' => $this->apiKey,
            'format' => 'json',
            'autocorrect' => 1,
        ]);

        if ($response->failed() || isset($response->json()['error'])) {
            Log::warning("Failed to fetch artist tags for {$artistName}");
            return null;
        }

        return $response->json()['tags']['tag'] ?? null;
    }

    public function getTrackInfo(string $artistName, string $trackName)
    {
        try {
            $response = $this->client->get($this->baseUrl, [
                'query' => [
                    'method' => 'track.getinfo',
                    'artist' => $artistName,
                    'track' => $trackName,
                    'api_key' => $this->apiKey,
                    'format' => 'json',
                    'autocorrect' => 1
                ]
            ]);

            return json_decode($response->getBody()->getContents(), true);
        } catch (\Exception $e) {
            Log::error("Last.fm track info error: " . $e->getMessage());
            return null;
        }
    }

    public function getTagInfo(string $tagName)
    {
        try {
            $response = $this->client->get($this->baseUrl, [
                'query' => [
                    'method' => 'tag.getinfo',
                    'tag' => $tagName,
                    'api_key' => $this->apiKey,
                    'format' => 'json',
                ]
            ]);

            return json_decode($response->getBody()->getContents(), true);
        } catch (\Exception $e) {
            Log::error("Last.fm tag info error: " . $e->getMessage());
            return null;
        }
    }
}
