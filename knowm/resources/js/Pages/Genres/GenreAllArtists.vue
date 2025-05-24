<template>
    <Head :title="`All ${genre.name} Artists`" />
    <Navbar />
    <main class="flex-1">
        <div class="genre-artists-container">
            <div class="results-header">
                <h1 class="results-title">All {{ capitalizeFirstLetter(genre.name) }} Artists</h1>
                <div class="go-back-arrow-wrapper">
                    <div class="go-back-arrow" @click="goBack">
                        <span class="arrow-icon">←</span>
                    </div>
                </div>
            </div>

            <div class="artist-results">
                <div v-for="artist in artists" :key="artist.id" class="artist-card" @click="redirectToArtist(artist.slug)">
                    <div class="image-wrapper">
                        <img :src="artist.profile_url" :alt="artist.name">
                    </div>
                    <div class="artist-info">
                        <h3>{{ artist.name }}</h3>
                        <p>{{ artist.tracks_count }} {{ artist.tracks_count === 1 ? 'track' : 'tracks' }}</p>
                    </div>
                </div>
            </div>

            <div v-if="artists.length === 0" class="no-results">
                No artists found in this genre
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
import { Head, router } from "@inertiajs/vue3";
import { ref, onBeforeUnmount, onMounted } from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    genre: {
        type: Object,
        required: true,
        default: () => ({
            id: Number,
            name: String,
            slug: String
        })
    },
    artists: Array,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number,
    perPage: Number
});

function capitalizeFirstLetter(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

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

const redirectToArtist = (slug) => {
    router.visit(`/artists/${slug}`);
};

const goBack = () => {
    router.visit(`/genres/${props.genre.slug}`);
};

</script>

<style scoped>
.genre-artists-container {
    padding: 1rem 0 2rem;
    max-width: 1000px;
    margin: 0 auto;
}

.results-header {
    display: flex;
    flex-direction: column;
    padding: 0 2rem;
    gap: 0;
    margin-bottom: 17px;
    position: relative;
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
    display: flex;
}

.go-back-arrow {
    cursor: pointer;
    background-color: #3f80e4;
    border-radius: 50%;
    margin-bottom: 1rem;
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

.artist-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.2rem;
    justify-content: flex-start;
    padding: 0 2rem;
}

.artist-card {
    flex: 0 0 calc(25% - 1.125rem); /* 4 cards per row */
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    cursor: pointer;
}

.artist-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.artist-card .image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.artist-card .image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.artist-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
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
        padding: 0.5rem 1rem 1rem;
    }

    .artist-card {
        flex: 0 0 calc(50% - 0.75rem); /* 2 cards per row */
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
    }

    .go-back-arrow {
        width: 35px;
        height: 35px;
        padding-top: 6px !important;
    }

    .artist-results {
        justify-content: center;
    }

    .artist-card {
        flex: 0 0 80%;
    }
}

</style>
