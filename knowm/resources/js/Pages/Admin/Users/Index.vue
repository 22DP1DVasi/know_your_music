<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import {route} from "ziggy-js";

defineProps({
    users: Object
});

const deleteUser = (id) => {
    if (confirm('Are you sure you want to delete this user?')) {
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
            <h1>User Management</h1>
            <Link :href="route('home')" class="btn-secondary">
                Back to website
            </Link>
            <Link :href="route('admin-users-create')" class="btn-primary">
                Add New User
            </Link>
        </div>

        <div class="table-container">
            <div class="table-inner">
                <!-- Galvenes -->
                <div class="users-header">
                    <div>Name</div>
                    <div class="email-header">Email</div>
                    <div>Status</div>
<!--                    <div>Roles</div>-->
                    <div class="created-updated-at-header">Created at</div>
                    <div class="created-updated-at-header">Updated at</div>
                    <div>Actions</div>
                </div>

                <!-- Rindas -->
                <div
                    v-for="user in users.data"
                    :key="user.id"
                    class="users-row"
                >
                    <div>{{ user.name }}</div>
                    <div class="email-header">{{ user.email }}</div>
                    <div>{{ user.status }}</div>
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
                            Edit
                        </Link>
                        <button
                            @click="deleteUser(user.id)"
                            class="btn-danger"
                        >
                            Delete
                        </button>
                    </div>
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
}

.header-container h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
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
.users-row > div.email-header {
    white-space: normal;
    overflow-wrap: anywhere;
    word-break: break-word;
}

.email-header {
    overflow-wrap: anywhere;
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
        gap: 1rem;
        align-items: flex-start;
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
