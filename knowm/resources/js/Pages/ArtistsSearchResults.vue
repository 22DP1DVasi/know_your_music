<template>
    <Head title="All Artists Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <h1 class="results-title">All Artists Matching "{{ searchQuery }}"</h1>

            <div class="results-header">
                <div class="go-back-arrow" @click="goBack">
                    <span class="arrow-icon">←</span>
                </div>
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

            <div v-if="artists.length === 0" class="no-results">
                No artists found for "{{ searchQuery }}"
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
import {Head, router} from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    artists: Array,
    searchQuery: String,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number
});

const getArtistImage = (artist, type = 'banner') => {
    if (artist.banner_url) return artist.banner_url;
    return `/storage/artists/${artist.id}/${type}/${type}.webp`;
};

const goBack = () => {
    router.visit(`/search?q=${props.searchQuery}`);
};
</script>

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

.results-header {
    display: flex;
    margin-bottom: 2rem;
    padding: 0 2rem;
}

.search-results {
    padding: 1rem 0 2rem;
    max-width: 1000px;
    margin: 0 auto;
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

.artist-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.2rem;
    justify-content: flex-start;
    padding: 0 2rem;
}

.artist-card {
    flex: 0 0 calc(25% - 1.2rem);  /* 4 cards per row*/
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
                0 3px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    min-width: 0;
    min-height: 320px;
    aspect-ratio: 3/4;
}

.artist-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
                0 8px 12px rgba(0, 0, 0, 0.15);
}

.artist-card img {
    width: 100%;
    height: 220px;
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

.no-results {
    padding: 2rem;
    text-align: center;
    font-size: 1.2rem;
    color: #666;
}

.pagination {
    margin-top: 3rem;
    justify-content: center;
    padding: 0 2rem;
}

@media (max-width: 768px) {
    .results-title {
        font-size: 1.8rem;
        padding-top: 0.5rem;
    }

    .artist-card {
        flex: 0 0 calc(50% - 1rem);  /* 2 cards per row */
        min-height: 360px;
        height: 360px ;
        aspect-ratio: 3/4;
    }

    .artist-card img {
        height: 240px;
    }

    .artist-info {
        padding: 1.25rem;
    }

    .artist-info h3 {
        font-size: 1.05rem;
    }

    .artist-info p {
        font-size: 0.95rem;
    }
}

@media (max-width: 480px) {
    .results-title {
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .artist-card {
        flex: 0 0 calc(50% - 0.75rem);  /* 2 cards per row*/
        min-height: 300px;
        height: 300px;
    }

    .artist-card img {
        height: 180px;
    }
}
</style>
