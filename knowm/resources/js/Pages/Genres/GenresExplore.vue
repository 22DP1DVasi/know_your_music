<script setup>
import { Head, Link, router } from "@inertiajs/vue3";
import {ref, computed, onBeforeUnmount, onMounted, watch} from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";
import GenreCard from "@/Components/Genres/GenreCard.vue";
import { useI18n } from 'vue-i18n';

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

const { t } = useI18n();

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

const buildQueryParams = () => {
    const params = new URLSearchParams();

    if (localSearchQuery.value) {
        params.set('q', localSearchQuery.value);
    }
    params.set('perPage', localPerPage.value);
    params.set('sort', localSortOrder.value);

    return params;
};

const reloadResults = () => {
    router.visit(`/explore/genres?${buildQueryParams().toString()}`,{
            preserveState: true,
            replace: true
        }
    );
};

const performSearch = () => {
    reloadResults()
};

const applySort = () => {
    reloadResults()
};

const redirectToGenre = (slug) => {
    router.get(route('genres.show', slug));
};

</script>

<template>
    <Head :title="t('explore_pages.genres.page_title')" />
    <Navbar />
    <main class="flex-1">
        <div class="explore-genres">
            <div class="results-header">
                <h1 class="results-title">{{ t('explore_pages.genres.page_title') }}</h1>
                <div class="filters-container">
                    <div class="search-controls">
                        <div class="search-container">
                            <input
                                type="text"
                                class="searchTerm"
                                :placeholder="t('explore_pages.genres.search_placeholder')"
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

                <div class="sort-controls">
                    <label>{{ t('explore_pages.genres.sort_by') }}:</label>
                    <select v-model="localSortOrder" @change="applySort">
                        <option value="asc">{{ t('explore_pages.genres.sort_asc') }}</option>
                        <option value="desc">{{ t('explore_pages.genres.sort_desc') }}</option>
                    </select>
                </div>
            </div>

            <div class="genre-results">
                <GenreCard
                    v-for="genre in genres"
                    :key="genre.id"
                    :genre="genre"
                    @genre-click="redirectToGenre"
                />
            </div>

            <div v-if="genres.length === 0" class="no-results">
                {{ t('explore_pages.genres.no_results') }}
                <span v-if="localSearchQuery">{{ t('explore_pages.genres.for') }} "{{ localSearchQuery }}"</span>
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
    flex-direction: column;
    gap: 1rem;
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
}

.search-controls {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
}

.search-container {
    display: flex;
    width: 100%;
    max-width: 500px;
    margin: 0 auto;
    position: relative;
}

.searchTerm {
    flex: 1;
    min-width: 0;
    height: 46px;
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

.genre-results {
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

    .genre-info h3 {
        font-size: 1.05rem;
    }

    .filters-container {
        flex-direction: column;
    }

    .sort-controls {
        padding: 0 1rem;
    }
}

@media (max-width: 540px) {
    .searchTerm {
        font-size: 14px;
        padding: 10px;
        height: 46px;
        max-width: 500px;
        width: 100%;
    }
}

@media (max-width: 480px) {
    .search-container {
        width: 100%;
        max-width: none;
        padding: 0 1rem;
    }

    .searchTerm {
        font-size: 15px;
        padding: 10px;
    }

    .results-title {
        font-size: 1.5rem;
    }

    .genre-results {
        justify-content: center;
    }
}

</style>
