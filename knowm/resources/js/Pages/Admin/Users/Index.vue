<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import { route } from "ziggy-js";
import { ref, watch, computed } from 'vue';
import { debounce } from 'lodash';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    users: Object,
    filters: {
        type: Object,
        default: () => ({
            search_name: '',
            search_email: '',
            filter_status: ''
        })
    },
    statusOptions: {
        type: Array,
        default: () => ['active', 'banned', 'deleted']
    }
});

const { t } = useI18n()
// meklēšanas ievades, inicializēt no props
const searchName = ref(props.filters.search_name || '');
const searchEmail = ref(props.filters.search_email || '');
const filterStatus = ref(props.filters.filter_status || '');

// filtru atjaunināšanas funkcija
const updateFilters = () => {
    const filters = {};
    if (searchName.value) {
        filters.search_name = searchName.value;
    }
    if (searchEmail.value) {
        filters.search_email = searchEmail.value;
    }
    if (filterStatus.value) {
        filters.filter_status = filterStatus.value;
    }
    router.get(route('admin-users-index'), filters, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
        only: ['users', 'filters']
    });
};

/*
* debounce() ir funkcija, kas aizkavē dotās funkcijas izpildi,
* līdz ir pagājis norādītais gaidīšanas laiks kopš pēdējās izsaukšanas
* */
const debouncedSearchName = debounce(updateFilters, 500);
const debouncedSearchEmail = debounce(updateFilters, 500);

// izmaiņu skatīšana un meklēšanas aktivizēšana
watch(searchName, (newValue) => {
    if (newValue === '' || newValue.length >= 1) {
        debouncedSearchName();
    }
});

watch(searchEmail, (newValue) => {
    if (newValue === '' || newValue.length >= 1) {
        debouncedSearchEmail();
    }
});

watch(filterStatus, () => {
    updateFilters();
});

const clearFilters = () => {
    searchName.value = '';
    searchEmail.value = '';
    filterStatus.value = '';
    updateFilters();
};

const hasActiveFilters = computed(() => {
    return searchName.value || searchEmail.value || filterStatus.value;
});

const deleteUser = (id) => {
    if (confirm(t('adm_users.index.confirm_delete'))) {
        router.delete(route('admin-users-destroy', { id: id }), {
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
            <h1>{{ t('adm_users.index.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('home')" class="btn-secondary">
                    {{ t('adm_users.index.back_to_website') }}
                </Link>
                <Link :href="route('admin-users-create')" class="btn-primary">
                    {{ t('adm_users.index.add_new_user') }}
                </Link>
            </div>
        </div>

        <div class="filters-container">
            <div class="filters-grid">
                <div class="filter-group">
                    <label for="search-name">{{ t('adm_users.index.search_username') }}</label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input
                            id="search-name"
                            v-model="searchName"
                            type="text"
                            :placeholder="t('adm_users.index.search_username_placeholder')"
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
                    <label for="search-email">{{ t('adm_users.index.search_email') }}</label>
                    <div class="search-input-wrapper">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input
                            id="search-email"
                            v-model="searchEmail"
                            type="email"
                            :placeholder="t('adm_users.index.search_email_placeholder')"
                            class="input-field"
                        />
                        <button
                            v-if="searchEmail"
                            @click="searchEmail = ''"
                            class="clear-search-btn"
                            type="button"
                        >
                            ×
                        </button>
                    </div>
                </div>

                <div class="filter-group">
                    <label for="filter-status">{{ t('adm_users.index.filter_status') }}</label>
                    <select
                        id="filter-status"
                        v-model="filterStatus"
                        class="input-field"
                    >
                        <option value="">{{ t('adm_users.index.all_statuses') }}</option>
                        <option
                            v-for="status in statusOptions"
                            :key="status"
                            :value="status"
                        >
                            {{ status.charAt(0).toUpperCase() + status.slice(1) }}
                        </option>
                    </select>
                </div>

                <div class="filter-group filter-actions">
                    <button
                        v-if="hasActiveFilters"
                        @click="clearFilters"
                        class="btn-clear-filters"
                        type="button"
                    >
                        {{ t('adm_users.index.clear_filters') }}
                    </button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-inner">
                <!-- Galvenes -->
                <div class="users-header">
                    <div>{{ t('adm_users.index.header_name') }}</div>
                    <div class="email-header">{{ t('adm_users.index.header_email') }}</div>
                    <div>{{ t('adm_users.index.header_status') }}</div>
<!--                    <div>Roles</div>-->
                    <div class="created-updated-at-header">{{ t('adm_users.index.header_created_at') }}</div>
                    <div class="created-updated-at-header">{{ t('adm_users.index.header_updated_at') }}</div>
                    <div>{{ t('adm_users.index.header_actions') }}</div>
                </div>

                <!-- Rindas -->
                <div
                    v-for="user in users.data"
                    :key="user.id"
                    class="users-row"
                >
                    <div>{{ user.name }}</div>
                    <div class="email-cell">{{ user.email }}</div>
                    <div>
                        <span :class="`status-badge status-${user.status}`">
                            {{ user.status }}
                        </span>
                    </div>
                    <!--                    <div class="roles-cell">-->
                    <!--                        <span-->
                    <!--                            v-for="role in user.roles"-->
                    <!--                            :key="role.id"-->
                    <!--                            class="role-pill"-->
                    <!--                        >-->
                    <!--                            {{ role.name }}-->
                    <!--                        </span>-->
                    <!--                    </div>-->
                    <div class="created-updated-at-table-data">
                        {{ user.created_at }}
                    </div>
                    <div class="created-updated-at-table-data">
                        {{ user.updated_at }}
                    </div>
                    <div class="actions-cell">
                        <Link
                            :href="route('admin-users-edit', { id: user.id })"
                            class="btn-edit"
                        >
                            {{ t('adm_users.index.edit_btn') }}
                        </Link>
                        <button
                            @click="deleteUser(user.id)"
                            class="btn-danger"
                        >
                            {{ t('adm_users.index.delete_btn') }}
                        </button>
                    </div>
                </div>

                <div v-if="users.data.length === 0" class="no-results">
                    <template v-if="hasActiveFilters">
                        <p>{{ t('adm_users.index.no_users_found_msg') }}</p>
                        <button @click="clearFilters" class="text-link">{{ t('adm_users.index.clear_filters_msg') }}</button>
                    </template>
                    <template v-else>
                        <p>{{ t('adm_users.index.no_users_found_sys') }}</p>
                    </template>
                </div>
            </div>

            <Pagination :links="users.links" />
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

.status-badge {
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

.status-banned {
    background-color: #fee2e2;
    color: #991b1b;
}

.status-deleted {
    background-color: #e5e7eb;
    color: #374151;
}

.no-results {
    text-align: center;
    padding: 3rem;
    color: #6b7280;
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

.users-header,
.users-row {
    display: flex;
    align-items: center;
    min-width: 100%;
}

.users-header {
    background-color: #f3f4f6;
    font-weight: 600;
    color: #374151;
    border-bottom: 2px solid #d1d5db;
}

.users-row {
    border-bottom: 1px solid #e5e7eb;
}

.users-row:hover {
    background-color: #f9fafb;
}

.users-header > div,
.users-row > div {
    padding: 0.75rem 1.5rem;
    flex: 1;
    min-width: 0;
}

.users-row > div:first-child,
.users-row > div.email-cell {
    white-space: normal;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.users-header > div:nth-child(3),
.users-row > div:nth-child(3) {
    max-width: 90px;
}

.users-header > div:nth-child(6),
.users-row > div:nth-child(6) {
    max-width: 180px;
}

.actions-cell {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.roles-cell {
    display: flex;
    flex-wrap: wrap;
}

.role-pill {
    background-color: #e5e7eb;
    color: #374151;
    font-size: 0.75rem;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
    margin-right: 0.25rem;
    margin-bottom: 0.25rem;
}

.created-updated-at-header {
    font-size: 0.9rem;
    max-width: 130px;
}

.created-updated-at-table-data {
    font-size: 0.8rem;
    max-width: 130px;
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

    /*.email-header,
    .created-updated-at-header,
    .created-updated-at-table-data {
        display: none;
    }*/

    .actions-cell {
        flex-direction: column;
        gap: 0.25rem;
    }

    .users-header > div,
    .users-row > div {
        padding: 0.5rem 0.75rem;
    }

    .btn-secondary,
    .btn-primary,
    .btn-edit,
    .btn-danger {
        padding: 0.375rem 0.75rem;
        font-size: 0.8rem;
    }
}

/*@media (max-width: 480px) {
    .role-pill {
        font-size: 0.7rem;
        padding: 0.125rem 0.375rem;
    }
}*/

</style>
