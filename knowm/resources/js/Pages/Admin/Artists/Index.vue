<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import { route } from "ziggy-js";

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
                    <p>No artists found in the system.</p>
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
