<template>
    <AdminLayout>
        <div class="header-container">
            <h1>Artist Management</h1>
            <Link :href="route('home')" class="btn-secondary">
                Back to website
            </Link>
            <Link :href="route('admin-artists-create')" class="btn-primary">
                Add New Artist
            </Link>
        </div>

        <div class="table-container">
            <table class="artists-table">
                <thead>
                <tr class="table-header">
                    <th>ID</th>
                    <th>Name</th>
                    <th class="slug-header">Slug</th>
                    <th class="type-header">Type</th>
                    <th class="years-header">Years Active</th>
                    <th>Status</th>
                    <th class="bio-header">Biography</th>
                    <th class="created-updated-at-header">Created</th>
                    <th class="created-updated-at-header">Updated</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="artist in artists.data" :key="artist.id">
                    <td>{{ artist.id }}</td>
                    <td>{{ artist.name }}</td>
                    <td class="slug-cell">
                        <span class="slug-text" :title="artist.slug">{{ artist.slug }}</span>
                    </td>
                    <td class="type-data">{{ artist.solo_or_band || '-' }}</td>
                    <td class="years-data">
                        <span v-if="artist.formed_year">
                            {{ artist.formed_year }}
                            <span v-if="artist.disbanded_year">- {{ artist.disbanded_year }}</span>
                            <span v-else>- Present</span>
                        </span>
                        <span v-else>-</span>
                    </td>
                    <td>
                        <span :class="artist.is_active ? 'status-active' : 'status-inactive'">
                            {{ artist.is_active ? 'Active' : 'Inactive' }}
                        </span>
                    </td>
                    <td class="biography-cell">
                        <div class="bio-status">
                            <span class="bio-flag" :title="artist.biography ? 'English biography exists' : 'No English biography'">
                                EN
                                <span :class="artist.biography ? 'bio-check' : 'bio-cross'">
                                    {{ artist.biography ? '✓' : '✗' }}
                                </span>
                            </span>
                            <span class="bio-flag" :title="artist.biography_lv ? 'Latvian biography exists' : 'No Latvian biography'">
                                LV
                                <span :class="artist.biography_lv ? 'bio-check' : 'bio-cross'">
                                    {{ artist.biography_lv ? '✓' : '✗' }}
                                </span>
                            </span>
                        </div>
                    </td>
                    <td class="created-updated-at-table-data">{{ artist.created_at }}</td>
                    <td class="created-updated-at-table-data">{{ artist.updated_at }}</td>
                    <td class="actions-cell">
                        <Link :href="route('admin-artists-edit', { id: artist.id })" class="btn-edit">
                            Edit
                        </Link>
                        <button @click="deleteArtist(artist.id)" class="btn-danger">
                            Delete
                        </button>
                        <Link :href="`/artists/${artist.slug}`" target="_blank" class="btn-view">
                            View
                        </Link>
                    </td>
                </tr>
                </tbody>
            </table>

            <Pagination :links="artists.links" />
        </div>
    </AdminLayout>
</template>

<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";

defineProps({
    artists: Object
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

<style scoped>
/* Header Styles - Same as Users Index */
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.header-container h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

/* Button Styles - Same as Users Index */
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

/* Table Container - Same as Users Index */
.table-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    overflow-x: auto;
}

/* Table Styles */
.artists-table {
    width: 100%;
    border-collapse: collapse;
}

.artists-table th,
.artists-table td {
    padding: 0.75rem 1.5rem;
    text-align: left;
    border-bottom: 1px solid #e5e7eb;
}

.slug-header,
.type-header,
.years-header,
.bio-header,
.created-updated-at-header {
    font-size: 0.9rem;
}

.artists-table td {
    vertical-align: middle;
}

.created-updated-at-table-data {
    font-size: 0.8rem;
}

.table-header {
    background-color: #f3f4f6;
}

.table-header th {
    font-weight: 600;
    color: #374151;
    border-bottom: 2px solid #d1d5db;
}

.artists-table tbody tr:hover {
    background-color: #f9fafb;
}

/* Status Badges */
.status-active,
.status-inactive {
    display: inline-block;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
    font-size: 0.75rem;
    font-weight: 500;
}

.status-active {
    background-color: #d1fae5;
    color: #065f46;
}

.status-inactive {
    background-color: #fee2e2;
    color: #991b1b;
}

/* Actions Cell - Same as Users Index */
.actions-cell {
    display: flex;
    gap: 0.5rem;
    align-items: center;
    justify-content: flex-start;
}

/* Slug Cell */
.slug-cell {
    font-family: monospace;
    font-size: 0.8rem;
    color: #666;
}

.slug-text {
    overflow: hidden;
    text-overflow: ellipsis;
}

/* Biography Status */
.biography-cell {
    min-width: 100px;
}

.bio-status {
    display: flex;
    gap: 1rem;
    justify-content: center;
}

.bio-flag {
    display: flex;
    align-items: center;
    gap: 0.25rem;
    font-size: 0.8rem;
    font-weight: 500;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
    background-color: #f3f4f6;
}

.bio-check {
    color: #10b981;
    font-weight: bold;
}

.bio-cross {
    color: #ef4444;
    font-weight: bold;
}

/* Responsive Design */
@media (max-width: 1260px) {
    .table-container {
        overflow-x: auto;
    }

    .artists-table {
        min-width: 1100px;
    }
}

@media (max-width: 1024px) {
    .table-container {
        margin: 0 -1rem;
        border-radius: 0;
    }

    .artists-table {
        min-width: 1000px;
    }
}

@media (max-width: 768px) {
    .header-container {
        flex-direction: column;
        gap: 1rem;
        align-items: flex-start;
    }

    .header-container h1 {
        font-size: 1.5rem;
    }

    .slug-header,
    .type-header,
    .years-header,
    .bio-header,
    .created-updated-at-header,
    .created-updated-at-table-data {
        display: none;
    }

    .artists-table th:nth-child(3), /* Slug */
    .artists-table td:nth-child(3), /* Slug */
    .artists-table th:nth-child(4), /* Type */
    .artists-table td:nth-child(4), /* Type */
    .artists-table th:nth-child(5), /* Years Active */
    .artists-table td:nth-child(5), /* Years Active */
    .artists-table th:nth-child(7), /* Biography */
    .artists-table td:nth-child(7), /* Biography */
    .artists-table th:nth-child(8), /* Created at */
    .artists-table td:nth-child(8), /* Created at */
    .artists-table th:nth-child(9), /* Updated at */
    .artists-table td:nth-child(9) { /* Updated at */
        display: none;
    }

    .artists-table {
        min-width: 600px;
    }

    .actions-cell {
        flex-direction: column;
        gap: 0.25rem;
    }

    .artists-table th,
    .artists-table td {
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

    .bio-status {
        flex-direction: column;
        gap: 0.25rem;
    }
}

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }

    .artists-table {
        min-width: 500px;
    }
}

</style>
