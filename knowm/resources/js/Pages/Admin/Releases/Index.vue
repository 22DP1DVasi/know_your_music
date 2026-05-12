<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import { route } from "ziggy-js";
import { ref, watch, computed } from 'vue';
import { debounce } from 'lodash';
import { useI18n } from 'vue-i18n';
import dayjs from 'dayjs';

const props = defineProps({
    releases: Object,
    filters: {
        type: Object,
        default: () => ({
            search_title: '',
            filter_type: ''
        })
    }
});

const { t } = useI18n();

// filter reactive state
const searchTitle = ref(props.filters.search_title || '');
const filterType = ref(props.filters.filter_type || '');

const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    return dayjs(dateString).format('DD/MM/YYYY');
};

const updateFilters = () => {
    const filters = {};
    if (searchTitle.value) {
        filters.search_title = searchTitle.value;
    }
    if (filterType.value) {
        filters.filter_type = filterType.value;
    }

    router.get(route('admin-releases-index'), filters, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
        only: ['releases', 'filters']
    });
};

// debounced search
const debouncedSearchTitle = debounce(updateFilters, 500);

watch(searchTitle, (newValue) => {
    if (newValue === '' || newValue.length >= 1) {
        debouncedSearchTitle();
    }
});

watch(filterType, updateFilters);

const clearFilters = () => {
    searchTitle.value = '';
    filterType.value = '';
    updateFilters();
};

const hasActiveFilters = computed(() => {
    return searchTitle.value || filterType.value !== '';
});

const deleteRelease = (id) => {
    if (confirm(t('adm_releases.index.confirm_delete'))) {
        router.delete(route('admin-releases-destroy', { id: id }), {
            onSuccess: () => {},
            onError: (errors) => {
                alert(errors.response?.data?.message || t('adm_releases.index.failed_delete'));
            },
            preserveScroll: true
        });
    }
};

// helper to get artists names as comma separated string
const getArtistNames = (release) => {
    if (!release.artists || release.artists.length === 0) return '-';
    return release.artists.map(artist => artist.name).join(', ');
};

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_releases.index.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('home')" class="btn-secondary">
                    {{ t('adm_releases.index.back_to_website') }}
                </Link>
<!--                <Link :href="route('admin-releases-create')" class="btn-primary">-->
                <Link href="#" class="btn-primary">
                    {{ t('adm_releases.index.add_new_release') }}
                </Link>
            </div>
        </div>

        <div class="filters-container">
            <div class="filters-grid">
                <div class="filter-group">
                    <label for="search-title">{{ t('adm_releases.index.search_title') }}</label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input
                            id="search-title"
                            v-model="searchTitle"
                            type="text"
                            :placeholder="t('adm_releases.index.search_title_placeholder')"
                            class="input-field"
                        />
                        <button
                            v-if="searchTitle"
                            @click="searchTitle = ''"
                            class="clear-search-btn"
                            type="button"
                        >
                            ×
                        </button>
                    </div>
                </div>

                <div class="filter-group">
                    <label for="filter-type">{{ t('adm_releases.index.filter_type') }}</label>
                    <select
                        id="filter-type"
                        v-model="filterType"
                        class="input-field"
                    >
                        <option value="">{{ t('adm_releases.index.filter_all_types') }}</option>
                        <option value="album">{{ t('releases.type.album') }}</option>
                        <option value="ep">{{ t('releases.type.ep') }}</option>
                        <option value="single">{{ t('releases.type.single') }}</option>
                        <option value="compilation">{{ t('releases.type.compilation') }}</option>
                    </select>
                </div>

                <div class="filter-group filter-actions">
                    <button
                        v-if="hasActiveFilters"
                        @click="clearFilters"
                        class="btn-clear-filters"
                        type="button"
                    >
                        {{ t('adm_releases.index.clear_filter_btn') }}
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-inner">
                <!-- Header -->
                <div class="releases-header">
                    <div class="id-cell">ID</div>
                    <div class="title-cell">{{ t('adm_releases.index.header_title') }}</div>
                    <div class="slug-cell">Slug</div>
                    <div class="date-cell">{{ t('adm_releases.index.header_release_date') }}</div>
                    <div class="type-cell">{{ t('adm_releases.index.header_type') }}</div>
                    <div class="artists-cell">{{ t('adm_releases.index.header_artists') }}</div>
                    <div class="created-at-cell">{{ t('adm_releases.index.header_created_at') }}</div>
                    <div class="updated-at-cell">{{ t('adm_releases.index.header_updated_at') }}</div>
                    <div class="actions-cell-header">{{ t('adm_releases.index.header_actions') }}</div>
                </div>

                <!-- Rows -->
                <div
                    v-for="release in releases.data"
                    :key="release.id"
                    class="releases-row"
                >
                    <div class="id-cell">{{ release.id }}</div>
                    <div class="title-cell">{{ release.title }}</div>
                    <div class="slug-cell">{{ release.slug }}</div>
                    <div class="date-cell">{{ formatDate(release.release_date) }}</div>
                    <div class="type-cell">{{ t(`releases.type.${release.release_type}`) }}</div>
                    <div class="artists-cell">{{ getArtistNames(release) }}</div>
                    <div class="created-at-cell">{{ release.created_at }}</div>
                    <div class="updated-at-cell">{{ release.updated_at }}</div>
                    <div class="actions-cell">
                        <Link
                            :href="route('admin-releases-edit', { id: release.id })"
                            class="btn-edit"
                        >
                            {{ t('adm_releases.index.edit_btn') }}
                        </Link>
                        <button
                            @click="deleteRelease(release.id)"
                            class="btn-danger"
                        >
                            {{ t('adm_releases.index.delete_btn') }}
                        </button>
                        <Link
                            :href="`/releases/${release.slug}`"
                            target="_blank"
                            class="btn-view"
                        >
                            {{ t('adm_releases.index.view_btn') }}
                        </Link>
                    </div>
                </div>

                <div v-if="releases.data.length === 0" class="no-results">
                    <template v-if="hasActiveFilters">
                        <p>{{ t('adm_releases.index.search_not_found') }}</p>
                        <button @click="clearFilters" class="text-link">
                            {{ t('adm_releases.index.clear_filters_msg') }}
                        </button>
                    </template>
                    <template v-else>
                        <p>{{ t('adm_releases.index.no_releases_found_sys') }}</p>
                    </template>
                </div>
            </div>

            <Pagination :links="releases.links" />
        </div>
    </AdminLayout>
</template>

<style scoped>
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.header-container h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

.header-actions {
    display: flex;
    gap: 0.75rem;
    align-items: center;
}

.btn-secondary,
.btn-primary,
.btn-edit,
.btn-danger,
.btn-view {
    display: inline-block;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    border: none;
    font-size: 0.875rem;
}

.btn-secondary {
    background-color: #6b7280;
    color: white;
}

.btn-secondary:hover {
    background-color: #4b5563;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
}

.btn-primary:hover {
    background-color: #2563eb;
}

.btn-edit {
    background-color: #10b981;
    color: white;
}

.btn-edit:hover {
    background-color: #059669;
}

.btn-danger {
    background-color: #ef4444;
    color: white;
}

.btn-danger:hover {
    background-color: #dc2626;
}

.btn-view {
    background-color: #8b5cf6;
    color: white;
}

.btn-view:hover {
    background-color: #7c3aed;
}

.filters-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    padding: 1.5rem;
    margin-bottom: 1.5rem;
}

.filters-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 1rem;
}

.filter-group {
    display: flex;
    flex-direction: column;
}

.filter-group label {
    display: block;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.5rem;
    font-size: 0.875rem;
}

.search-input-wrapper {
    position: relative;
}

.search-icon {
    position: absolute;
    left: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    width: 1rem;
    height: 1rem;
    color: #9ca3af;
    pointer-events: none;
}

.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
    padding-left: 2.5rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    color: #374151;
    background-color: white;
    transition: all 0.2s ease-in-out;
    box-sizing: border-box;
}

.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

select.input-field {
    padding-left: 0.75rem;
    appearance: none;
    background-position: right 0.5rem center;
    background-repeat: no-repeat;
    background-size: 1.5em 1.5em;
    padding-right: 2.5rem;
}

.clear-search-btn {
    position: absolute;
    right: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: #9ca3af;
    cursor: pointer;
    font-size: 1.25rem;
    line-height: 1;
    padding: 0;
    width: 1.5rem;
    height: 1.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    transition: all 0.2s;
    opacity: 0;
    pointer-events: none;
}

.clear-search-btn:hover {
    background-color: #e5e7eb;
    color: #374151;
}

.input-field:not(:placeholder-shown) + .clear-search-btn {
    opacity: 1;
    pointer-events: auto;
}

.filter-actions {
    display: flex;
    justify-content: flex-end;
    align-items: flex-end;
}

.btn-clear-filters {
    padding: 0.625rem 1.25rem;
    background-color: #ef4444;
    color: white;
    border: none;
    border-radius: 0.375rem;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
    font-size: 0.875rem;
}

.btn-clear-filters:hover {
    background-color: #dc2626;
}

.table-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    width: clamp(320px, 95vw, 100%);
    margin: 0 auto;
    overflow-x: auto;
}

.table-inner {
    min-width: 1100px;
}

.releases-header,
.releases-row {
    display: flex;
    align-items: center;
    min-width: 100%;
}

.releases-header {
    background-color: #f3f4f6;
    font-weight: 600;
    color: #374151;
    border-bottom: 2px solid #d1d5db;
}

.releases-row {
    border-bottom: 1px solid #e5e7eb;
}

.releases-row:hover {
    background-color: #f9fafb;
}

.releases-header > div,
.releases-row > div {
    padding: 0.75rem 1.5rem;
    min-width: 0;
    display: flex;
    align-items: center;
}

.id-cell {
    flex: 0 0 60px;
    max-width: 70px;
    font-family: monospace;
    font-size: 0.85rem;
}

.title-cell {
    flex: 2;
    min-width: 150px;
    max-width: 200px;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.slug-cell {
    flex: 2 0 150px;
    min-width: 150px;
    max-width: 180px;
    font-size: 0.85rem;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.date-cell {
    flex: 0 0 100px;
    max-width: 110px;
    font-size: 0.85rem;
}

.type-cell {
    flex: 0 0 100px;
    max-width: 120px;
    font-size: 0.9rem;
}

.artists-cell {
    flex: 2;
    min-width: 150px;
    max-width: 200px;
    font-size: 0.85rem;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.created-at-cell,
.updated-at-cell {
    flex: 0 0 120px;
    max-width: 130px;
    font-size: 0.8rem;
}

.actions-cell-header {
    flex: 0 0 200px;
    max-width: 220px;
}

.actions-cell {
    flex: 0 0 200px;
    max-width: 220px;
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.no-results {
    text-align: center;
    padding: 3rem;
    color: #6b7280;
    grid-column: 1 / -1;
}

.text-link {
    background: none;
    border: none;
    color: #3b82f6;
    text-decoration: underline;
    cursor: pointer;
    font-size: inherit;
    padding: 0;
    margin: 0;
}

.text-link:hover {
    color: #2563eb;
}

/* Responsive design */
@media (max-width: 1260px) {
    .table-container {
        width: clamp(320px, 95vw, 1000px);
    }
}

@media (max-width: 1170px) {
    .table-container {
        width: clamp(320px, 95vw, 800px);
    }
}

@media (max-width: 965px) {
    .table-container {
        width: clamp(320px, 95vw, 600px);
    }
}

@media (max-width: 768px) {
    .header-container {
        flex-direction: column;
        align-items: stretch;
    }

    .header-actions {
        flex-direction: column;
        width: 100%;
    }

    .header-actions a,
    .header-actions button {
        width: 100%;
        text-align: center;
    }

    .filters-grid {
        grid-template-columns: 1fr;
    }

    .filter-actions {
        justify-content: flex-start;
    }

    .actions-cell {
        flex-direction: column;
        gap: 0.25rem;
        align-items: center;
    }

    .releases-header > div,
    .releases-row > div {
        padding: 0.5rem 0.75rem;
    }

    .btn-secondary,
    .btn-primary,
    .btn-edit,
    .btn-danger,
    .btn-view {
        padding: 0.375rem 0.75rem;
        font-size: 0.8rem;
    }
}

</style>
