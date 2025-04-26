<template>
    <Head title="Know Your Music Search" />
    <Navbar/>
    <main class="flex-1">
        <div class="search-results">
            <h1>Search Results for "{{ searchQuery }}"</h1>

            <!-- artists results -->
            <section v-if="artists.length > 0" class="results-section">
                <div class="section-header">
                    <h2>Artists</h2>
                    <a v-if="hasMoreArtists" :href="`/search/artists?q=${searchQuery}`" class="see-all">
                        See all {{ artistsCount }} artists →
                    </a>
                </div>
                <div class="artist-results">
                    <div v-for="artist in artists" :key="artist.id" class="artist-card">
                        <img :src="getArtistImage(artist)" :alt="artist.name">
                        <div class="artist-info">
                            <h3>{{ artist.name }}</h3>
                            <p>{{ artist.tracks_count }} tracks</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- releases results -->
            <section v-if="releases.length > 0" class="results-section">
                <div class="section-header">
                    <h2>Releases</h2>
                    <a v-if="hasMoreReleases" :href="`/search/releases?q=${searchQuery}`" class="see-all">
                        See all {{ releasesCount }} releases →
                    </a>
                </div>
                <div class="release-results">
                    <div v-for="release in releases" :key="release.id" class="release-card">
                        <img :src="getReleaseImage(release)" :alt="release.title">
                        <div class="release-info">
                            <h3>{{ release.title }}</h3>
                            <p>{{ release.artists[0]?.name }}</p>
                            <p>{{ release.tracks_count }} tracks • {{ release.release_type }}</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- tracks results by title or authors -->
            <section v-if="metadataMatches.length > 0" class="results-section">
                <div class="section-header">
                    <h2>Tracks</h2>
                    <a v-if="metadataMatchesCount > metadataMatches.length"
                       :href="`/search/tracks?q=${searchQuery}`"
                       class="see-all">
                        See all {{ metadataMatchesCount }} tracks →
                    </a>
                </div>
                <div class="track-list metadata-track-list">
                    <div v-for="track in metadataMatches" :key="track.id" class="track-item">
                        <img class="track-image" :src="getTrackImage(track)" :alt="track.title">
                        <div class="track-info">
                            <h3>{{ track.title }}</h3>
                            <p class="artists-names">
                    <span v-for="(artist, index) in track.artists" :key="artist.id">
                        {{ artist.name }}<span v-if="index < track.artists.length - 1">, </span>
                    </span>
                            </p>
                        </div>
                        <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                    </div>
                </div>
            </section>

            <!-- tracks results by lyrics -->
            <section v-if="lyricsMatches.length > 0" class="results-section">
                <div class="section-header">
                    <h2>Lyrics Matches</h2>
                    <a v-if="lyricsMatchesCount > lyricsMatches.length"
                       :href="`/search/tracks?q=${searchQuery}&type=lyrics`"
                       class="see-all">
                        See all {{ lyricsMatchesCount }} lyrics matches →
                    </a>
                </div>
                <div class="track-list lyric-matches">
                    <div v-for="track in lyricsMatches" :key="track.id" class="track-item">
                        <img class="track-image" :src="getTrackImage(track)" :alt="track.title">
                        <div class="track-info">
                            <h3>{{ track.title }}</h3>
                            <p class="artists-names">
                    <span v-for="(artist, index) in track.artists" :key="artist.id">
                        {{ artist.name }}<span v-if="index < track.artists.length - 1">, </span>
                    </span>
                            </p>
                            <p class="lyric-snippet" v-html="cleanSnippet(track.lyric_snippet)"></p>
                        </div>
                        <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                    </div>
                </div>
            </section>

            <!-- no results -->
            <div v-if="artists.length === 0 && releases.length === 0 && metadataMatches.length === 0
            && lyricsMatches.length === 0" class="no-results">
                No results found for "{{ searchQuery }}"
            </div>
        </div>
    </main>
    <Footer/>
</template>

<script setup>
import { Head } from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";

const props = defineProps({
    artists: Array,
    releases: Array,
    metadataMatches: Array,
    lyricsMatches: Array,
    searchQuery: String,
    hasMoreArtists: Boolean,
    hasMoreReleases: Boolean,
    hasMoreTracks: Boolean,
    artistsCount: Number,
    releasesCount: Number,
    tracksCount: Number,
    metadataMatchesCount: Number,
    lyricsMatchesCount: Number
});

// image handling
const getArtistImage = (artist, type = 'banner') => {
    if (artist.banner_url) return artist.banner_url;
    return `/storage/artists/${artist.id}/${type}/${type}.webp`;
};

const getReleaseImage = (release) => {
    return release.cover_url;
};

const getTrackImage = (track) => {
    return track.cover_url;
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

const cleanSnippet = (snippet) => {
    if (!snippet) return '';
    return snippet
        .replace(/\\/g, '')
        .replace(/[\x00-\x1F\x7F]/g, ' ')  // Remove control chars
        .replace(/\s+/g, ' ')              // Collapse spaces
        .trim();
};

</script>

<style scoped>
.search-results {
    padding: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.results-section {
    margin-bottom: 2.5rem;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.section-header h2 {
    font-size: 1.4rem;
    margin-bottom: 0.5rem;
}

.see-all {
    color: #4a90e2;
    text-decoration: none;
    font-weight: 500;
}

.see-all:hover {
    text-decoration: underline;
}

.artist-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.artist-card {
    flex: 0 0 calc(25% - 1.5rem);  /* 4 cards per row*/
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s;
    min-width: 0;
    min-height: 280px;
}

.artist-card:hover {
    transform: translateY(-5px);
}

.artist-card img {
    width: 100%;
    height: 180px;
    object-fit: cover;
}

.artist-info {
    padding: 1rem;
    min-width: 0;
}

/* max two rows for name/title, if overflows - ellipsis */
.artist-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal;
    word-break: break-word;
    line-height: 1.2;
    max-height: 2.4em;
}


.artist-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.5rem);  /* 4 cards per row*/
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    min-width: 0;
    min-height: 300px;
}

.release-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
    min-width: 0;
}

/* max two rows for name/title, if overflows - ellipsis */
.release-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal;
    word-break: break-word;
    line-height: 1.2;
    max-height: 2.4em;
}

.release-info p {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.release-info .artists-names {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
}

.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.track-item {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
    gap: 1rem;
}

.metadata-track-list {
    max-width: 800px;
    margin: 0 auto;
}

.track-image {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    object-fit: cover;
    flex-shrink: 0;
}

.track-info {
    flex: 1;
    min-width: 0;
    padding: 0 1rem;
    overflow: hidden;
}

/* max two rows for name/title, if overflows - ellipsis */
.track-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 0.95rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100%;
    display: block;
}

.track-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-info .artists-names {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 0;
    color: #666;
    font-size: 0.9rem;
    width: 100%;
}

.track-duration {
    text-align: right;
    color: #666;
    flex: 0 0 80px;
}

.lyric-matches{
    max-width: 900px;
    margin: 0 auto;
}

.lyric-matches .track-item {
    background: white;
    padding-left: 0.5rem;
}

.lyric-snippet {
    margin: 0.5rem 0 0 0;
    color: #555;
    font-size: 0.85rem;
    line-height: 1.4;
    font-style: italic;
}

.lyric-snippet mark {
    background-color: rgba(255, 235, 59, 0.4);
    color: inherit;
    padding: 0 2px;
    border-radius: 3px;
}

.no-results {
    padding: 2rem;
    text-align: center;
    font-size: 1.2rem;
    color: #666;
}

@media (max-width: 768px) {
    .artist-card,
    .release-card {
        flex: 0 0 calc(50% - 1rem);  /* 2 cards per row */
        min-height: 360px;
        height: 360px ;
        aspect-ratio: 3/4;
    }

    .artist-card img,
    .release-card img {
        height: 240px;
    }

    .artist-info,
    .release-info {
        padding: 1.25rem;
    }

    .artist-info h3,
    .release-info h3 {
        font-size: 1.05rem;
    }

    .artist-info p,
    .release-info p {
        font-size: 0.95rem;
    }

    .track-info h3 {
        font-size: 0.9rem;
        max-width: 180px;
    }

    .lyric-matches .track-info h3 {
        max-width: 150px;
    }
}

@media (max-width: 480px) {
    .artist-card,
    .release-card {
        flex: 0 0 calc(50% - 0.75rem);  /* 2 cards per row*/
        min-height: 300px;
        height: 300px;
    }

    .artist-card img,
    .release-card img {
        height: 180px;
    }
}
</style>
