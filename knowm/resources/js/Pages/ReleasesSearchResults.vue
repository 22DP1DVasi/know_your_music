<template>
    <Head title="All Releases Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <div class="results-header">
                <h1 class="results-title">All Releases Matching "{{ searchQuery }}"</h1>
                <div class="search-container">
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

<!--            <div class="back-container">-->
<!--                <div class="go-back-arrow" @click="goBack">-->
<!--                    <span class="arrow-icon">←</span>-->
<!--                </div>-->
<!--            </div>-->

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
    justify-content: flex-end; /* move both to the right side */
    gap: 42rem; /* control distance between go-back arrow and filter box */
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

.results-section {
    margin: 0 auto;
    padding: 0 2rem;
    margin-bottom: 2.5rem;
    max-width: 1000px;
    margin: 0 auto;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.2rem);  /* 4 cards per row */
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    min-width: 0;
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
    min-width: 0;
}

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

    .release-card {
        flex: 0 0 calc(50% - 1rem);  /* 2 cards per row */
        min-height: 380px;
    }

    .release-card img {
        height: 220px;
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
        flex-direction: row; /* Keep horizontal layout */
        justify-content: flex-end; /* Push content to right */
        gap: 1rem; /* Adjust gap */
        margin: 5px 0 0 0; /* Remove right margin */
    }

    .filter-options {
        flex-direction: column; /* Stack options vertically */
        gap: 0.5rem;
        padding: 0.75rem;
        width: fit-content;
        margin: 0; /* Remove auto margin */
        align-self: flex-end; /* Align to right */
    }

    .filter-options label {
        font-size: 0.9rem; /* Slightly smaller text */
        white-space: nowrap; /* Prevent line breaks */
    }

    .go-back-arrow {
        align-self: flex-start; /* align back arrow to left */
        margin-top: 0; /* Remove top margin */
    }
}

@media (max-width: 480px) {
    .results-title {
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .release-card {
        flex: 0 0 calc(50% - 0.75rem);  /* 2 cards per row*/
        min-height: 320px;
    }

    .release-card img {
        height: 180px;
    }

    .results-header {
        padding: 0 1rem;
    }

    .searchTerm {
        font-size: 14px;
    }

    .filter-options {
        padding: 0.5rem;
    }

    .filter-options label {
        font-size: 0.85rem; /* Even smaller text for tiny screens */
    }
}
</style>
