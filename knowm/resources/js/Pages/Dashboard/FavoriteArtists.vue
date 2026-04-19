<script setup>
import { Head, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import { ref, computed, watch } from 'vue';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import ArtistCardMain from '@/Components/Artists/ArtistCardMain.vue';
import Pagination from '@/Components/Admin/Pagination.vue';
import SearchBarMain from '@/Components/SearchBarMain.vue';
import {route} from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    artists: {
        type: Object,
        required: true,
        default: () => ({
            data: [],
            links: [],
            total: 0,
            current_page: 1,
            last_page: 1,
            from: 0,
            to: 0
        })
    },
    filters: {
        type: Object,
        default: () => ({
            search: '',
            sort: 'asc'
        })
    }
});

// filtru reaktīvais stāvoklis
const searchQuery = ref(props.filters.search || '');
const sortOrder = ref(props.filters.sort || 'asc');

// computed rekvizīts pluralizētam skaitam
const totalCountText = computed(() => {
    const count = props.artists.total || 0;
    if (count === 1) {
        return t('user_pages.favorites.total_count_singular', { count });
    }
    return t('user_pages.favorites.total_count_plural', { count });
});

const redirectToArtist = (slug) => {
    router.get(`/artists/${slug}`);
};

const handleSearch = (query) => {
    searchQuery.value = query;
    applyFilters();
};

const toggleSortOrder = () => {
    sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc';
    applyFilters();
};

const applyFilters = () => {
    router.get(
        route('dashboard.favorites.artists'),
        {
            search: searchQuery.value || null,
            sort: sortOrder.value
        },
        {
            preserveState: true,
            preserveScroll: true,
            replace: true
        }
    );
};

// watch filtra izmaiņas ar debounce
// izmanto kamrēr debounce search nestrādā searchbar komponentā
let searchTimeout;
watch(searchQuery, (newValue) => {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
        applyFilters();
    }, 500);
});

</script>

<template>
    <Head :title="t('user_pages.favorites.favorite_artists_title')" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="page-header">
                {{ t('user_pages.favorites.favorite_artists_title') }}
            </h2>
        </template>

        <div class="favorites-container">
            <!-- Galvene ar skaitu un pogu atpakaļ -->
            <div class="favorites-header">
                <p class="favorites-count">
                    {{ totalCountText }}
                </p>
            </div>

            <!-- Meklēšanas un kārtošanas sadaļa -->
            <div class="filters-section">
                <div class="search-wrapper">
                    <SearchBarMain
                        v-model="searchQuery"
                        :placeholder="t('user_pages.favorites.search_placeholder')"
                        @search="handleSearch"
                    />
                </div>

                <div class="sort-wrapper">
                    <button
                        @click="toggleSortOrder"
                        class="sort-button"
                        :class="{ 'active': sortOrder === 'desc' }"
                        :title="t('user_pages.favorites.sort_tooltip')"
                    >
                        <i class="fa-solid fa-arrow-down-wide-short"></i>
                        <span class="sort-text">
                            {{ sortOrder === 'asc'
                            ? t('user_pages.favorites.sort_asc')
                            : t('user_pages.favorites.sort_desc')
                            }}
                        </span>
                        <i class="fa-solid fa-chevron-down sort-indicator"></i>
                    </button>
                </div>
            </div>

            <!-- Izpildītāju saraksts -->
            <div v-if="artists.data && artists.data.length > 0" class="artists-list">
                <ArtistCardMain
                    v-for="artist in artists.data"
                    :key="artist.id"
                    :artist="artist"
                    :redirect-to="redirectToArtist"
                    :show-track-count="false"
                />
            </div>

            <!-- Ja tukšs -->
            <div v-else class="empty-state">
                <i class="fa-regular fa-heart empty-icon"></i>
                <h3 class="empty-title">
                    {{ searchQuery
                    ? t('user_pages.favorites.no_search_results_title')
                    : t('user_pages.favorites.no_favorites_title')
                    }}
                </h3>
                <p class="empty-description">
                    {{ searchQuery
                    ? t('user_pages.favorites.no_search_results_description', { query: searchQuery })
                    : t('user_pages.favorites.no_favorites_description')
                    }}
                </p>
                <button
                    v-if="!searchQuery"
                    @click="router.get(route('explore.artists'))"
                    class="explore-button"
                >
                    <i class="fa-solid fa-compass"></i>
                    <span>{{ t('user_pages.favorites.explore_artists') }}</span>
                </button>
                <button
                    v-else
                    @click="searchQuery = ''; handleSearch('')"
                    class="explore-button"
                >
                    <i class="fa-solid fa-rotate-left"></i>
                    <span>{{ t('user_pages.favorites.clear_search') }}</span>
                </button>
            </div>

            <div v-if="artists.data && artists.data.length > 0" class="pagination-wrapper">
                <Pagination :links="artists.links" />
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.page-header {
    font-size: 1.5rem;
    font-weight: 600;
    color: #0c4baa;
    margin: 0;
}

.favorites-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
}

.favorites-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.favorites-count {
    font-size: 1rem;
    color: #4b5563;
    margin: 0;
}

/*
kaut kur šajā brīdī uzzināju, ka pēc jaunām tendencēm pieņemts
@media vaicājumus likt uzreiz zem elementa, kuram šis vaicājums tiek rakstīts,
nevis likt visus kopā lapas beigās.
iepriekšējās lapas paliek kā ir vai tiks atjauninātas,
ja būs nepieciešams. :|
 */

@media (prefers-color-scheme: dark) {
    .favorites-count {
        color: #9ca3af;
    }
}

/* Filters Section */
.filters-section {
    display: flex;
    gap: 1rem;
    margin-bottom: 2rem;
    align-items: center;
    flex-wrap: wrap;
}

.search-wrapper {
    flex: 1;
    min-width: 250px;
}

.sort-wrapper {
    flex-shrink: 0;
}

.sort-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.625rem 1rem;
    background: white;
    border: 1px solid rgba(12, 75, 170, 0.2);
    border-radius: 30px;
    color: #4b5563;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s ease;
    white-space: nowrap;
}

.sort-button:hover {
    background: rgba(12, 75, 170, 0.05);
    border-color: #0c4baa;
}

.sort-button.active {
    background: rgba(12, 75, 170, 0.1);
    border-color: #0c4baa;
    color: #0c4baa;
}

.sort-button i:first-child {
    font-size: 1rem;
    color: #0c4baa;
}

.sort-indicator {
    font-size: 0.75rem;
    margin-left: 0.25rem;
    transition: transform 0.2s ease;
}

.sort-button.active .sort-indicator {
    transform: rotate(180deg);
}

.sort-text {
    font-weight: 500;
}

@media (prefers-color-scheme: dark) {
    .sort-button {
        background: #1f2937;
        border-color: #374151;
        color: #9ca3af;
    }

    .sort-button:hover {
        background: #374151;
        border-color: #0c4baa;
    }

    .sort-button.active {
        background: rgba(12, 75, 170, 0.2);
        color: #f3f4f6;
    }
}

.artists-list {
    display: flex;
    flex-wrap: wrap;
    gap: 1.2rem;
    justify-content: flex-start;
    padding: 0 2rem;
}

.empty-state {
    text-align: center;
    padding: 4rem 1rem;
    background: white;
    border-radius: 16px;
    box-shadow: 0 2px 12px rgba(12, 75, 170, 0.08);
    margin: 2rem 0;
}

@media (prefers-color-scheme: dark) {
    .empty-state {
        background: #1f2937;
    }
}

.empty-icon {
    font-size: 4rem;
    color: rgba(12, 75, 170, 0.3);
    margin-bottom: 1rem;
}

.empty-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
    margin: 0 0 0.5rem 0;
}

@media (prefers-color-scheme: dark) {
    .empty-title {
        color: #f3f4f6;
    }
}

.empty-description {
    font-size: 1rem;
    color: #666;
    max-width: 400px;
    margin: 0 auto 1.5rem;
    line-height: 1.5;
}

@media (prefers-color-scheme: dark) {
    .empty-description {
        color: #9ca3af;
    }
}

.explore-button {
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1.5rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border: none;
    border-radius: 30px;
    color: white;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.2);
}

.explore-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(12, 75, 170, 0.3);
}

.explore-button i {
    font-size: 1.1rem;
}

.pagination-wrapper {
    margin-top: 2rem;
    display: flex;
    justify-content: center;
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.artists-list {
    animation: fadeIn 0.4s ease-out;
}

.empty-state {
    animation: fadeIn 0.4s ease-out;
}

/* Responsivitāte */
@media (max-width: 640px) {
    .favorites-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .empty-icon {
        font-size: 3rem;
    }

    .empty-title {
        font-size: 1.1rem;
    }

    .empty-description {
        font-size: 0.9rem;
    }

    .explore-button {
        width: 100%;
        justify-content: center;
        padding: 0.75rem 1rem;
    }
}

/* Mobile optimizations */
@media (max-width: 640px) {
    .filters-section {
        flex-direction: column;
        align-items: stretch;
    }

    .search-wrapper {
        min-width: 100%;
    }

    .sort-wrapper {
        width: 100%;
    }

    .sort-button {
        width: 100%;
        justify-content: center;
    }
}

</style>
