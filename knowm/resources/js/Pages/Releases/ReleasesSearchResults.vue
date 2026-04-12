<script setup>
import { Head, router } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount } from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";
import ReleaseCard from "@/Components/Releases/ReleaseCard.vue";

const props = defineProps({
    releases: Array,
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

const localPerPage = ref(props.perPage || 24);

const checkScreenSize = () => {
    localPerPage.value = window.innerWidth <= 768 ? 12 : 24;
};

onMounted(() => {
    checkScreenSize();
    window.addEventListener('resize', checkScreenSize);
});

onBeforeUnmount(() => {
    window.removeEventListener('resize', checkScreenSize);
});

const performSearch = () => {
    router.visit(`/search/releases?q=${localSearchQuery.value}&type=${searchType.value}&perPage=${localPerPage.value}`, {
        preserveState: true,
        replace: true
    });
};

const formatArtists = (artists) => {
    if (!artists || artists.length === 0) return '';
    const names = artists.map(artist => artist.name);
    return names.join(', ');
};

const redirectToRelease = (slug) => {
    router.get(`/releases/${slug}`);
};

const goBack = () => {
    router.visit(`/search?q=${props.searchQuery}`);
};

</script>

<template>
    <Head title="All Releases Search Results {{ searchQuery }}" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <div class="results-header">
                <h1 class="results-title">All Releases Matching "{{ searchQuery }}"</h1>
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
                <div class="release-results-wrapper">
                    <div class="release-results">
                        <ReleaseCard
                            v-for="release in releases"
                            :key="release.id"
                            :release="release"
                            :artists-label="release.artists.length > 1 ? 'by' : ''"
                            :max-artists="3"
                            @release-click="(release) => redirectToRelease(release.slug)"
                        />
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
    width: 340px ;
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

.results-section {
    margin: 0 auto;
    margin-bottom: 2.5rem;
    max-width: 1000px;
}

.release-results-wrapper {
    padding: 0 2rem;
    margin: 0 auto;
    max-width: 1200px;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
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

@media (max-width: 768px) {
    .search-container {
        padding: 0 2rem;
        max-width: 100%;
    }

    .searchTerm {
        font-size: 16px;
        height: 46px;
    }

    .results-title {
        font-size: 1.8rem;
        padding: 0.5rem 1rem 1rem;
    }

    .filter-options {
        flex-wrap: wrap;
        gap: 1rem;
        padding: 0.5rem;
    }

    .search-controls {
        padding: 0 1rem;
    }

    .go-back-arrow-wrapper {
        margin-bottom: 5px;
    }

    .go-back-arrow {
        left: 1rem;
    }

    .release-results-wrapper {
        padding: 0 1rem;
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
}

@media (max-width: 480px) {
    .search-container {
        padding: 0 1rem;
        justify-content: center;
        align-items: center;
        margin-bottom: 0.5rem;
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

    .searchTerm {
        font-size: 15px;
        padding: 10px;
        width: 100%;
        max-width: 280px;
    }

    .release-results-wrapper {
        padding: 0 1rem;
    }

    .release-results {
        justify-content: center;
    }
}
</style>
