<?php

// @formatter:off
// phpcs:ignoreFile
/**
 * A helper file for your Eloquent Models
 * Copy the phpDocs from this file to the correct Model,
 * And remove them from this file, to prevent double declarations.
 *
 * @author Barry vd. Heuvel <barryvdh@gmail.com>
 */


namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string $name
 * @property string $email
 * @property \Illuminate\Support\Carbon|null $email_verified_at
 * @property string $password
 * @property string $status
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ArtistComment> $artistComments
 * @property-read int|null $artist_comments_count
 * @property-read \Illuminate\Notifications\DatabaseNotificationCollection<int, \Illuminate\Notifications\DatabaseNotification> $notifications
 * @property-read int|null $notifications_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ReleaseComment> $releaseComments
 * @property-read int|null $release_comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\TrackComment> $trackComments
 * @property-read int|null $track_comments_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin active()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin banned()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereEmail($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereEmailVerifiedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin wherePassword($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereRememberToken($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Admin whereUpdatedAt($value)
 */
	class Admin extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string $name
 * @property string|null $biography
 * @property int|null $formed_year
 * @property int|null $disbanded_year
 * @property string|null $image
 * @property string|null $solo_or_band
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ArtistComment> $allComments
 * @property-read int|null $all_comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ArtistComment> $comments
 * @property-read int|null $comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Genre> $genres
 * @property-read int|null $genres_count
 * @property-read string|null $active_years
 * @property-read string|null $image_url
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\RecommendationArtist> $recommendedIn
 * @property-read int|null $recommended_in_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Release> $releases
 * @property-read int|null $releases_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Track> $tracks
 * @property-read int|null $tracks_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist active()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist bands()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereBiography($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereDisbandedYear($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereFormedYear($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereImage($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereSoloOrBand($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Artist whereUpdatedAt($value)
 */
	class Artist extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property int|null $commenter_id
 * @property string|null $commenter_type
 * @property int $artist_id
 * @property string $text
 * @property string $status
 * @property string|null $deleted_username
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Artist $artist
 * @property-read \Illuminate\Database\Eloquent\Model|\Eloquent|null $commenter
 * @property-read string $author_name
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment visible()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereArtistId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereCommenterId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereCommenterType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereDeletedUsername($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereText($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ArtistComment whereUpdatedAt($value)
 */
	class ArtistComment extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string $name
 * @property string|null $description
 * @property int|null $origin_year
 * @property string|null $origin_country
 * @property string|null $image
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Artist> $artists
 * @property-read int|null $artists_count
 * @property-read string|null $image_url
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\RecommendationGenre> $recommendedIn
 * @property-read int|null $recommended_in_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Release> $releases
 * @property-read int|null $releases_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Track> $tracks
 * @property-read int|null $tracks_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre search(string $term)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereImage($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereOriginCountry($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereOriginYear($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Genre whereUpdatedAt($value)
 */
	class Genre extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string|null $lyrics
 * @property string $status
 * @property int $track_id
 * @property int|null $last_updated_by_user
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Admin|null $lastUpdatedBy
 * @property-read \App\Models\Track $track
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric needsVerification()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric verified()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereLastUpdatedByUser($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereLyrics($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereTrackId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Lyric whereUpdatedAt($value)
 */
	class Lyric extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property int $user_id
 * @property bool $is_checked_by_user
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\RecommendationGenre> $genres
 * @property-read int|null $genres_count
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation whereIsCheckedByUser($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Recommendation whereUserId($value)
 */
	class Recommendation extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property int $recommendation_genre_id
 * @property int $artist_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Artist $artist
 * @property-read \App\Models\RecommendationGenre $recommendationGenre
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist whereArtistId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist whereRecommendationGenreId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationArtist whereUpdatedAt($value)
 */
	class RecommendationArtist extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property int $recommendation_id
 * @property int $genre_id
 * @property string $user_rating
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\RecommendationArtist> $artists
 * @property-read int|null $artists_count
 * @property-read \App\Models\Genre $genre
 * @property-read \App\Models\Recommendation $recommendation
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre whereGenreId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre whereRecommendationId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|RecommendationGenre whereUserRating($value)
 */
	class RecommendationGenre extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string $title
 * @property \Illuminate\Support\Carbon $release_date
 * @property string|null $cover_image
 * @property string|null $description
 * @property string $release_type
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ReleaseComment> $allComments
 * @property-read int|null $all_comments_count
 * @property-read \App\Models\Artist|null $artist
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ReleaseComment> $comments
 * @property-read int|null $comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Genre> $genres
 * @property-read int|null $genres_count
 * @property-read string|null $cover_url
 * @property-read int $duration
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Track> $tracks
 * @property-read int|null $tracks_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release albums()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereCoverImage($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereReleaseDate($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereReleaseType($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereTitle($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Release year(int $year)
 */
	class Release extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property-read \Illuminate\Database\Eloquent\Model|\Eloquent $commenter
 * @property-read string $author_name
 * @property-read \App\Models\Release|null $release
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ReleaseComment newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ReleaseComment newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ReleaseComment query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|ReleaseComment visible()
 */
	class ReleaseComment extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string $title
 * @property \Illuminate\Support\Carbon $duration
 * @property string|null $audio_source
 * @property \Illuminate\Support\Carbon $release_date
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\TrackComment> $comments
 * @property-read int|null $comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Genre> $genres
 * @property-read int|null $genres_count
 * @property-read string|null $audio_url
 * @property-read string $formatted_duration
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\UserCollection> $userCollections
 * @property-read int|null $user_collections_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track recent(int $days = 30)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track search(string $term)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereAudioSource($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereDuration($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereReleaseDate($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereTitle($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|Track whereUpdatedAt($value)
 */
	class Track extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property-read \Illuminate\Database\Eloquent\Model|\Eloquent $commenter
 * @property-read string $author_name
 * @property-read \App\Models\Track|null $track
 * @method static \Illuminate\Database\Eloquent\Builder<static>|TrackComment newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|TrackComment newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|TrackComment query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|TrackComment visible()
 */
	class TrackComment extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property string $name
 * @property string $email
 * @property \Illuminate\Support\Carbon|null $email_verified_at
 * @property string $password
 * @property string $status
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ArtistComment> $artistComments
 * @property-read int|null $artist_comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\UserCollection> $collections
 * @property-read int|null $collections_count
 * @property-read \App\Models\UserFavoriteArtist|null $pivot
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Artist> $favoriteArtists
 * @property-read int|null $favorite_artists_count
 * @property-read \App\Models\Recommendation|null $latestRecommendations
 * @property-read \Illuminate\Notifications\DatabaseNotificationCollection<int, \Illuminate\Notifications\DatabaseNotification> $notifications
 * @property-read int|null $notifications_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Recommendation> $recommendations
 * @property-read int|null $recommendations_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\ReleaseComment> $releaseComments
 * @property-read int|null $release_comments_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \Laravel\Sanctum\PersonalAccessToken> $tokens
 * @property-read int|null $tokens_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\TrackComment> $trackComments
 * @property-read int|null $track_comments_count
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User active()
 * @method static \Database\Factories\UserFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereEmail($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereEmailVerifiedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User wherePassword($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereRememberToken($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|User whereUpdatedAt($value)
 */
	class User extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property int $user_id
 * @property string $name
 * @property string|null $description
 * @property bool $is_private
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Track> $tracks
 * @property-read int|null $tracks_count
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereIsPrivate($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserCollection whereUserId($value)
 */
	class UserCollection extends \Eloquent {}
}

namespace App\Models{
/**
 * 
 *
 * @property int $id
 * @property int $user_id
 * @property int $artist_id
 * @property int $sort_order
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Artist $artist
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist forUser($userId)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist whereArtistId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist whereSortOrder($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserFavoriteArtist whereUserId($value)
 */
	class UserFavoriteArtist extends \Eloquent {}
}

