<template>
    <Head title="Tracks Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <div class="results-header">
                <h1 class="results-title">Tracks Matching "{{ searchQuery }}"</h1>
                <div class="search-container">
                    <div class="search">
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
                    <div class="filter-and-back">
                        <div class="go-back-arrow" @click="goBack">
                            <span class="arrow-icon">←</span>
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
                :search-type="searchType"
                class="pagination"
            />
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from "@inertiajs/vue3";
import { ref, watch } from 'vue';
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
    totalPages: Number
});

const localSearchQuery = ref(props.searchQuery);
const searchType = ref(props.searchType || 'title');

const performSearch = () => {
    router.visit(`/search/tracks?q=${localSearchQuery.value}&type=${searchType.value}`, {
        preserveState: true,
        replace: true
    });
};

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
.search-results {
    padding: 1rem 0 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.results-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 2rem;
    padding: 0 2rem;
}

.search-container {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 0;
    margin: 0;
    padding: 0;
}

.search-container .search {
    margin-right: 6.6rem;
}

.search {
    width: 300px;
    position: relative;
    display: flex;
    z-index: 1;
}

.searchTerm {
    width: 100%;
    border: 3px solid #54b3ebed;
    border-right: none;
    padding: 10px;
    height: 40px;
    border-radius: 7px 0 0 7px;
    outline: none;
    color: #000000;
    font-size: 16px;
}

.searchTerm:focus {
    outline: none !important;
    box-shadow: none !important;
}

.searchButton {
    position: relative;
    width: 40px;
    height: 40px;
    border: 1px solid #54b3ebed;
    background: #54b3ebed;
    text-align: center;
    color: #fff;
    border-radius: 0 7px 7px 0;
    cursor: pointer;
    font-size: 20px;
    overflow: hidden;
}

.searchButton i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

.searchButton:hover i {
    opacity: 0;
    transform: scale(0.5);
}

.searchButton:hover::after {
    content: "\f001";
    font-family: "FontAwesome";
    font-size: 20px;
    color: #fff;
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

.filter-and-back {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: calc(12px + 48vw);
    max-width: 1000px;
    width: 100%;
    margin: 5px 5.7rem 0 auto;
    padding: 0 1rem;
}

.filter-options {
    display: flex;
    gap: 1.5rem;
    background: white;
    padding: 0.5rem 1rem;
    border-radius: 7px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.filter-options label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
}

.results-title {
    max-width: 800px;
    text-align: center;
    font-size: 2.2rem;
    margin: 0 auto;
    color: #0c4baa;
    font-weight: 600;
    padding: 1rem 2rem;
}

.go-back-arrow {
    cursor: pointer;
    background-color: #3f80e4;
    border-radius: 50%;
    padding: 8px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    transition: background-color 0.2s ease;
    flex-shrink: 0;
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

@media (max-width: 1200px) {
    .filter-and-back {
        gap: 32rem;
        margin-right: 4rem;
    }
}

@media (max-width: 1050px) {
    .filter-and-back {
        gap: 24rem;
        margin-right: 3rem;
    }
}

@media (max-width: 950px) {
    .filter-and-back {
        gap: 18rem;
        margin-right: 2rem;
    }
}

@media (max-width: 890px) {
    .filter-and-back {
        gap: 1rem;
        justify-content: space-between;
        margin: 5px 1rem 0;
        padding: 0 1rem;
        width: calc(100% - 2rem);
    }

    .search-container .search {
        margin-right: 0;
    }
}

@media (max-width: 768px) {
    .results-title {
        font-size: 1.8rem;
        padding-top: 0.5rem;
    }

    .track-info h3 {
        max-width: 180px;
    }

    .search-container {
        flex-direction: column;
        align-items: center;
        gap: 1rem;
        padding: 0 1rem;
    }

    .search-container .search {
        margin-right: 0;
        width: 100%;
        max-width: 300px;
    }

    .filter-and-back {
        flex-direction: row;
        justify-content: flex-end;
        gap: calc(16px + 27vw);
        margin: 5px 0 0 41px;
    }

    .filter-options {
        flex-direction: column;
        gap: 0.5rem;
        padding: 0.75rem;
        width: fit-content;
        margin: 0;
        align-self: flex-end;
    }

    .filter-options label {
        font-size: 0.9rem;
        white-space: nowrap;
    }

    .go-back-arrow {
        align-self: flex-start;
        margin-top: 0;
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

    .results-header {
        padding: 0 1rem;
    }

    .searchTerm {
        font-size: 14px;
    }

    .filter-and-back {
        gap: 17rem;
    }

    .filter-options {
        padding: 0.5rem;
    }

    .filter-options label {
        font-size: 0.85rem;
    }
}
</style>
