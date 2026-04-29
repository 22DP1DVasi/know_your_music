<script setup>
import { Head, usePage, router } from "@inertiajs/vue3";
import { ref } from "vue";
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import ArtistCardMain from '@/Components/Artists/ArtistCardMain.vue';
import ReleaseCard from '@/Components/Releases/ReleaseCard.vue';
import TrackCard from '@/Components/Tracks/TrackCard.vue';
import AddToPlaylistModal from "@/Components/Playlists/AddToPlaylistModal.vue";
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

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
            <h1 class="results-title">{{ t('search_pages.main_results.search_results', {query: searchQuery}) }}</h1>

            <!-- Izpildītāji -->
            <section v-if="artists.length > 0" class="results-section artist-section">
                <div class="section-header">
                    <h2>{{ t('search_pages.main_results.artists') }}</h2>
                    <a v-if="hasMoreArtists" :href="`/search/artists?q=${searchQuery}`" class="see-all">
                        <!--See all {{ artistsCount }} artists →-->
                        {{ t('search_pages.main_results.see_all_artists', {count: artistsCount}) }}
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

            <!-- Albumi -->
            <section v-if="releases.length > 0" class="results-section release-section">
                <div class="section-header">
                    <h2>{{ t('search_pages.main_results.releases') }}</h2>
                    <a v-if="hasMoreReleases" :href="`/search/releases?q=${searchQuery}`" class="see-all">
                        {{ t('search_pages.main_results.see_all_releases', {count: releasesCount}) }}
                    </a>
                </div>
                <div class="release-results">
                    <ReleaseCard
                        v-for="release in releases"
                        :key="release.id"
                        :release="release"
                        :max-artists="3"
                        @release-click="(release) => redirectToRelease(release.slug)"
                    />
                </div>
            </section>

            <!-- Dziesmas pēc nosaukuma vai autora -->
            <section v-if="metadataMatches.length > 0" class="results-section track-section">
                <div class="section-header">
                    <h2>{{ t('search_pages.main_results.tracks') }}</h2>
                    <a v-if="metadataMatchesCount > metadataMatches.length"
                       :href="`/search/tracks?q=${searchQuery}`"
                       class="see-all">
                        {{ t('search_pages.main_results.see_all_tracks', {count: metadataMatchesCount}) }}
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

            <!-- Dziesmas pēc teksta -->
            <section v-if="lyricsMatches.length > 0" class="results-section track-section">
                <div class="section-header">
                    <h2>{{ t('search_pages.main_results.lyrics_matches') }}</h2>
                    <a v-if="lyricsMatchesCount > lyricsMatches.length"
                       :href="`/search/tracks?q=${searchQuery}&type=lyrics`"
                       class="see-all">
                        {{ t('search_pages.main_results.see_all_lyrics', {count: lyricsMatchesCount}) }}
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

            <!-- Tukšs stāvoklis -->
            <div v-if="artists.length === 0 && releases.length === 0 && metadataMatches.length === 0
            && lyricsMatches.length === 0" class="no-results">
                {{ t('search_pages.main_results.no_results') }}
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
}

</style>
