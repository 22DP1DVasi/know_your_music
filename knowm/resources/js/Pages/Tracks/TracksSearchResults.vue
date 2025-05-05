<template>
    <Head title="Tracks Search Results {{ searchQuery }}" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <div class="results-header">
                <h1 class="results-title">Tracks Matching "{{ searchQuery }}"</h1>
                <div class="go-back-arrow-wrapper">
                    <div class="go-back-arrow" @click="goBack">
                        <span class="arrow-icon">←</span>
                    </div>
                </div>
                <div class="search-controls">
                    <div class="search-container">
                        <input
                            type="text"
                            class="searchTerm"
                            placeholder="Search tracks..."
                            v-model="localSearchQuery"
                            @keyup.enter="performSearch"
                        >
                        <button
                            type="submit"
                            class="searchButton"
                            @click="performSearch"
                        >
                            <i class="fa fa-search"></i>
                        </button>
                    </div>

                    <div class="filter-options">
                        <label>
                            <input
                                type="radio"
                                v-model="searchType"
                                value="title"
                            />
                            By Title
                        </label>
                        <label>
                            <input
                                type="radio"
                                v-model="searchType"
                                value="artist"
                            />
                            By Artist
                        </label>
                    </div>
                </div>
            </div>

            <div class="track-list metadata-track-list">
                <div v-for="track in tracks" :key="track.id" class="track-card">
                    <img :src="track.cover_url" class="track-image" :alt="track.title">
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
                :search-type="searchType"
                class="pagination"
            />
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount } from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    tracks: Array,
    searchQuery: String,
    searchType: {
        type: String,
        default: 'title'
    },
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number,
    perPage: Number
});

const localSearchQuery = ref(props.searchQuery);
const searchType = ref(props.searchType || 'title');

const localPerPage = ref(props.perPage || 20);

const checkScreenSize = () => {
    localPerPage.value = window.innerWidth <= 768 ? 12 : 20;
};

onMounted(() => {
    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
});

onBeforeUnmount(() => {
    window.removeEventListener('resize', checkScreenSize);
});

const performSearch = () => {
    router.visit(`/search/tracks?q=${localSearchQuery.value}&type=${searchType.value}&perPage=${localPerPage.value}`, {
        preserveState: true,
        replace: true
    });
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
.search-results {
    padding: 1rem 0 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.results-header {
    display: flex;
    flex-direction: column;
    padding: 0 2rem;
    gap: 0;
    margin-bottom: 17px;
}

.search-container {
    display: flex;
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
    position: relative;
}

.search-controls {
    display: flex;
    flex-direction: column;
    align-items: center;
    max-width: 800px;
    position: relative;
    margin: 0 auto;
    padding: 0;
}

.searchTerm {
    height: 46px;
    width: 340px;
    flex: 1;
    padding: 12px;
    font-size: 17px;
    border: 3px solid #54b3ebed;
    border-right: none;
    border-radius: 7px 0 0 7px;
    outline: none;
}

.searchTerm:focus {
    outline: none !important;
    box-shadow: none !important;
}

.searchButton {
    width: 40px;
    height: 46px;
    border: 1px solid #54b3ebed;
    background: #54b3ebed;
    text-align: center;
    color: #fff;
    border-radius: 0 7px 7px 0;
    cursor: pointer;
    font-size: 20px;
    overflow: hidden;
    position: relative;
}

.searchButton i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

.searchButton:hover i {
    opacity: 0;
    transform: scale(0.5);
}

.searchButton:hover::after {
    content: "\f001";   /* FontAwesome music note */
    font-family: "FontAwesome";
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.searchButton::after {
    content: "";
    opacity: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.5);
}

.filter-options {
    width: 200px;
    height: 100%;
    max-width: 300px;
    margin: 0 auto;
    display: flex;
    gap: 1rem;
    background: white;
    padding: 1rem 0;
    border-radius: 7px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-top: 1rem;
    align-items: center;
    justify-content: center;
}

.filter-options label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
}

.results-title {
    margin-bottom: -15px;
    padding: 0;
    text-align: center;
    font-size: 2.2rem;
    color: #0c4baa;
    font-weight: 600;
}

.go-back-arrow-wrapper {
    margin-top: -10px;
    padding-left: calc(50% - 470px);
}

.go-back-arrow {
    cursor: pointer;
    background-color: #3f80e4;
    border-radius: 50%;
    margin: 0.5rem auto 0;
    padding: 8px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
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

.track-card {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
    gap: 1rem;
}

.track-image {
    width: 60px;
    height: 60px;
    border-radius: 4px;
    object-fit: cover;
    flex-shrink: 0;
    margin: 0;
    padding: 0;
}

.track-info {
    flex: 1;
    min-width: 0;
    padding: 0 0.5rem;
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
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    margin: 0;
    color: #666;
    font-size: 0.9rem;
    width: 100%;
    display: block;
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

@media (min-width: 1600px) {
    .filter-options {
        max-width: 500px;
    }
}

@media (max-width: 1200px) {
    .search-container {
        max-width: 100%;
        padding: 0 4rem;
    }
}

@media (max-width: 870px) {
    .metadata-track-list {
        max-width: 85%;
        margin: 0 auto;
        padding: 0 1.25rem;
    }

    .track-card {
        padding: 0.75rem 0;
        gap: 0.75rem;
    }

    .track-image {
        width: 55px;
        height: 55px;
    }

    .track-info h3 {
        max-width: 180px;
    }
}

@media (max-width: 768px) {
    .results-title {
        font-size: 1.8rem;
        padding: 0.5rem 1rem 1rem;
    }

    .search-container {
        padding: 0 2rem;
        max-width: 100%;
    }

    .search-controls {
        padding: 0 1rem;
    }

    .searchTerm {
        font-size: 16px;
        height: 46px;
    }

    .filter-options {
        flex-wrap: wrap;
        gap: 1rem;
        padding: 0.5rem;
    }

    .go-back-arrow-wrapper {
        margin-bottom: 5px;
    }

    .go-back-arrow {
        left: 1rem;
    }

    .metadata-track-list {
        max-width: 90%;
        padding: 0 1.75rem;
    }

    .track-card {
        padding: 0.75rem 0;
    }

    .track-info h3 {
        max-width: 200px;
    }
}

@media (max-width: 540px) {
    .searchTerm {
        font-size: 14px;
        padding: 10px;
        height: 42px;
        max-width: 500px;
        width: 250px;
    }

    .metadata-track-list {
        padding: 0 1rem;
    }

    .track-info h3 {
        max-width: 160px;
    }
}

@media (max-width: 480px) {
    .search-container {
        padding: 0 1rem;
        justify-content: center;
        align-items: center;
        margin-bottom: 0.5rem;
    }

    .searchTerm {
        font-size: 15px;
        padding: 10px;
        width: 100%;
        max-width: 280px;
    }

    .results-title {
        font-size: 1.5rem;
    }

    .go-back-arrow {
        width: 35px;
        height: 35px;
        padding-top: 6px !important;
    }

    .filter-options {
        width: 200px;
        max-width: 300px;
        margin: 0 auto;
        align-items: center;
        gap: 0.75rem;
        font-size: 0.9rem;
    }

    .filter-options label {
        font-size: 0.85rem;
    }

    .track-card {
        padding: 0.75rem 0;
        gap: 0.75rem;
    }

    .track-image {
        width: 50px;
        height: 50px;
    }

    .track-info {
        padding: 0 0.5rem;
    }

    .metadata-track-list {
        padding: 0 0.75rem;
    }

    .track-info h3 {
        max-width: 140px;
    }

    .track-duration {
        flex: 0 0 60px;
        font-size: 0.85rem;
    }
}
</style>
