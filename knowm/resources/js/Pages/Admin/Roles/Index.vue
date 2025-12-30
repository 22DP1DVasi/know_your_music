<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import { route } from "ziggy-js";
import { ref, watch, computed } from 'vue';
import { debounce } from 'lodash';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    roles: Object,
    filters: {
        type: Object,
        default: () => ({
            search_name: '',
            search_description: '',
            sort_order: 'asc'
        })
    }
});

const { t } = useI18n();

// meklēšanas ievades, inicializēt no props
const searchName = ref(props.filters.search_name || '');
const searchDescription = ref(props.filters.search_description || '');
const sortOrder = ref(props.filters.sort_order || 'asc');

// filtru atjaunināšanas funkcija
const updateFilters = () => {
    const filters = {};
    if (searchName.value) {
        filters.search_name = searchName.value;
    }
    if (searchDescription.value) {
        filters.search_description = searchDescription.value;
    }
    if (sortOrder.value) {
        filters.sort_order = sortOrder.value;
    }
    router.get(route('admin-roles-index'), filters, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
        only: ['roles', 'filters']
    });
};

/*
* debounce() ir funkcija, kas aizkavē dotās funkcijas izpildi,
* līdz ir pagājis norādītais gaidīšanas laiks kopš pēdējās izsaukšanas
* */
const debouncedSearchName = debounce(updateFilters, 500);
const debouncedSearchDescription = debounce(updateFilters, 500);

// izmaiņu skatīšana un meklēšanas aktivizēšana
watch(searchName, (newValue) => {
    if (newValue === '' || newValue.length >= 1) {
        debouncedSearchName();
    }
});

watch(searchDescription, (newValue) => {
    if (newValue === '' || newValue.length >= 1) {
        debouncedSearchDescription();
    }
});

watch(sortOrder, () => {
    updateFilters();
});

const clearFilters = () => {
    searchName.value = '';
    searchDescription.value = '';
    sortOrder.value = 'asc';
    updateFilters();
};

const hasActiveFilters = computed(() => {
    return searchName.value || searchDescription.value || sortOrder.value !== 'asc';
});

const deleteRole = (id) => {
    if (confirm('Are you sure you want to delete this role?')) {
        router.delete(route('admin-roles-destroy', { id: id }), {
            onSuccess: () => {
            },
            onError: (errors) => {
                alert(errors.response.data.message || "");
            },
            preserveScroll: true
        });
    }
};

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_roles.index.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('home')" class="btn-secondary">
                    {{ t('adm_roles.index.back_to_website') }}
                </Link>
                <Link :href="route('admin-roles-create')" class="btn-primary">
                    {{ t('adm_roles.index.add_new_role') }}
                </Link>
            </div>
        </div>

        <div class="filters-container">
            <div class="filters-grid">
                <!-- Meklēt pēc lomas nosaukuma -->
                <div class="filter-group">
                    <label for="search-name">{{ t('adm_roles.index.search_name') }}</label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input
                            id="search-name"
                            v-model="searchName"
                            type="text"
                            :placeholder="t('adm_roles.index.search_name_placeholder')"
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

                <!-- Meklēt pēc apraksta -->
                <div class="filter-group">
                    <label for="search-description">{{ t('adm_roles.index.search_description') }}</label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input
                            id="search-description"
                            v-model="searchDescription"
                            type="text"
                            :placeholder="t('adm_roles.index.search_description_placeholder')"
                            class="input-field"
                        />
                        <button
                            v-if="searchDescription"
                            @click="searchDescription = ''"
                            class="clear-search-btn"
                            type="button"
                        >
                            ×
                        </button>
                    </div>
                </div>

                <!-- Kārtošanas secība -->
                <div class="filter-group">
                    <label for="sort-order">{{ t('adm_roles.index.sort_order') }}</label>
                    <select
                        id="sort-order"
                        v-model="sortOrder"
                        class="input-field"
                    >
                        <option value="asc">{{ t('adm_roles.index.sort_ascending') }}</option>
                        <option value="desc">{{ t('adm_roles.index.sort_descending') }}</option>
                    </select>
                </div>

                <div class="filter-group filter-actions">
                    <button
                        v-if="hasActiveFilters"
                        @click="clearFilters"
                        class="btn-clear-filters"
                        type="button"
                    >
                        {{ t('adm_roles.index.clear_filters') }}
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-inner">
                <!-- Galvenes -->
                <div class="roles-header">
                    <div class="name-cell">{{ t('adm_roles.index.header_name') }}</div>
                    <div class="description-cell">{{ t('adm_roles.index.header_description') }}</div>
                    <div class="created-at-cell">{{ t('adm_roles.index.header_created_at') }}</div>
                    <div class="updated-at-cell">{{ t('adm_roles.index.header_updated_at') }}</div>
                    <div class="actions-cell-header">{{ t('adm_roles.index.header_actions') }}</div>
                </div>

                <!-- Rindas -->
                <div
                    v-for="role in roles.data"
                    :key="role.id"
                    class="roles-row"
                >
                    <div class="name-cell">
                        <span class="role-name">{{ role.name }}</span>
                    </div>
                    <div class="description-cell">
                        <span class="role-description">{{ role.description || '-' }}</span>
                    </div>
                    <div class="created-at-cell">
                        {{ role.created_at }}
                    </div>
                    <div class="updated-at-cell">
                        {{ role.updated_at }}
                    </div>
                    <div class="actions-cell">
                        <Link
                            :href="route('admin-roles-edit', { id: role.id })"
                            class="btn-edit"
                        >
                            {{ t('adm_roles.index.edit_btn') }}
                        </Link>
                        <button
                            @click="deleteRole(role.id)"
                            class="btn-danger"
                        >
                            {{ t('adm_roles.index.delete_btn') }}
                        </button>
                    </div>
                </div>

                <!-- "Nav rezultātu" ziņojums -->
                <div v-if="roles.data.length === 0" class="no-results">
                    <template v-if="hasActiveFilters">
                        <p>{{ t('adm_roles.index.no_roles_found_msg') }}</p>
                        <button @click="clearFilters" class="text-link">{{ t('adm_roles.index.clear_filters_msg') }}</button>
                    </template>
                    <template v-else>
                        <p>{{ t('adm_roles.index.no_roles_found_sys') }}</p>
                    </template>
                </div>
            </div>

            <Pagination :links="roles.links" />
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
.btn-danger {
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
}

.clear-search-btn:hover {
    background-color: #e5e7eb;
    color: #374151;
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

.roles-header,
.roles-row {
    display: flex;
    align-items: center;
    min-width: 100%;
}

.roles-header {
    background-color: #f3f4f6;
    font-weight: 600;
    color: #374151;
    border-bottom: 2px solid #d1d5db;
}

.roles-row {
    border-bottom: 1px solid #e5e7eb;
}

.roles-row:hover {
    background-color: #f9fafb;
}

.roles-header > div,
.roles-row > div {
    padding: 0.75rem 1.5rem;
    min-width: 0;
    display: flex;
    align-items: center;
}

.name-cell {
    flex: 2;
    min-width: 180px;
    max-width: 250px;
    font-weight: 500;
    color: #1f2937;
}

.description-cell {
    flex: 3;
    min-width: 250px;
    max-width: 400px;
    line-height: 1.4;
}

.role-description {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}

.created-at-cell,
.updated-at-cell {
    flex: 1;
    min-width: 120px;
    max-width: 140px;
    font-size: 0.85rem;
}

.actions-cell-header {
    flex: 0 0 160px;
    max-width: 180px;
}

.actions-cell {
    flex: 0 0 160px;
    max-width: 180px;
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
