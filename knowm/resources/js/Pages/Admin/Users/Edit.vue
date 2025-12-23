<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';

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
    roles: props.user.roles || []
});

const submit = () => {
    form.put(route('admin-users-update', {id: props.user.id}));
};

const resetForm = () => {
    form.reset();
    form.name = props.user.name;
    form.email = props.user.email;
    form.status = props.user.status;
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
                        <div class="roles-grid">
                            <div v-for="role in allRoles" :key="role.id" class="role-item">
                                <input
                                    type="checkbox"
                                    :id="'role_' + role.id"
                                    :value="role.id"
                                    v-model="form.roles"
                                    class="role-checkbox"
                                >
                                <label :for="'role_' + role.id">{{ role.name }}</label>
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
.btn-secondary {
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

.roles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    gap: 0.75rem;
    margin-top: 0.5rem;
}

.role-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem;
    background-color: #f9fafb;
    border-radius: 0.375rem;
    border: 1px solid #e5e7eb;
}

.role-checkbox {
    margin: 0;
    width: 1rem;
    height: 1rem;
    border-radius: 0.25rem;
    border: 1px solid #d1d5db;
    cursor: pointer;
}

.role-item label {
    margin: 0;
    cursor: pointer;
    font-weight: normal;
    color: #374151;
}

.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;

}

/* Responsivitāte */
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

    .roles-grid {
        grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
        gap: 0.5rem;
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

    .roles-grid {
        grid-template-columns: 1fr;
    }
}

</style>
