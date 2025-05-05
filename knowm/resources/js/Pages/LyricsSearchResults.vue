<template>
    <Head title="Lyrics Search Results" />
    <Navbar />
    <main class="flex-1">
        <div class="search-results">
            <div class="results-header">
                <h1 class="results-title">Lyrics Matching "{{ searchQuery }}"</h1>
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
                            placeholder="Search lyrics..."
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
            </div>

            <div class="track-list lyric-matches">
                <div v-for="track in tracks" :key="track.id" class="track-item">
                    <img class="track-image" :src="getTrackImage(track)" :alt="track.title">
                    <div class="track-info">
                        <h3>
                            <a @click="redirectToTrack(track.slug)" class="track-title-link">
                                {{ track.title }}
                            </a>
                        </h3>
                        <p class="artists-names">
                            <span v-for="(artist, index) in track.artists" :key="artist.id">
                                {{ artist.name }}<span v-if="index < track.artists.length - 1">, </span>
                            </span>
                        </p>
                        <p class="lyric-snippet" v-html="track.lyric_snippet || 'No lyrics snippet available'"></p>
                    </div>
                    <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                </div>
            </div>

            <div v-if="tracks.length === 0" class="no-results">
                No lyrics found for "{{ searchQuery }}"
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
import { ref, onBeforeUnmount, onMounted } from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    tracks: Array,
    searchQuery: String,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number,
    perPage: Number
});

const localSearchQuery = ref(props.searchQuery);
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
    router.visit(`/search/lyrics?q=${localSearchQuery.value}&perPage=${localPerPage.value}`, {
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

// const cleanSnippet = (snippet) => {
//     if (!snippet) return '';
//     return snippet
//         .replace(/\\/g, '')
//         .replace(/[\x00-\x1F\x7F]/g, ' ')
//         .replace(/\s+/g, ' ')
//         .trim();
// };

const goBack = () => {
    router.visit(`/search?q=${props.searchQuery}`);
};

const redirectToTrack = (slug) => {
    router.get(`/tracks/${slug}`);
};

</script>

<style scoped>
.search-results {
    padding: 1rem 2rem 2rem;
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
    content: "\f001";
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

.results-title {
    margin-bottom: -15px;
    padding: 0;
    text-align: center;
    font-size: 2.2rem;
    color: #0c4baa;
    font-weight: 600;
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

.lyric-matches {
    max-width: 900px;
    margin: 0 auto;
}

.track-item {
    display: flex;
    align-items: center;
    padding: 1rem;
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

.track-title-link {
    color: inherit;
    text-decoration: none;
    cursor: pointer;
    transition: color 0.2s;
}

.track-title-link:hover {
    color: #0c4baa;
    text-decoration: underline;
}

.artists-names {
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    width: 100%;
}

.lyric-snippet {
    margin: 0.5rem 0 0 0;
    color: #555;
    font-size: 0.85rem;
    line-height: 1.4;
    font-style: italic;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}

.lyric-snippet mark {
    background-color: rgba(255, 235, 59, 0.4);
    color: inherit;
    padding: 0 2px;
    border-radius: 3px;
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
    .search-container {
        max-width: 100%;
        padding: 0 4rem;
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

    .searchTerm {
        font-size: 16px;
        height: 46px;
    }

    .go-back-arrow-wrapper {
        margin-bottom: 5px;
    }

    .track-info h3 {
        max-width: 180px;
    }

    .lyric-snippet {
        -webkit-line-clamp: 3;
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
        margin-bottom: 1.5rem;
    }

    .go-back-arrow {
        width: 35px;
        height: 35px;
        padding-top: 6px !important;
    }

    .searchTerm {
        font-size: 15px;
        padding: 10px;
        width: 100%;
        max-width: 280px;
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

    .lyric-snippet {
        font-size: 0.8rem;
        -webkit-line-clamp: 2;
    }
}
</style>
