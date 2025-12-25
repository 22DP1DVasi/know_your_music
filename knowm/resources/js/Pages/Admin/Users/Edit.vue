<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm, router } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import {computed, ref, watch } from 'vue';
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import { useI18n } from 'vue-i18n';

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

const { t } = useI18n()

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

/* Daļa priekš modālajam logam */

const isAddRolesModalOpen = ref(false);
const roleSearch = ref('');
const selectedRoleIds = ref([]);

/* pieejamās lomas, kuru lietotājam vēl nav */
const availableRoles = computed(() => {
    const assignedIds = props.user.roles.map(r => r.id);
    return props.allRoles.filter(role => !assignedIds.includes(role.id));
});

/* filtrētas pieejamās lomas, meklēšana */
const filteredRoles = computed(() => {
    if (!roleSearch.value) {
        return availableRoles.value;
    }
    const q = roleSearch.value.toLowerCase();
    return availableRoles.value.filter(role =>
        role.name.toLowerCase().includes(q) ||
        (role.description && role.description.toLowerCase().includes(q))
    );
});

/* atlasītas lomas */
const selectedRoles = computed(() => {
    return availableRoles.value.filter(role =>
        selectedRoleIds.value.includes(role.id)
    );
});

const toggleRoleSelection = (roleId) => {
    if (selectedRoleIds.value.includes(roleId)) {
        selectedRoleIds.value = selectedRoleIds.value.filter(id => id !== roleId);
    } else {
        selectedRoleIds.value.push(roleId);
    }
};

const assignRolesToUser = () => {
    if (!selectedRoleIds.value.length) return;
    router.post(
        route('admin-users-roles-store', { user: props.user.id }),
        {
            roles: selectedRoleIds.value,
        },
        {
            preserveScroll: true,
            onSuccess: () => {
                closeAddRolesModal();
            },
            onError: (errors) => {
                alert(errors.message || 'Failed to assign roles');
            },
        }
    );
};

const openAddRolesModal = () => {
    selectedRoleIds.value = [];
    roleSearch.value = '';
    isAddRolesModalOpen.value = true;
};

const closeAddRolesModal = () => {
    isAddRolesModalOpen.value = false;
};

/*  */

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_users.edit.title') }}</h1>
            <div class="form-actions">
                <button
                    type="button"
                    @click="resetForm"
                    class="btn-secondary"
                >
                    {{ t('adm_users.edit.reset_btn') }}
                </button>
                <button
                    type="submit"
                    class="btn-primary"
                    :disabled="form.processing"
                    @click="submit"
                >
                    {{ t('adm_users.edit.update_user_btn') }}
                </button>
            </div>
            <Link :href="route('admin-users-index')" class="btn-secondary">
                {{ t('adm_users.edit.back_to_users') }}
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name">{{ t('adm_users.edit.username') }}</label>
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
                        <label for="email">{{ t('adm_users.edit.email') }}</label>
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
                        <label for="password">{{ t('adm_users.edit.new_password') }}</label>
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
                        <label for="password_confirmation">{{ t('adm_users.edit.confirm_password') }}</label>
                        <input
                            v-model="form.password_confirmation"
                            id="password_confirmation"
                            type="password"
                            class="input-field"
                        >
                    </div>

                    <div class="form-group">
                        <label for="status">{{ t('adm_users.edit.status') }}</label>
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
                        <div class="roles-header">
                            <label>{{ t('adm_users.edit.roles') }}</label>
                            <button
                                type="button"
                                class="btn-primary btn-sm"
                                @click="openAddRolesModal"
                            >
                                {{ t('adm_users.edit.add_roles') }}
                            </button>
                        </div>

                        <!-- Lomu tabulas konteiners -->
                        <div class="roles-table-container">
                            <!-- Galvenes -->
                            <div class="roles-table-header">
                                <div class="roles-table-row">
                                    <div class="roles-table-cell roles-table-cell-name">
                                        {{ t('adm_users.edit.role_name') }}
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-description">
                                        {{ t('adm_users.edit.role_description') }}
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-added">
                                        {{ t('adm_users.edit.role_assigned_at') }}
                                    </div>
                                    <div class="roles-table-cell roles-table-cell-actions">
                                        {{ t('adm_users.edit.role_actions') }}
                                    </div>
                                </div>
                            </div>

                            <!-- Tabulas saturs -->
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
                                            {{ t('adm_users.edit.delete_role_btn') }}
                                        </button>
                                    </div>
                                </div>

                                <div v-if="!user.roles || user.roles.length === 0" class="roles-table-empty">
                                    {{ t('adm_users.edit.no_roles_assigned') }}
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

        <!-- Modāls logs lomu pievienošanai -->
        <div v-if="isAddRolesModalOpen" class="modal-overlay">
            <div class="modal">
                <div class="modal-header">
                    <h2>{{ t('adm_users.edit.add_roles_header') }}</h2>
                    <button class="modal-close" @click="closeAddRolesModal">×</button>
                </div>

                <div class="modal-body">
                    <!-- Meklēšana -->
                    <input
                        v-model="roleSearch"
                        type="text"
                        :placeholder="t('adm_users.edit.search_roles_placeholder')"
                        class="input-field"
                    />

                    <!-- Atlasītās lomas -->
                    <div v-if="selectedRoles.length" class="selected-roles">
                        <h4>{{ t('adm_users.edit.selected_roles') }}</h4>
                        <div class="selected-roles-list">
                    <span
                        v-for="role in selectedRoles"
                        :key="role.id"
                        class="selected-role-pill"
                        @click="toggleRoleSelection(role.id)"
                    >
                        {{ role.name }} ✕
                    </span>
                        </div>
                    </div>

                    <!-- Pieejamās lomas -->
                    <div class="roles-list">
                        <div
                            v-for="role in filteredRoles"
                            :key="role.id"
                            class="role-item"
                            :class="{ selected: selectedRoleIds.includes(role.id) }"
                            @click="toggleRoleSelection(role.id)"
                        >
                            <div class="role-name">{{ role.name }}</div>
                            <div class="role-description">
                                {{ role.description || 'No description' }}
                            </div>
                        </div>

                        <div v-if="!filteredRoles.length" class="roles-empty">
                            {{ t('adm_users.edit.no_roles_found') }}
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn-secondary" @click="closeAddRolesModal">
                        {{ t('adm_users.edit.modal_cancel') }}
                    </button>
                    <button
                        class="btn-primary"
                        :disabled="!selectedRoleIds.length"
                        @click="assignRolesToUser"
                    >
                        {{ t('adm_users.edit.add_selected_roles') }}
                    </button>
                </div>
            </div>
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

.roles-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.75rem;
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

.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 2000;
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal {
    background: white;
    width: 100%;
    max-width: 600px;
    border-radius: 0.5rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    display: flex;
    flex-direction: column;
    max-height: 90vh;
}

.modal-header,
.modal-footer {
    padding: 1rem;
    border-bottom: 1px solid #e5e7eb;
}

.modal-footer {
    border-top: 1px solid #e5e7eb;
    border-bottom: none;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.modal-body {
    padding: 1rem;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.25rem;
    cursor: pointer;
}

.roles-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.role-item {
    padding: 0.75rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.role-item:hover {
    background-color: #f9fafb;
}

.role-item.selected {
    background-color: #e0f2fe;
    border-color: #38bdf8;
}

.role-name {
    font-weight: 600;
}

.role-description {
    font-size: 0.8125rem;
    color: #6b7280;
}

.selected-roles {
    background-color: #f9fafb;
    padding: 0.75rem;
    border-radius: 0.375rem;
}

.selected-roles-list {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.selected-role-pill {
    background-color: #3b82f6;
    color: white;
    padding: 0.25rem 0.5rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    cursor: pointer;
}

.roles-empty {
    text-align: center;
    font-size: 0.875rem;
    color: #9ca3af;
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
