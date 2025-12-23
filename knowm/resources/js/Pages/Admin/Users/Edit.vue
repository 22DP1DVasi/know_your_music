<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm, router } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';

dayjs.extend(utc);

const props = defineProps({
    user: Object,
    statusOptions: Array,
    allRoles: Array
});

const form = useForm({
    name: props.user.name,
    email: props.user.email,
    password: '',
    password_confirmation: '',
    status: props.user.status,
    roles: props.user.roles.map(r => r.id)
});

const submit = () => {
    form.put(route('admin-users-update', {id: props.user.id}));
};

const resetForm = () => {
    form.reset();
    form.name = props.user.name;
    form.email = props.user.email;
    form.status = props.user.status;
    form.roles = props.user.roles.map(r => r.id);
};

const formatDateTimeUTC = (dateString) => {
    if (!dateString) return 'Unknown';
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

const deleteUserRole = (userId, roleId) => {
    if (!confirm('Are you sure you want to remove this role from the user?')) {
        return;
    }
    router.delete(route('admin-users-roles-destroy', { user: userId, role: roleId }), {
        onSuccess: () => {
        },
        onError: (errors) => {
            alert(errors.response?.data?.message || 'An error occurred');
        },
        preserveScroll: true,
    });
};

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>Edit User</h1>
            <div class="form-actions">
                <button
                    type="button"
                    @click="resetForm"
                    class="btn-secondary"
                >
                    Reset
                </button>
                <button
                    type="submit"
                    class="btn-primary"
                    :disabled="form.processing"
                    @click="submit"
                >
                    Update User
                </button>
            </div>
            <Link :href="route('admin-users-index')" class="btn-secondary">
                Back to Users
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name">Username</label>
                        <input
                            v-model="form.name"
                            id="name"
                            type="text"
                            class="input-field"
                            :class="{ 'input-error': form.errors.name }"
                        >
                        <div v-if="form.errors.name" class="error-message">
                            {{ form.errors.name }}
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input
                            v-model="form.email"
                            id="email"
                            type="email"
                            class="input-field"
                            :class="{ 'input-error': form.errors.email }"
                        >
                        <div v-if="form.errors.email" class="error-message">
                            {{ form.errors.email }}
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">New Password (leave blank to keep current)</label>
                        <input
                            v-model="form.password"
                            id="password"
                            type="password"
                            class="input-field"
                            :class="{ 'input-error': form.errors.password }"
                        >
                        <div v-if="form.errors.password" class="error-message">
                            {{ form.errors.password }}
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password_confirmation">Confirm New Password</label>
                        <input
                            v-model="form.password_confirmation"
                            id="password_confirmation"
                            type="password"
                            class="input-field"
                        >
                    </div>

                    <div class="form-group">
                        <label for="status">Status</label>
                        <select
                            v-model="form.status"
                            id="status"
                            class="input-field"
                            :class="{ 'input-error': form.errors.status }"
                        >
                            <option v-for="option in statusOptions" :value="option" :key="option">
                                {{ option }}
                            </option>
                        </select>
                        <div v-if="form.errors.status" class="error-message">
                            {{ form.errors.status }}
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Roles</label>

                        <!-- Roles Table Container -->
                        <div class="roles-table-container">
                            <!-- Table Header -->
                            <div class="roles-table-header">
                                <div class="roles-table-row">
                                    <div class="roles-table-cell roles-table-cell-name">
                                        Name
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-description">
                                        Description
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-added">
                                        Assigned At
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-actions">
                                        Actions
                                    </div>
                                </div>
                            </div>

                            <!-- Table Body -->
                            <div class="roles-table-body">
                                <div
                                    v-for="role in user.roles"
                                    :key="role.id"
                                    class="roles-table-row role-assigned"
                                >
                                    <div class="roles-table-cell roles-table-cell-name">
                                        {{ role.name }}
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-description">
                                        {{ role.description || 'No description' }}
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-added">
                                        {{ formatDateTimeUTC(role.assigned_at) }}
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-actions">
                                        <button
                                            type="button"
                                            class="btn-danger"
                                            @click="deleteUserRole(props.user.id, role.id)"
                                        >
                                            Delete
                                        </button>
                                    </div>
                                </div>

                                <div v-if="!user.roles || user.roles.length === 0" class="roles-table-empty">
                                    No roles assigned to this user
                                </div>
                            </div>
                        </div>

                        <div v-if="form.errors.roles" class="error-message">
                            {{ form.errors.roles }}
                        </div>
                    </div>
                </div>
            </form>
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

.form-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    padding: 1.5rem;
}

.form-grid {
    display: grid;
    gap: 1.5rem;
}

.form-group {
    margin-bottom: 0;
}

.form-group label {
    display: block;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.375rem;
    font-size: 0.875rem;
}

.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
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

.input-field.input-error {
    border-color: #ef4444;
}

.input-field.input-error:focus {
    border-color: #ef4444;
    box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}

select.input-field {
    appearance: none;
    background-position: right 0.5rem center;
    background-repeat: no-repeat;
    background-size: 1.5em 1.5em;
    padding-right: 2.5rem;
}

.error-message {
    color: #ef4444;
    font-size: 0.75rem;
    margin-top: 0.25rem;
}

.btn-primary,
.btn-secondary,
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

.btn-primary {
    background-color: #3b82f6;
    color: white;
}

.btn-primary:hover:not(:disabled) {
    background-color: #2563eb;
}

.btn-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.btn-secondary {
    background-color: #6b7280;
    color: white;
}

.btn-secondary:hover {
    background-color: #4b5563;
}

.btn-danger {
    background-color: #ef4444;
    color: white;
}

.btn-danger:hover {
    background-color: #dc2626;
}

.roles-table-container {
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    overflow: hidden;
    margin-top: 0.5rem;
    background-color: white;
}

.roles-table-header {
    background-color: #f9fafb;
    border-bottom: 1px solid #e5e7eb;
}

.roles-table-body {
    max-height: 400px;
    overflow-y: auto;
}

.roles-table-row {
    display: flex;
    align-items: center;
    min-height: 3rem;
    border-bottom: 1px solid #f3f4f6;
    transition: background-color 0.2s ease;
}

.roles-table-row:last-child {
    border-bottom: none;
}

.roles-table-row:hover {
    background-color: #f9fafb;
}

.roles-table-row.role-assigned {
    background-color: #f0f9ff;
}

.roles-table-row.role-assigned:hover {
    background-color: #e0f2fe;
}

.roles-table-cell {
    padding: 0.75rem 1rem;
    font-size: 0.875rem;
    color: #374151;
    display: flex;
    align-items: center;
    min-height: 3rem;
    flex: 1;
    overflow: hidden;
}

.roles-table-cell-name {
    font-weight: 500;
    color: #1f2937;
    min-width: 150px;
    max-width: 200px;
    flex: 1.5;
}

.roles-table-cell-description {
    white-space: normal;
    word-break: break-word;
    flex: 3;
    min-width: 250px;
    max-width: 500px;
}

.roles-table-cell-added {
    font-size: 0.8125rem;
    min-width: 120px;
    max-width: 150px;
    flex: 1.5;
}

.roles-table-cell-actions {
    min-width: 120px;
    max-width: 140px;
    flex: 1;
}

.roles-table-empty {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
    color: #9ca3af;
    font-style: italic;
    font-size: 0.875rem;
}

.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
}

/* Responsivitāte */
@media (max-width: 1024px) {
    .roles-table-cell-name {
        min-width: 120px;
        max-width: 160px;
    }

    .roles-table-cell-description {
        min-width: 200px;
    }

    .roles-table-cell-added {
        min-width: 100px;
        max-width: 130px;
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

    .form-container {
        padding: 1rem;
        margin: 0 -1rem;
        border-radius: 0;
    }

    .roles-table-row {
        flex-direction: column;
        align-items: flex-start;
        padding: 1rem;
        gap: 0.5rem;
    }

    .roles-table-cell {
        padding: 0.25rem 0;
        border-bottom: 1px solid #f3f4f6;
        min-height: auto;
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        flex: none;
        justify-content: flex-start;
    }

    .roles-table-cell:last-child {
        border-bottom: none;
    }

    .roles-table-cell-name {
        font-weight: 600;
        order: 1;
    }

    .roles-table-cell-description {
        color: #4b5563;
        order: 2;
    }

    .roles-table-cell-added {
        font-size: 0.75rem;
        color: #9ca3af;
        order: 3;
        justify-content: flex-start;
    }

    .roles-table-cell-actions {
        order: 4;
        justify-content: flex-start;
    }

    .form-actions {
        flex-direction: column;
    }

    .form-actions button {
        width: 100%;
    }
}

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }
}

</style>
