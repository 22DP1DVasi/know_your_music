<script setup>
import { Head, usePage, router } from "@inertiajs/vue3";
import { ref } from "vue";
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import ArtistCardMain from '@/Components/Artists/ArtistCardMain.vue';
import TrackCard from '@/Components/Tracks/TrackCard.vue';
import AddToPlaylistModal from "@/Components/Playlists/AddToPlaylistModal.vue";
import { route } from 'ziggy-js';

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

// piekļuve koplietojamiem datiem no servera puses
const page = usePage();
const user = page.props.auth?.user;

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

// const cleanSnippet = (snippet) => {
//     if (!snippet) return '';
//     return snippet
//         .replace(/\\/g, '')
//         .replace(/[\x00-\x1F\x7F]/g, ' ')
//         .replace(/\s+/g, ' ')
//         .trim();
// };

const formatArtists = (artists) => {
    if (!artists || artists.length === 0) return '';
    const names = artists.map(artist => artist.name);
    return names.join(', ');
};

const redirectToArtist = (slug) => {
    router.get(`/artists/${slug}`);
};

const redirectToRelease = (slug) => {
    router.get(`/releases/${slug}`);
};

const redirectToTrack = (slug) => {
    router.get(`/tracks/${slug}`);
};

// izvēlnes stāvoklis dziesmu kartēm
const openMenuId = ref(null);

// refs priekš modālajam logam priekš dziesmas pievienošanas kolekcijām
const showPlaylistModal = ref(false);
const selectedTrack = ref(null);

const toggleTrackMenu = (trackId) => {
    openMenuId.value = openMenuId.value === trackId ? null : trackId;
};

const handleTrackClick = (track) => {
    router.get(`/tracks/${track.slug}`);
};

const openAddToPlaylistModal = (track) => {
    if (!user) {
        router.get(route('login'));
        return;
    }
    selectedTrack.value = track;
    showPlaylistModal.value = true;
};

const closeModal = () => {
    showPlaylistModal.value = false
    selectedTrack.value = null
};

</script>

<template>
    <Head title="Know Your Music Search" />
    <Navbar/>
    <main class="flex-1">
        <div class="search-results">
            <h1 class="results-title">Search Results for "{{ searchQuery }}"</h1>

            <!-- artists results -->
            <section v-if="artists.length > 0" class="results-section artist-section">
                <div class="section-header">
                    <h2>Artists</h2>
                    <a v-if="hasMoreArtists" :href="`/search/artists?q=${searchQuery}`" class="see-all">
                        See all {{ artistsCount }} artists →
                    </a>
                </div>
                <div class="artist-results">
                    <ArtistCardMain
                        v-for="artist in artists"
                        :key="artist.id"
                        :artist="artist"
                        :redirect-to="redirectToArtist"
                        :show-track-count="false"
                        :track-count-text="(count) => `${count} ${count === 1 ? 'track' : 'tracks'}`"
                    />
                </div>
            </section>

            <!-- releases results -->
            <section v-if="releases.length > 0" class="results-section release-section">
                <div class="section-header">
                    <h2>Releases</h2>
                    <a v-if="hasMoreReleases" :href="`/search/releases?q=${searchQuery}`" class="see-all">
                        See all {{ releasesCount }} releases →
                    </a>
                </div>
                <div class="release-results">
                    <div
                        v-for="release in releases"
                        :key="release.id"
                        class="release-card"
                        @click="redirectToRelease(release.slug)"
                    >
                        <div class="image-wrapper">
                            <img :src="release.cover_url" :alt="release.title" />
                        </div>
                        <div class="release-info">
                            <h3>{{ release.title }}</h3>
                            <div v-if="release.artists.length > 1" class="artists-names-container">
                                <span class="artists-names">
                                    {{ formatArtists(release.artists) }}
                                </span>
                            </div>
                            <div v-else-if="release.artists.length === 1" class="single-artist">
                                {{ release.artists[0].name }}
                            </div>
                            <p class="release-meta">
                                {{ release.tracks_count }} {{ release.tracks_count === 1 ? 'track' : 'tracks' }} • {{ release.release_type }}
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- tracks results by title or authors -->
            <section v-if="metadataMatches.length > 0" class="results-section track-section">
                <div class="section-header">
                    <h2>Tracks</h2>
                    <a v-if="metadataMatchesCount > metadataMatches.length"
                       :href="`/search/tracks?q=${searchQuery}`"
                       class="see-all">
                        See all {{ metadataMatchesCount }} tracks →
                    </a>
                </div>
                <div class="track-list metadata-track-list">
                    <TrackCard
                        v-for="track in metadataMatches"
                        :key="track.id"
                        :track="track"
                        :show-number="false"
                        :show-artists="true"
                        :menu-open="openMenuId === track.id"
                        duration-format="HH:mm:ss"
                        :can-add="true"
                        :can-remove="false"
                        @track-click="handleTrackClick"
                        @add-to-playlist="openAddToPlaylistModal"
                        @toggle-menu="toggleTrackMenu"
                    />
                </div>
            </section>

            <!-- tracks results by lyrics -->
            <!-- tracks results by lyrics -->
            <section v-if="lyricsMatches.length > 0" class="results-section track-section">
                <div class="section-header">
                    <h2>Lyrics Matches</h2>
                    <a v-if="lyricsMatchesCount > lyricsMatches.length"
                       :href="`/search/tracks?q=${searchQuery}&type=lyrics`"
                       class="see-all">
                        See all {{ lyricsMatchesCount }} lyrics matches →
                    </a>
                </div>
                <div class="track-list lyric-matches">
                    <TrackCard
                        v-for="track in lyricsMatches"
                        :key="track.id"
                        :track="track"
                        :show-number="false"
                        :show-artists="true"
                        :menu-open="openMenuId === track.id"
                        duration-format="HH:mm:ss"
                        :can-add="true"
                        :can-remove="false"
                        @track-click="handleTrackClick"
                        @add-to-playlist="openAddToPlaylistModal"
                        @toggle-menu="toggleTrackMenu"
                    >
                        <template #extra-info>
                            <p class="lyric-snippet" v-html="track.lyric_snippet"></p>
                        </template>
                    </TrackCard>
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

    <AddToPlaylistModal
        :show="showPlaylistModal"
        :track="selectedTrack"
        @close="closeModal"
    />
</template>

<style scoped>
.results-title {
    max-width: 800px;
    text-align: center;
    font-size: 2.2rem;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 2rem;
    color: #0c4baa;
    font-weight: 600;
    padding: 1rem 2rem;
}

.search-results {
    padding: 1rem 0 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.results-section {
    margin: 0 auto;
    padding: 0 2rem;
    margin-bottom: 2.5rem;
}

.artist-section {
    max-width: 1000px;
    margin: 0 auto;
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
    margin: 1.5rem 0;
}

.release-section {
    max-width: 1000px;
    margin: 0 auto;
    margin-bottom: 2.5rem;
}

.release-results {
    gap: 1.2rem;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.125rem); /* 4 cards per row */
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
}

.release-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.release-card .image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.release-card .image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
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
}

.release-info p {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.artists-names-container {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    line-height: 1.3;
    height: 2.6em;
    overflow: hidden;
}

.release-info .artists-names {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    word-break: break-word;
}

.single-artist {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.release-meta {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-section {
    max-width: 1000px;
    margin: 0 auto 2.5rem;
}

.track-list {
    background: white;
    border-radius: 16px;
    overflow: visible;
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.08);
    border: 1px solid rgba(12, 75, 170, 0.08);
}

.metadata-track-list {
    max-width: 800px;
    margin: 0 auto;
}

.lyric-matches {
    max-width: 900px;
    margin: 0 auto;
}

.lyric-snippet {
    margin: 0.5rem 0 0 0;
    color: #555;
    font-size: 0.85rem;
    line-height: 1.4;
    font-style: italic;
}

@media (max-width: 645px) {
    .lyric-snippet {
        display: none;
    }
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
    .results-title {
        font-size: 1.8rem;
        padding-top: 0.5rem;
    }

    .release-card {
        flex: 0 0 calc(50% - 0.75rem);
    }

    .release-info {
        padding: 1.25rem;
    }

    .release-info h3 {
        font-size: 1.05rem;
    }

    .release-info p {
        font-size: 0.95rem;
    }
}

@media (max-width: 480px) {
    .results-title {
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .artist-results {
        justify-content: center;
    }

    .release-results {
        justify-content: center;
    }

    .release-card {
        flex: 0 0 80%;
    }
}
</style>
