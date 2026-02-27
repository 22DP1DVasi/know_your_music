<script setup>
import { Head, router } from "@inertiajs/vue3";
import { ref, onBeforeUnmount, onMounted } from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";
import ArtistCardMain from '@/Components/Artists/ArtistCardMain.vue';

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
                <ArtistCardMain
                    v-for="artist in artists"
                    :key="artist.id"
                    :artist="artist"
                    :redirect-to="redirectToArtist"
                    :show-track-count="false"
                    :track-count-text="(count) => `${count} ${count === 1 ? 'track' : 'tracks'}`"
                />
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
}

</style>
