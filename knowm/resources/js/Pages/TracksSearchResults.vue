<template>
    <Head title="Tracks Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <h1 class="results-title">Tracks Matching "{{ searchQuery }}"</h1>

            <div class="results-header">
                <div class="go-back-arrow" @click="goBack">
                    <span class="arrow-icon">←</span>
                </div>
            </div>

            <div class="track-list metadata-track-list">
                <div v-for="track in tracks" :key="track.id" class="track-item">
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

            <div v-if="tracks.length === 0" class="no-results">
                No tracks found for "{{ searchQuery }}"
            </div>

            <Pagination
                :links="paginationLinks"
                :current-page="currentPage"
                :total-pages="totalPages"
                :search-query="searchQuery"
                class="pagination"
            />
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    tracks: Array,
    searchQuery: String,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number
});

const getTrackImage = (track) => {
    return track.cover_url || '/images/default-track-cover.webp';
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

const goBack = () => {
    router.visit(`/search?q=${props.searchQuery}`);
};
</script>

<style scoped>
.results-title {
    text-align: center;
    font-size: 2.2rem;
    margin-bottom: 2rem;
    color: #0c4baa;
    font-weight: 600;
    padding-top: 1rem;
}

.results-header {
    display: flex;
    margin-bottom: 2rem;
}

.search-results {
    padding: 1rem 2rem 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.go-back-arrow {
    cursor: pointer;
    background-color: #3f80e4;
    border-radius: 50%;
    padding: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.2s ease;
}

.go-back-arrow:hover {
    background-color: #14a8df;
}

.arrow-icon {
    font-size: 24px;
    color: white;
}

.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.metadata-track-list {
    max-width: 800px;
    margin: 0 auto;
}

.track-item {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
    gap: 1rem;
    transition: background-color 0.2s;
}

.track-item:hover {
    background-color: #f9f9f9;
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

.track-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 0.95rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100%;
    display: block;
}

.artists-names {
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

.no-results {
    padding: 2rem;
    text-align: center;
    font-size: 1.2rem;
    color: #666;
}

.pagination {
    margin-top: 3rem;
    justify-content: center;
}

@media (max-width: 768px) {
    .results-title {
        font-size: 1.8rem;
        padding-top: 0.5rem;
    }

    .track-info h3 {
        max-width: 180px;
    }
}

@media (max-width: 480px) {
    .results-title {
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .track-item {
        padding: 0.75rem;
        gap: 0.75rem;
    }

    .track-image {
        width: 40px;
        height: 40px;
    }

    .track-info {
        padding: 0 0.5rem;
    }

    .track-info h3 {
        font-size: 0.9rem;
        max-width: 150px;
    }

    .track-duration {
        flex: 0 0 60px;
        font-size: 0.85rem;
    }
}
</style>
