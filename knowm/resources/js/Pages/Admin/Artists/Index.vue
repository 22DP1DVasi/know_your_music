<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import { route } from "ziggy-js";
import { ref, watch, computed } from 'vue';
import { debounce } from 'lodash';

const props = defineProps({
    artists: Object,
    filters: {
        type: Object,
        default: () => ({
            search_name: '',
            filter_type: '',
            filter_status: ''
        })
    }
});

// meklēšanas ievades, inicializēt no props
const searchName = ref(props.filters.search_name || '');
const filterType = ref(props.filters.filter_type || '');
const filterStatus = ref(props.filters.filter_status || '');

// filtru atjaunināšanas funkcija
const updateFilters = () => {
    const filters = {};

    if (searchName.value) {
        filters.search_name = searchName.value;
    }

    if (filterType.value) {
        filters.filter_type = filterType.value;
    }

    if (filterStatus.value !== '') {
        filters.filter_status = filterStatus.value;
    }

    router.get(route('admin-artists-index'), filters, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
        only: ['artists', 'filters']
    });
};

/*
* debounce() ir funkcija, kas aizkavē dotās funkcijas izpildi,
* līdz ir pagājis norādītais gaidīšanas laiks kopš pēdējās izsaukšanas
* */
const debouncedSearchName = debounce(updateFilters, 500);

watch(searchName, (newValue) => {
    if (newValue === '' || newValue.length >= 1) {
        debouncedSearchName();
    }
});

watch(filterType, updateFilters);
watch(filterStatus, updateFilters);

const clearFilters = () => {
    searchName.value = '';
    filterType.value = '';
    filterStatus.value = '';
    updateFilters();
};

const hasActiveFilters = computed(() => {
    return searchName.value || filterType.value || filterStatus.value !== '';
});

const deleteArtist = (id) => {
    if (confirm('Are you sure you want to delete this artist?')) {
        router.delete(route('admin-artists-destroy', { id: id }), {
            onSuccess: () => {
            },
            onError: (errors) => {
                alert(errors.response.data.message || "Could not delete artist");
            },
            preserveScroll: true
        });
    }
};

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>Artist Management</h1>
            <div class="header-actions">
                <Link :href="route('home')" class="btn-secondary">
                    Back to website
                </Link>
                <Link :href="route('admin-artists-create')" class="btn-primary">
                    Add New Artist
                </Link>
            </div>
        </div>

        <div class="filters-container">
            <div class="filters-grid">
                <div class="filter-group">
                    <label for="search-name">Search by Artist Name</label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input
                            id="search-name"
                            v-model="searchName"
                            type="text"
                            placeholder="Type artist name..."
                            class="input-field"
                        />
                        <button
                            v-if="searchName"
                            @click="searchName = ''"
                            class="clear-search-btn"
                            type="button"
                        >
                            ×
                        </button>
                    </div>
                </div>

                <div class="filter-group">
                    <label for="filter-type">Filter by Type</label>
                    <select
                        id="filter-type"
                        v-model="filterType"
                        class="input-field"
                    >
                        <option value="">All Types</option>
                        <option value="solo">Solo</option>
                        <option value="band">Band</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="filter-status">Filter by Status</label>
                    <select
                        id="filter-status"
                        v-model="filterStatus"
                        class="input-field"
                    >
                        <option value="">All Statuses</option>
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </div>

                <div class="filter-group filter-actions">
                    <button
                        v-if="hasActiveFilters"
                        @click="clearFilters"
                        class="btn-clear-filters"
                        type="button"
                    >
                        Clear Filters
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-inner">
                <!-- Galvenes -->
                <div class="artists-header">
                    <div class="id-cell">ID</div>
                    <div class="name-cell">Name</div>
                    <div class="slug-cell" style="font-size: 1em;">Slug</div>
                    <div class="type-cell" style="font-size: 1em;">Type</div>
                    <div class="years-cell">Years Active</div>
                    <div class="status-cell">Status</div>
                    <div class="created-updated-at-header">Created at</div>
                    <div class="created-updated-at-header">Updated at</div>
                    <div class="actions-cell-header">Actions</div>
                </div>

                <!-- Rindas -->
                <div
                    v-for="artist in artists.data"
                    :key="artist.id"
                    class="artists-row"
                >
                    <div class="id-cell">{{ artist.id }}</div>
                    <div class="name-cell">{{ artist.name }}</div>
                    <div class="slug-cell">{{ artist.slug }}</div>
                    <div class="type-cell">{{ artist.solo_or_band || '-' }}</div>
                    <div class="years-cell">
                        <span v-if="artist.formed_year">
                            {{ artist.formed_year }}
                            <span v-if="artist.disbanded_year">- {{ artist.disbanded_year }}</span>
                            <span v-else>- Present</span>
                        </span>
                        <span v-else>-</span>
                    </div>
                    <div class="status-cell">
                        <span :class="artist.is_active ? 'status-active' : 'status-inactive'">
                            {{ artist.is_active ? 'Active' : 'Inactive' }}
                        </span>
                    </div>
                    <div class="created-updated-at-table-data">{{ artist.created_at }}</div>
                    <div class="created-updated-at-table-data">{{ artist.updated_at }}</div>
                    <div class="actions-cell">
                        <Link
                            :href="route('admin-artists-edit', { id: artist.id })"
                            class="btn-edit"
                        >
                            Edit
                        </Link>
                        <button
                            @click="deleteArtist(artist.id)"
                            class="btn-danger"
                        >
                            Delete
                        </button>
                        <Link
                            :href="`/artists/${artist.slug}`"
                            target="_blank"
                            class="btn-view"
                        >
                            View
                        </Link>
                    </div>
                </div>

                <div v-if="artists.data.length === 0" class="no-results">
                    <template v-if="hasActiveFilters">
                        <p>No artists found matching your search criteria.</p>
                        <button @click="clearFilters" class="text-link">
                            Clear filters to see all artists
                        </button>
                    </template>
                    <template v-else>
                        <p>No artists found in the system.</p>
                    </template>
                </div>
            </div>

            <Pagination :links="artists.links" />
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

.artists-header,
.artists-row {
    display: flex;
    align-items: center;
    min-width: 100%;
}

.artists-header {
    background-color: #f3f4f6;
    font-weight: 600;
    color: #374151;
    border-bottom: 2px solid #d1d5db;
}

.artists-row {
    border-bottom: 1px solid #e5e7eb;
}

.artists-row:hover {
    background-color: #f9fafb;
}

.artists-header > div,
.artists-row > div {
    padding: 0.75rem 1.5rem;
    min-width: 0;
    display: flex;
    align-items: center;
}

.id-cell {
    flex: 0 0 50px;
    max-width: 70px;
    font-family: monospace;
    font-size: 0.85rem;
}

.name-cell {
    flex: 2;
    min-width: 150px;
    max-width: 150px;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.slug-header {
    font-size: 1em;
}

.slug-cell {
    flex: 2 0 150px;
    min-width: 150px;
    max-width: 150px;
    font-size: 0.85rem;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.type-cell {
    flex: 0 0 80px;
    max-width: 100px;
    font-size: 0.9rem;
}

.years-cell {
    flex: 0 0 120px;
    max-width: 140px;
    font-size: 0.85rem;
}

.status-cell {
    flex: 0 0 90px;
    max-width: 110px;
}

.created-updated-at-header {
    flex: 0 0 120px;
    max-width: 130px;
    font-size: 0.9rem;
}

.created-updated-at-table-data {
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

.status-active,
.status-inactive {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 0.8rem;
    font-size: 0.75rem;
    font-weight: 500;
    text-transform: capitalize;
}

.status-active {
    background-color: #d1fae5;
    color: #065f46;
}

.status-inactive {
    background-color: #fee2e2;
    color: #991b1b;
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

/* Responsivitāte */
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

    .artists-header > div,
    .artists-row > div {
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
