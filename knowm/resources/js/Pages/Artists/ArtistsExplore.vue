<script setup>
import { Head, Link, router } from "@inertiajs/vue3";
import {ref, computed, onBeforeUnmount, onMounted, watch} from 'vue';
import Navbar from "@/Components/Navbar.vue";
import Footer from "@/Components/Footer.vue";
import Pagination from "@/Components/Pagination.vue";
import ArtistCardMain from '@/Components/Artists/ArtistCardMain.vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

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
    },
    formedFrom: {
        type: [String, Number],
        default: null
    },
    formedTo: {
        type: [String, Number],
        default: null
    },
    disbandedFrom: {
        type: [String, Number],
        default: null
    },
    disbandedTo: {
        type: [String, Number],
        default: null
    },
    includeEmptyFormed: {
        type: Boolean,
        default: false
    },
    includeEmptyDisbanded: {
        type: Boolean,
        default: false
    }
});

const localSearchQuery = ref(props.searchQuery || '');
const localPerPage = ref(props.perPage || 24);
const showGenreModal = ref(false);
const localSelectedGenres = ref([...props.selectedGenres]);
const localSortOrder = ref(props.sortOrder);

const localFormedFrom = ref(props.formedFrom || '');
const localFormedTo = ref(props.formedTo || '');
const localDisbandedFrom = ref(props.disbandedFrom || '');
const localDisbandedTo = ref(props.disbandedTo || '');
const localIncludeEmptyFormed = ref(props.includeEmptyFormed || false);
const localIncludeEmptyDisbanded = ref(props.includeEmptyDisbanded || false);
const showYearModal = ref(false);

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

// Update the existing performSearch function to include year filters
const performSearch = () => {
    const params = new URLSearchParams();

    if (localSearchQuery.value) {
        params.set('q', localSearchQuery.value);
    }

    if (localSelectedGenres.value.length > 0) {
        params.set('genres', localSelectedGenres.value.join(','));
    }

    params.set('perPage', localPerPage.value);
    params.set('sort', localSortOrder.value);

    // Add year params
    if (localFormedFrom.value) params.set('formed_from', localFormedFrom.value);
    if (localFormedTo.value) params.set('formed_to', localFormedTo.value);
    if (localDisbandedFrom.value) params.set('disbanded_from', localDisbandedFrom.value);
    if (localDisbandedTo.value) params.set('disbanded_to', localDisbandedTo.value);
    if (localIncludeEmptyFormed.value) params.set('include_empty_formed', '1');
    if (localIncludeEmptyDisbanded.value) params.set('include_empty_disbanded', '1');

    router.visit(`/explore/artists?${params.toString()}`, {
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

// Add year filter functions
const applyYearFilters = () => {
    showYearModal.value = false;
    performSearch();
};

const clearYearFilters = () => {
    localFormedFrom.value = '';
    localFormedTo.value = '';
    localDisbandedFrom.value = '';
    localDisbandedTo.value = '';
    localIncludeEmptyFormed.value = false;
    localIncludeEmptyDisbanded.value = false;
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

<template>
    <Head :title="t('explore_pages.artists.page_title')" />
    <Navbar />
    <main class="flex-1">
        <div class="explore-artists">
            <div class="results-header">
                <h1 class="results-title">{{ t('explore_pages.artists.page_title') }}</h1>
                <div class="filters-container">
                    <div class="search-controls">
                        <div class="search-container">
                            <input
                                type="text"
                                class="searchTerm"
                                :placeholder="t('explore_pages.artists.search_placeholder')"
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

                    <div class="filter-buttons">
                        <button class="filter-button" @click="showGenreModal = true">
                            <i class="fa fa-filter"></i> {{ t('explore_pages.artists.filter_by_genre') }}
                        </button>

                        <button class="filter-button" @click="showYearModal = true">
                            <i class="fa fa-calendar"></i> {{ t('explore_pages.artists.filter_by_year') }}
                        </button>
                    </div>
                </div>

                <div class="sort-controls">
                    <label>{{ t('explore_pages.artists.sort_by') }}:</label>
                    <select v-model="localSortOrder" @change="applySort">
                        <option value="asc">{{ t('explore_pages.artists.sort_asc') }}</option>
                        <option value="desc">{{ t('explore_pages.artists.sort_desc') }}</option>
                    </select>
                </div>

                <div v-if="selectedGenres.length > 0" class="selected-genres">
                    <div class="selected-genres-label">{{ t('explore_pages.artists.selected_genres') }}:</div>
                    <div class="genre-tags">
                        <div v-for="genre in allGenres.filter(g => localSelectedGenres.includes(g.id))"
                             :key="genre.id"
                             class="genre-tag">
                            <span class="genre-tag-content">{{ lowercaseString(genre.name) }}</span>
                            <span class="remove-genre" @click="removeGenre(genre.id)">×</span>
                        </div>
                    </div>
                </div>

                <!-- Kaut kur šeit es uzzināju no skolotāja, ka nav obligāts rasktīt komentārus latviešu valodā -->
                <!-- taču kaut kur kursa sākumā bija teikts otrādi :|. Tagad visi komentāri, protams, angļu valodā. -->
                <!-- Selected year filters display -->
                <div v-if="formedFrom || formedTo || disbandedFrom || disbandedTo || includeEmptyFormed || includeEmptyDisbanded" class="selected-filters">
                    <div class="selected-filters-label">{{ t('explore_pages.artists.year_filters') }}:</div>
                    <div class="filter-tags">
                        <div v-if="formedFrom || formedTo" class="filter-tag">
                            <span class="filter-tag-content">
                                {{ t('explore_pages.artists.formed') }}: {{ formedFrom || t('explore_pages.artists.any') }} - {{ formedTo || t('explore_pages.artists.any') }}
                                <span v-if="includeEmptyFormed" class="tag-note">({{ t('explore_pages.artists.incl_unknown') }})</span>
                            </span>
                            <span class="remove-filter" @click="clearYearFilters">×</span>
                        </div>
                        <div v-if="disbandedFrom || disbandedTo" class="filter-tag">
                            <span class="filter-tag-content">
                                {{ t('explore_pages.artists.disbanded') }}: {{ disbandedFrom || t('explore_pages.artists.any') }} - {{ disbandedTo || t('explore_pages.artists.any') }}
                                <span v-if="includeEmptyDisbanded" class="tag-note">({{ t('explore_pages.artists.incl_unknown') }})</span>
                            </span>
                            <span class="remove-filter" @click="clearYearFilters">×</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Genre Filter Modal -->
            <div v-if="showGenreModal" class="modal-overlay" @click.self="showGenreModal = false">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3>{{ t('explore_pages.artists.filter_by_genre') }}</h3>
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
                        <button class="btn-clear" @click="clearGenres">{{ t('explore_pages.artists.clear_all') }}</button>
                        <button class="btn-apply" @click="applyGenreFilters">{{ t('explore_pages.artists.apply_filters') }}</button>
                    </div>
                </div>
            </div>

            <!-- Year Range Filter Modal -->
            <div v-if="showYearModal" class="modal-overlay" @click.self="showYearModal = false">
                <div class="modal-content year-modal">
                    <div class="modal-header">
                        <h3>{{ t('explore_pages.artists.filter_by_year') }}</h3>
                        <button class="close-modal" @click="showYearModal = false">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="year-range-section">
                            <h4 class="section-subtitle">{{ t('explore_pages.artists.formed_year') }}</h4>
                            <div class="year-inputs">
                                <div class="input-group">
                                    <label>{{ t('explore_pages.artists.from') }}:</label>
                                    <input
                                        type="number"
                                        v-model.number="localFormedFrom"
                                        :placeholder="t('explore_pages.artists.year_placeholder')"
                                        min="1900"
                                        max="2025"
                                        class="year-input"
                                    >
                                </div>
                                <div class="input-group">
                                    <label>{{ t('explore_pages.artists.to') }}:</label>
                                    <input
                                        type="number"
                                        v-model.number="localFormedTo"
                                        :placeholder="t('explore_pages.artists.year_placeholder')"
                                        min="1900"
                                        max="2025"
                                        class="year-input"
                                    >
                                </div>
                            </div>
                            <label class="checkbox-label">
                                <input type="checkbox" v-model="localIncludeEmptyFormed">
                                <span>{{ t('explore_pages.artists.include_empty_formed') }}</span>
                            </label>
                        </div>

                        <div class="year-range-section">
                            <h4 class="section-subtitle">{{ t('explore_pages.artists.disbanded_year') }}</h4>
                            <div class="year-inputs">
                                <div class="input-group">
                                    <label>{{ t('explore_pages.artists.from') }}:</label>
                                    <input
                                        type="number"
                                        v-model.number="localDisbandedFrom"
                                        :placeholder="t('explore_pages.artists.year_placeholder')"
                                        min="1900"
                                        max="2025"
                                        class="year-input"
                                    >
                                </div>
                                <div class="input-group">
                                    <label>{{ t('explore_pages.artists.to') }}:</label>
                                    <input
                                        type="number"
                                        v-model.number="localDisbandedTo"
                                        :placeholder="t('explore_pages.artists.year_placeholder')"
                                        min="1900"
                                        max="2025"
                                        class="year-input"
                                    >
                                </div>
                            </div>
                            <label class="checkbox-label">
                                <input type="checkbox" v-model="localIncludeEmptyDisbanded">
                                <span>{{ t('explore_pages.artists.include_empty_disbanded') }}</span>
                            </label>
                        </div>

                        <div class="year-hint">
                            <i class="fa fa-info-circle"></i>
                            <span>{{ t('explore_pages.artists.year_hint') }}</span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn-clear" @click="clearYearFilters">{{ t('explore_pages.artists.clear_all') }}</button>
                        <button class="btn-apply" @click="applyYearFilters">{{ t('explore_pages.artists.apply_filters') }}</button>
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
                    :track-count-text="(count) => `${count} ${count === 1 ? t('explore_pages.artists.track') : t('explore_pages.artists.tracks')}`"
                />
            </div>

            <div v-if="artists.length === 0" class="no-results">
                {{ t('explore_pages.artists.no_results') }}
                <span v-if="localSearchQuery">{{ t('explore_pages.artists.for') }} "{{ localSearchQuery }}"</span>
                <span v-if="selectedGenres.length > 0"> {{ t('explore_pages.artists.with_selected_genres') }}</span>
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

.filter-buttons {
    display: flex;
    justify-content: center;
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
    margin: 0 1rem;
    transition: background-color 0.2s;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
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

.selected-filters {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    align-items: center;
    margin-top: 1rem;
    justify-content: center;
}

.selected-filters-label {
    font-size: 0.9rem;
    color: #666;
}

.filter-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.filter-tag {
    background: #e8f0fe;
    color: #0c4baa;
    padding: 0.35rem 0.75rem 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.85rem;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}

.filter-tag-content {
    overflow: hidden;
    text-overflow: ellipsis;
}

.tag-note {
    font-size: 0.7rem;
    opacity: 0.8;
    margin-left: 0.25rem;
}

.remove-filter {
    cursor: pointer;
    font-size: 1rem;
    line-height: 1;
    padding: 0 0.1rem;
    border-radius: 50%;
    transition: background-color 0.2s;
}

.remove-filter:hover {
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

.year-modal {
    max-width: 500px;
}

.year-range-section {
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #eee;
}

.year-range-section:last-of-type {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
}

.section-subtitle {
    font-size: 1rem;
    font-weight: 600;
    color: #0c4baa;
    margin: 0 0 0.75rem 0;
}

.year-inputs {
    display: flex;
    gap: 1rem;
    margin-bottom: 0.75rem;
}

.input-group {
    flex: 1;
}

.input-group label {
    display: block;
    font-size: 0.85rem;
    color: #666;
    margin-bottom: 0.25rem;
}

.year-input {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 0.9rem;
}

.year-input:focus {
    outline: none;
    border-color: #0c4baa;
}

.checkbox-label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.85rem;
    color: #666;
    cursor: pointer;
}

.checkbox-label input {
    cursor: pointer;
}

.year-hint {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-top: 1rem;
    padding: 0.75rem;
    background: #f5f5f5;
    border-radius: 4px;
    font-size: 0.8rem;
    color: #666;
}

.year-hint i {
    color: #0c4baa;
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

    .year-inputs {
        flex-direction: column;
        gap: 0.75rem;
    }

    .year-modal {
        max-width: 90%;
    }
}

@media (max-width: 768px) {
    .filter-buttons {
        flex-direction: column;
        gap: 16px;
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

    .genre-item {
        flex: 1 0 calc(50% - 0.75rem); /* 2 items per row on mobile */
    }
}

</style>
