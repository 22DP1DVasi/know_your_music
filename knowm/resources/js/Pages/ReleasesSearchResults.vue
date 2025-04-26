<template>
    <Head title="All Releases Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <h1 class="results-title">All Releases Matching "{{ searchQuery }}"</h1>

            <div class="results-header">
                <div class="go-back-arrow" @click="goBack">
                    <span class="arrow-icon">←</span>
                </div>
            </div>

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

            <div v-if="releases.length === 0" class="no-results">
                No releases found for "{{ searchQuery }}"
            </div>

            <Pagination
                :links="paginationLinks"
                :current-page="currentPage"
                :total-pages="totalPages"
                class="pagination"
            />
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head } from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    releases: Array,
    searchQuery: String,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number
});

const getReleaseImage = (release) => {
    return release.cover_url || '/images/default-release-cover.webp';
};

const goBack = () => {
    window.history.back();
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

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.5rem);  /* 4 cards per row*/
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s;
    min-width: 0;
    min-height: 340px;
    display: flex;
    flex-direction: column;
}

.release-card:hover {
    transform: translateY(-5px);
}

.release-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
    min-width: 0;
    flex: 1;
    display: flex;
    flex-direction: column;
}

/* max two rows for name/title, if overflows - ellipsis */
.release-info h3 {
    margin: 0 0 0.5rem 0;
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
    margin: 0 0 0.5rem 0;
    color: #666;
    font-size: 0.9rem;
}

.artists-names {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 0 0 0.5rem 0;
    color: #666;
    font-size: 0.9rem;
}

.view-button {
    margin-top: auto;
    display: inline-block;
    padding: 0.5rem 1rem;
    background-color: #0c4baa;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-size: 0.9rem;
    text-align: center;
    transition: background-color 0.2s;
}

.view-button:hover {
    background-color: #06419a;
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
}
</style>
