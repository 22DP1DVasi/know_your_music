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
            <table class="users-table">
                <thead>
                <tr class="table-header">
                    <th>ID</th>
                    <th>Name</th>
                    <th class="email-header">Email</th>
                    <th>Status</th>
                    <th>Roles</th>
                    <th class="created-updated-at-header">Created at</th>
                    <th class="created-updated-at-header">Updated at</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="user in users.data" :key="user.id">
                    <td>{{ user.id }}</td>
                    <td>{{ user.name }}</td>
                    <td>{{ user.email }}</td>
                    <td>{{ user.status }}</td>
                    <td>
                      <span v-for="role in user.roles" :key="role.id" class="role-pill">
                        {{ role.name }}
                      </span>
                    </td>
                    <td class="created-updated-at-table-data">{{ user.created_at }}</td>
                    <td class="created-updated-at-table-data">{{ user.updated_at }}</td>
                    <td class="actions-cell">
                        <Link :href="route('admin-users-edit', { id: user.id })" class="btn-edit">
                            Edit
                        </Link>
                        <button @click="deleteUser(user.id)" class="btn-danger">
                            Delete
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>

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

/* Pogas */
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
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    overflow-x: auto;
}

/* Tabula */
.users-table {
    width: 100%;
    border-collapse: collapse;
}

.users-table th,
.users-table td {
    padding: 0.75rem 1.5rem;
    text-align: left;
    border-bottom: 1px solid #e5e7eb;
}

.created-updated-at-header {
    font-size: 0.9rem;
}

.users-table td {
    vertical-align: middle;
    min-height: 100px;
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

.users-table tbody tr:hover {
    background-color: #f9fafb;
}

.role-pill {
    background-color: #e5e7eb;
    color: #374151;
    font-size: 0.75rem;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
    margin-right: 0.25rem;
    margin-bottom: 0.25rem;
    display: inline-block;
}

.actions-cell {
    display: flex;
    gap: 0.5rem;
    align-items: center;
    justify-content: flex-start;
}

.pagination {
    margin-top: 1rem;
    padding: 0 1.5rem 1.5rem;
}

/* Responsivitāte - izstrādes posmā, horizontālā ritjosla nestrādā */
@media (max-width: 1260px) {
    .table-container {
        overflow-x: auto; /* horizontālā ritjosla */
    }

    .users-table {
        min-width: 1000px;
        overflow-x: auto;
    }
}

@media (max-width: 1024px) {
    .table-container {
        margin: 0 -1rem;
        border-radius: 0;
    }

    .users-table {
        min-width: 900px;
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

    .email-header,
    .created-updated-at-header,
    .created-updated-at-table-data {
        display: none;
    }

    .users-table th:nth-child(3), /* E-pasts */
    .users-table td:nth-child(3), /* E-pasts */
    .users-table th:nth-child(6), /* Izveidots */
    .users-table td:nth-child(6), /* Izveidots */
    .users-table th:nth-child(7), /* Atjaunināts */
    .users-table td:nth-child(7) { /* Atjaunināts */
        display: none;
    }

    .users-table {
        min-width: 600px;
    }

    .actions-cell {
        flex-direction: column;
        gap: 0.25rem;
    }

    .users-table th,
    .users-table td {
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

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }

    .users-table th:nth-child(4), /* Statuss */
    .users-table td:nth-child(4) { /* Statuss */
        display: none;
    }

    .users-table {
        min-width: 500px;
    }

    .role-pill {
        font-size: 0.7rem;
        padding: 0.125rem 0.375rem;
    }
}

</style>
