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
                        <img :src="getReleaseImage(release.id)" :alt="release.title">
                        <div class="release-info">
                            <h3>{{ release.title }}</h3>
                            <p>{{ release.artists[0]?.name }}</p>
                            <p>{{ release.tracks_count }} tracks • {{ release.release_type }}</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- tracks results -->
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

            <!-- no results -->
            <div v-if="artists.length === 0 && releases.length === 0 && tracks.length === 0" class="no-results">
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
    tracks: Array,
    searchQuery: String,
    hasMoreArtists: Boolean,
    hasMoreReleases: Boolean,
    hasMoreTracks: Boolean,
    artistsCount: Number,
    releasesCount: Number,
    tracksCount: Number
});

// image handling
const getArtistImage = (artist, type = 'banner') => {
    if (artist.banner_url) return artist.banner_url;
    const imagePath = `/storage/artists/${artist.id}/${type}/${type}.webp`;
    return imagePath;
};

const getReleaseImage = (releaseId) => {
    return `/storage/releases/${releaseId}/cover.webp`;
};

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

.artist-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.artist-card {
    flex: 0 0 calc(20% - 1.5rem);
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
    flex: 0 0 calc(20% - 1.5rem);
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
}

.track-number {
    color: #666;
    text-align: center;
    flex: 0 0 50px;
}

.track-info {
    flex: 1;
    min-width: 0;
    padding: 0 1rem;
}

/* max two rows for name/title, if overflows - ellipsis */
.track-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 0.95rem;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: normal;
    word-break: break-word;
}

.track-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-duration {
    text-align: right;
    color: #666;
    flex: 0 0 80px;
}

.no-results {
    padding: 2rem;
    text-align: center;
    font-size: 1.2rem;
    color: #666;
}



@media (max-width: 1200px) {
    .artist-card,
    .release-card {
        flex: 0 0 calc(25% - 1.5rem);
    }
}

@media (max-width: 1024px) {
    .artist-card,
    .release-card {
        flex: 0 0 calc(33.333% - 1.5rem);
    }
}

@media (max-width: 768px) {
    .artist-card,
    .release-card {
        flex: 0 0 calc(50% - 1.5rem);
    }
}

@media (max-width: 480px) {
    .artist-card,
    .release-card {
        flex: 0 0 100%;
    }
}
</style>
