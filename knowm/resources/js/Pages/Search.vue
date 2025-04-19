<template>
    <Head title="Know Your Music Search" />
    <Navbar/>
    <div class="search-results">
        <h1>Search Results for "{{ searchQuery }}"</h1>

        <!-- Artists Results -->
        <section v-if="artists.length > 0" class="results-section">
            <div class="section-header">
                <h2>Artists</h2>
                <a v-if="hasMoreArtists" :href="`/search/artists?q=${searchQuery}`" class="see-all">
                    See all {{ artistsCount }} artists →
                </a>
            </div>
            <div class="artist-grid">
                <div v-for="artist in artists" :key="artist.id" class="artist-card">
                    <img :src="artist.image_url || '/images/default-artist.jpg'" :alt="artist.name">
                    <div class="artist-info">
                        <h3>{{ artist.name }}</h3>
                        <p>{{ artist.tracks_count }} tracks</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Releases Results -->
        <section v-if="releases.length > 0" class="results-section">
            <div class="section-header">
                <h2>Releases</h2>
                <a v-if="hasMoreReleases" :href="`/search/releases?q=${searchQuery}`" class="see-all">
                    See all {{ releasesCount }} releases →
                </a>
            </div>
            <div class="release-grid">
                <div v-for="release in releases" :key="release.id" class="release-card">
                    <img :src="release.cover_url || '/images/default-release.jpg'" :alt="release.title">
                    <div class="release-info">
                        <h3>{{ release.title }}</h3>
                        <p>{{ release.artists[0]?.name }}</p>
                        <p>{{ release.tracks_count }} tracks • {{ release.release_type }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Tracks Results -->
        <section v-if="tracks.length > 0" class="results-section">
            <div class="section-header">
                <h2>Tracks</h2>
                <a v-if="hasMoreTracks" :href="`/search/tracks?q=${searchQuery}`" class="see-all">
                    See all {{ tracksCount }} tracks →
                </a>
            </div>
            <div class="track-list">
                <div v-for="track in tracks" :key="track.id" class="track-item">
                    <div class="track-number">{{ track.pivot?.track_position || '' }}</div>
                    <div class="track-info">
                        <h3>{{ track.title }}</h3>
                        <p>{{ track.artists[0]?.name }}</p>
                    </div>
                    <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                </div>
            </div>
        </section>

        <!-- No Results -->
        <div v-if="artists.length === 0 && releases.length === 0 && tracks.length === 0" class="no-results">
            No results found for "{{ searchQuery }}"
        </div>
    </div>
</template>

<script setup>
import { computed } from 'vue';
import {Head} from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";

const props = defineProps({
    artists: Array,
    releases: Array,
    tracks: Array,
    searchQuery: String,
    hasMoreArtists: Boolean,
    hasMoreReleases: Boolean,
    hasMoreTracks: Boolean
});

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};
</script>

<style scoped>
.search-results {
    padding: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.results-section {
    margin-bottom: 3rem;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.see-all {
    color: #4a90e2;
    text-decoration: none;
    font-weight: 500;
}

.see-all:hover {
    text-decoration: underline;
}

/* Artists Grid */
.artist-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 1.5rem;
}

.artist-card {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s;
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
}

.artist-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1.1rem;
}

.artist-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
}

/* Releases Grid */
.release-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 1.5rem;
}

.release-card {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.release-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
}

.release-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1.1rem;
}

.release-info p {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
}

/* Tracks List */
.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.track-item {
    display: grid;
    grid-template-columns: 50px 1fr 80px;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
}

.track-item:hover {
    background: #f9f9f9;
}

.track-number {
    color: #666;
    text-align: center;
}

.track-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1rem;
}

.track-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
}

.track-duration {
    text-align: right;
    color: #666;
}

.no-results {
    padding: 2rem;
    text-align: center;
    font-size: 1.2rem;
    color: #666;
}
</style>
