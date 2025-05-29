<template>
    <Head title="Explore Genres" />
    <Navbar />
    <main class="flex-1">
        <div class="explore-genres">
            <div class="results-header">
                <h1 class="results-title">Explore Genres</h1>
                <div class="filters-container">
                    <div class="search-controls">
                        <div class="search-container">
                            <input
                                type="text"
                                class="searchTerm"
                                placeholder="Search genres..."
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

                    <div class="sort-controls">
                        <label>Sort by:</label>
                        <select v-model="localSortOrder" @change="applySort">
                            <option value="asc">A-Z</option>
                            <option value="desc">Z-A</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="genre-results">
                <a v-for="genre in genres"
                   :key="genre.id"
                   @click="redirectToGenre(genre.slug)"
                   class="genre-card">
                    <div class="image-wrapper">
                        <img :src="genre.banner_url" :alt="genre.name">
                    </div>
                    <div class="genre-info">
                        <h3>{{ genre.name }}</h3>
                    </div>
                </a>
            </div>

            <div v-if="genres.length === 0" class="no-results">
                No genres found
                <span v-if="localSearchQuery">for "{{ localSearchQuery }}"</span>
            </div>

            <Pagination
                :links="paginationLinks"
                :current-page="currentPage"
                :total-pages="totalPages"
                :search-query="localSearchQuery"
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
    genres: Array,
    searchQuery: String,
    paginationLinks: Array,
    currentPage: Number,
    totalPages: Number,
    perPage: Number,
    sortOrder: {
        type: String,
        default: 'asc'
    }
});

const localSearchQuery = ref(props.searchQuery || '');
const localPerPage = ref(props.perPage || 24);
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
    router.visit(`/explore/genres?q=${localSearchQuery.value}&perPage=${localPerPage.value}&sort=${localSortOrder.value}`, {
        preserveState: true,
        replace: true
    });
};

const redirectToGenre = (slug) => {
    window.location.href = `/genres/${slug}`;
};

const applySort = () => {
    const params = new URLSearchParams();

    if (localSearchQuery.value) {
        params.set('q', localSearchQuery.value);
    }

    params.set('perPage', localPerPage.value);
    params.set('sort', localSortOrder.value);

    router.visit(`/explore/genres?${params.toString()}`, {
        preserveState: true,
        replace: true
    });
};

</script>

<style scoped>
.explore-genres {
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

.filters-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    gap: 1rem;
}

.search-container {
    display: flex;
    width: 100%;
    max-width: 500px;
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
    flex: 1;
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

.sort-controls {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.sort-controls label {
    font-weight: 500;
    color: #0c4baa;
    white-space: nowrap;
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

.genre-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.2rem;
    justify-content: flex-start;
    padding: 0 2rem;
}

.genre-card {
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

.genre-card:hover {
    cursor: pointer;
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.genre-card .image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.genre-card .image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.genre-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
    text-align: center;
}

.genre-info h3 {
    margin: 0;
    font-size: 1rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
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

    .genre-card {
        flex: 0 0 calc(50% - 0.75rem); /* 2 cards per row */
    }

    .genre-info {
        padding: 1.25rem;
    }

    .genre-info h3 {
        font-size: 1.05rem;
    }

    .filters-container {
        flex-direction: column;
        gap: 1rem;
    }

    .sort-controls {
        width: 100%;
        justify-content: flex-end;
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

    .genre-results {
        justify-content: center;
    }

    .genre-card {
        flex: 0 0 80%;
    }
}

</style>
