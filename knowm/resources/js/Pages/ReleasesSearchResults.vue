<template>
    <Head title="All Releases Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <div class="results-header">
                <h1 class="results-title">All Releases Matching "{{ searchQuery }}"</h1>
                <div class="search-container">
                    <div class="search-group">
                        <div class="go-back-arrow" @click="goBack">
                            <span class="arrow-icon">←</span>
                        </div>
                        <div class="search">
                            <input
                                type="text"
                                class="searchTerm"
                                placeholder="Search releases..."
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

            <section v-if="releases.length > 0" class="results-section">
                <div class="release-results">
                    <div v-for="release in releases" :key="release.id" class="release-card">
                        <img :src="getReleaseImage(release)" :alt="release.title">
                        <div class="release-info">
                            <h3>{{ release.title }}</h3>
                            <p class="artists-names">
                                <span v-for="(artist, index) in release.artists" :key="artist.id">
                                    {{ artist.name }}<span v-if="index < release.artists.length - 1">, </span>
                                </span>
                            </p>
                            <p>{{ release.tracks_count }} tracks • {{ release.release_type }}</p>
                        </div>
                    </div>
                </div>
            </section>

            <div v-else class="no-results">
                No releases found for "{{ searchQuery }}"
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
    releases: Array,
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
    router.visit(`/search/releases?q=${localSearchQuery.value}&type=${searchType.value}`, {
        preserveState: true,
        replace: true
    });
};

const getReleaseImage = (release) => {
    return release.cover_url || '/images/default-release-cover.webp';
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
    align-items: center;
    gap: 1rem !important;
    max-width: 600px;
    padding: 0 1rem;
    margin-top: 30px;
}

.search-group {
    display: flex;
    align-items: center;
    gap: 1rem;
    width: 100%;
}

.search {
    flex-grow: 1;
    position: relative;
    display: flex;
    height: 46px;
}

.searchTerm {
    width: 100%;
    border: 3px solid #54b3ebed;
    border-right: none;
    padding: 10px;
    height: 100%;
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
    height: 100%;
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

.filter-options {
    display: flex;
    gap: 1.5rem !important;
    max-width: 250px !important;
    background: white;
    padding: 0.5rem 0.3rem !important;
    border-radius: 7px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    justify-content: center;
}

.filter-options label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
}

.results-title {
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

.results-section {
    margin: 0 auto;
    padding: 0 2rem;
    margin-bottom: 2.5rem;
    max-width: 1000px;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.2rem);
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    min-height: 340px;
    aspect-ratio: 3/4;
}

.release-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.release-card img {
    width: 100%;
    height: 220px;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
}

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

.artists-names {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
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
        padding: 0.5rem 1rem 1rem;
    }

    .search-container {
        padding: 0 0.5rem;
    }

    .search-group {
        gap: 0.5rem;
    }

    .release-card {
        flex: 0 0 calc(50% - 1rem);
        min-height: 380px;
    }

    .filter-options {
        flex-wrap: wrap;
        gap: 1rem;
        padding: 0.5rem;
    }
}

@media (max-width: 480px) {
    .results-title {
        font-size: 1.5rem;
    }

    .go-back-arrow {
        width: 35px;
        height: 35px;
        padding: 6px;
    }

    .filter-options {
        gap: 0.75rem;
        font-size: 0.9rem;
    }

    .release-card {
        min-height: 320px;
    }

    .release-card img {
        height: 180px;
    }
}

.search-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem !important;
    max-width: 600px;
    padding: 0 1rem;
    margin: 30px auto 0; /* Centered horizontally */
    width: 100%;
}

.search-group {
    display: flex;
    align-items: center;
    justify-content: center; /* Center search bar + arrow */
    gap: 1rem;
    width: 100%;
    position: relative;
}

.search {
    flex-grow: 1;
    max-width: 500px; /* Limit search bar width */
    position: relative;
    display: flex;
}

.filter-options {
    display: flex;
    gap: 1.5rem !important;
    background: white;
    padding: 0.5rem 1rem;
    border-radius: 7px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    justify-content: center;
    width: 100%;
    max-width: 500px; /* Match search bar width */
}

/* Mobile adjustments */
@media (max-width: 768px) {
    .search-group {
        gap: 0.5rem;
        padding: 0 10px;
    }

    .search {
        max-width: 100%;
    }

    .filter-options {
        flex-wrap: wrap;
        gap: 1rem;
        padding: 0.5rem;
        max-width: 100%;
    }
}

@media (max-width: 480px) {
    .searchTerm {
        font-size: 14px;
    }

    .filter-options {
        gap: 0.75rem;
        font-size: 0.9rem;
        padding: 0.5rem;
    }
}

.search-results {
    padding: 1rem 0 2rem;
    max-width: 1400px;
    margin: 0 auto;
}

.search-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem !important;
    max-width: 1200px; /* Wider than card container */
    width: 100%;
    padding: 0 1rem;
    margin: 30px auto 0;
}

.search-group {
    display: flex;
    align-items: center;
    gap: 1rem;
    width: 100%;
    max-width: 1000px; /* Increased width */
}

.results-section {
    margin: 0 auto;
    padding: 0 2rem;
    margin-bottom: 2.5rem;
    max-width: 1000px; /* Narrower than search container */
}

.release-card {
    flex: 0 0 calc(25% - 1.2rem); /* Maintain card size */
}

.filter-options {
    max-width: 1000px; /* Match search group width */
    width: 100%;
}

/* Mobile adjustments */
@media (max-width: 1200px) {
    .search-container {
        max-width: 100%;
        padding: 0 2rem;
    }

    .search-group {
        max-width: 800px;
    }
}

@media (max-width: 768px) {
    .search-group {
        max-width: 100%;
        padding: 0;
    }

    .filter-options {
        max-width: 100%;
    }

    .release-card {
        flex: 0 0 calc(50% - 1rem);
    }
}

@media (max-width: 480px) {
    .search-container {
        padding: 0 1rem;
    }

    .search-group {
        gap: 0.5rem;
    }
}

.search-results {
    padding: 1rem 0 2rem;
    max-width: 1600px;  /* Increased from 1400px */
    margin: 0 auto;
}

.search-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem !important;
    max-width: 1400px;  /* Increased from 1200px */
    width: 100%;
    padding: 0 1rem;
    margin: 30px auto 0;
}

.search-group {
    display: flex;
    align-items: center;
    gap: 1rem;
    width: 100%;
    max-width: 1200px;  /* Increased from 1000px */
}

.results-section {
    margin: 0 auto;
    padding: 0 2rem;
    margin-bottom: 2.5rem;
    max-width: 1000px;  /* Kept narrower than search section */
}

.searchTerm {
    width: 100%;
    padding: 12px;  /* Increased padding */
    height: 46px;  /* Increased height */
    font-size: 17px;  /* Larger font */
}

.filter-options {
    max-width: 1200px;  /* Match search group width */
    width: 100%;
    padding: 1rem 2rem;  /* More padding */
}

/* Mobile adjustments */
@media (min-width: 1600px) {
    .search-group {
        max-width: 1400px;
    }

    .filter-options {
        max-width: 1400px;
    }
}

@media (max-width: 1200px) {
    .search-container {
        max-width: 100%;
        padding: 0 4rem;
    }
}

@media (max-width: 768px) {
    .search-container {
        padding: 0 2rem;
    }

    .searchTerm {
        font-size: 16px;
        height: 42px;
    }
}

@media (max-width: 480px) {
    .search-container {
        padding: 0 1rem;
    }

    .searchTerm {
        font-size: 15px;
        padding: 10px;
    }
}
</style>
