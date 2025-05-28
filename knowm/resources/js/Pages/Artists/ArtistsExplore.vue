<template>
    <Head title="Explore Artists" />
    <Navbar />
    <main class="flex-1">
        <div class="explore-artists">
            <div class="results-header">
                <h1 class="results-title">Explore Artists</h1>
                <div class="filters-container">
                    <div class="search-controls">
                        <div class="search-container">
                            <input
                                type="text"
                                class="searchTerm"
                                placeholder="Search artists..."
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

                    <button class="filter-button" @click="showGenreModal = true">
                        <i class="fa fa-filter"></i> Filter by Genre
                    </button>
                </div>

                <div class="sort-controls">
                    <label>Sort by:</label>
                    <select v-model="localSortOrder" @change="applySort">
                        <option value="asc">A-Z</option>
                        <option value="desc">Z-A</option>
                    </select>
                </div>

                <div v-if="selectedGenres.length > 0" class="selected-genres">
                    <div class="selected-genres-label">Selected genres:</div>
                    <div class="genre-tags">
                        <div v-for="genre in allGenres.filter(g => localSelectedGenres.includes(g.id))"
                             :key="genre.id"
                             class="genre-tag">
                            <span class="genre-tag-content">{{ lowercaseString(genre.name) }}</span>
                            <span class="remove-genre" @click="removeGenre(genre.id)">×</span>
                        </div>
                    </div>
                </div>
            </div>

            <div v-if="showGenreModal" class="modal-overlay" @click.self="showGenreModal = false">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3>Filter by Genre</h3>
                        <button class="close-modal" @click="showGenreModal = false">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="genre-list">
                            <div
                                v-for="genre in allGenres"
                                :key="genre.id"
                                class="genre-item"
                                @click="toggleGenre(genre.id)"
                            >
                                <input
                                    type="checkbox"
                                    :id="'genre-' + genre.id"
                                    :checked="localSelectedGenres.includes(genre.id)"
                                    @change="toggleGenre(genre.id)"
                                >
                                <label :for="'genre-' + genre.id">{{ lowercaseString(genre.name) }}</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn-clear" @click="clearGenres">Clear All</button>
                        <button class="btn-apply" @click="applyGenreFilters">Apply Filters</button>
                    </div>
                </div>
            </div>

            <div class="artist-results">
                <a v-for="artist in artists"
                   :key="artist.id"
                   @click="redirectToArtist(artist.slug)"
                   class="artist-card">
                    <div class="image-wrapper">
                        <img :src="artist.banner_url" :alt="artist.name">
                    </div>
                    <div class="artist-info">
                        <h3>{{ artist.name }}</h3>
                        <p>{{ artist.tracks_count }} {{ artist.tracks_count === 1 ? 'track' : 'tracks' }}</p>
                    </div>
                </a>
            </div>

            <div v-if="artists.length === 0" class="no-results">
                No artists found
                <span v-if="localSearchQuery">for "{{ localSearchQuery }}"</span>
                <span v-if="selectedGenres.length > 0"> with selected genres</span>
            </div>

            <Pagination
                :links="paginationLinks"
                :current-page="currentPage"
                :total-pages="totalPages"
                :search-query="localSearchQuery"
                :selected-genres="localSelectedGenres"
                class="pagination"
            />
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, Link, router } from "@inertiajs/vue3";
import {ref, computed, onBeforeUnmount, onMounted, watch} from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";

const props = defineProps({
    artists: Array,
    searchQuery: String,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number,
    perPage: Number,
    allGenres: Array,
    selectedGenres: {
        type: Array,
        default: () => []
    },
    sortOrder: {
        type: String,
        default: 'asc'
    }
});

const localSearchQuery = ref(props.searchQuery || '');
const localPerPage = ref(props.perPage || 24);
const showGenreModal = ref(false);
const localSelectedGenres = ref([...props.selectedGenres]);
const localSortOrder = ref(props.sortOrder);

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
    router.visit(`/explore/artists?q=${localSearchQuery.value}&genres=${localSelectedGenres.value.join(',')}&perPage=${localPerPage.value}&sort=${localSortOrder.value}`, {
        preserveState: true,
        replace: true
    });
};

const selectedGenreNames = computed(() => {
    return props.allGenres.filter(genre =>
        localSelectedGenres.value.includes(genre.id)
    );
});

watch(() => props.selectedGenres, (newVal) => {
    localSelectedGenres.value = [...newVal];
});

const redirectToArtist = (slug) => {
    window.location.href = `/artists/${slug}`;
};

const toggleGenre = (genreId) => {
    const index = localSelectedGenres.value.indexOf(genreId);
    if (index === -1) {
        localSelectedGenres.value.push(genreId);
    } else {
        localSelectedGenres.value.splice(index, 1);
    }
};

const removeGenre = (genreId) => {
    toggleGenre(genreId);
    performSearch();
};

const clearGenres = () => {
    localSelectedGenres.value = [];
};

const applyGenreFilters = () => {
    showGenreModal.value = false;
    performSearch();
};

const applySort = () => {
    const params = new URLSearchParams();

    if (localSearchQuery.value) {
        params.set('q', localSearchQuery.value);
    }

    if (localSelectedGenres.value.length > 0) {
        params.set('genres', localSelectedGenres.value.join(','));
    }

    params.set('perPage', localPerPage.value);
    params.set('sort', localSortOrder.value);

    router.visit(`/explore/artists?${params.toString()}`, {
        preserveState: true,
        replace: true
    });
};

function lowercaseString(val) {
    return String(val).toLowerCase();
}

</script>

<style scoped>
.explore-artists {
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

.filters-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
}

.filter-button {
    background-color: #0c4baa;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin: 0 auto;
    transition: background-color 0.2s;
}

.filter-button:hover {
    background-color: #14a8df;
}

.selected-genres {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    align-items: center;
    margin-top: 1rem;
    justify-content: center;
}

.selected-genres-label {
    font-size: 0.9rem;
    color: #666;
}

.genre-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.genre-tag {
    background: #f0f4ff;
    color: #0c4baa;
    padding: 0.35rem 0.75rem 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.85rem;
    max-width: 140px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    position: relative;
    transition: background 0.2s;
}

.genre-tag .remove-genre {
    flex-shrink: 0;
    margin-left: auto;
    cursor: pointer;
    font-size: 1rem;
    line-height: 1;
    padding: 0 0.1rem;
    border-radius: 50%;
    background-color: transparent;
    transition: background-color 0.2s;
}

.genre-tag-content {
    overflow: hidden;
    text-overflow: ellipsis;
    flex-grow: 1;
}

.genre-tag .remove-genre:hover {
    background-color: #d1dcff;
}

/* modal styles */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.modal-content {
    background-color: white;
    border-radius: 8px;
    width: 90%;
    max-width: 600px;
    max-height: 80vh;
    display: flex;
    flex-direction: column;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.modal-header {
    padding: 1rem;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    font-size: 1.2rem;
    color: #0c4baa;
}

.close-modal {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: #666;
}

.modal-body {
    padding: 1rem;
    overflow-y: auto;
}

.genre-list {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
}

.genre-item {
    display: flex;
    flex: 1 0 calc(20% - 0.75rem); /* 5 items per row */
    min-width: 150px;
    max-width: 200px;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem;
    border-radius: 4px;
    cursor: pointer;
}

.genre-item:hover {
    background-color: #f5f5f5;
}

.genre-item input {
    cursor: pointer;
}

.genre-item label {
    cursor: pointer;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.modal-footer {
    padding: 1rem;
    border-top: 1px solid #eee;
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
}

.btn-clear {
    background: none;
    border: 1px solid #ccc;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
}

.btn-apply {
    background-color: #0c4baa;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
}

.btn-apply:hover {
    background-color: #14a8df;
}

.sort-controls {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin: 1rem auto;
    max-width: 800px;
    padding: 0 2rem;
}

.sort-controls label {
    font-weight: 500;
    color: #0c4baa;
}

.sort-controls select {
    padding: 0.5rem;
    border: 2px solid #54b3ebed;
    border-radius: 5px;
    background: white;
    color: #333;
    font-size: 0.9rem;
    cursor: pointer;
}

.sort-controls select:focus {
    outline: none;
    box-shadow: 0 0 0 2px rgba(84, 179, 235, 0.3);
}

.results-title {
    margin-bottom: 15px;
    padding: 0;
    text-align: center;
    font-size: 2.2rem;
    color: #0c4baa;
    font-weight: 600;
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
}

.artist-card:hover {
    cursor: pointer;
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.artist-link {
    display: flex;
    flex-direction: column;
    height: 100%;
    text-decoration: none;
    color: inherit;
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

    .filters-container {
        flex-direction: column;
    }

    .genre-item {
        flex: 1 0 calc(33.333% - 0.75rem); /* 3 items per row */
        min-width: 120px;
    }

    .sort-controls {
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

    .searchTerm {
        font-size: 15px;
        padding: 10px;
        width: 100%;
        max-width: 280px;
    }

    .artist-results {
        justify-content: center;
    }

    .artist-card {
        flex: 0 0 80%;
    }

    .genre-item {
        flex: 1 0 calc(50% - 0.75rem); /* 2 items per row on mobile */
    }
}

</style>
