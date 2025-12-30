<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    role: Object,
});

const form = useForm({
    name: props.role.name,
    description: props.role.description || '',
});

const { t } = useI18n();

const submit = () => {
    form.put(route('admin-roles-update', { id: props.role.id }));
};

const resetForm = () => {
    form.reset();
    form.name = props.role.name;
    form.description = props.role.description || '';
};

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_roles.edit.title') }}</h1>
            <div class="form-actions">
                <button
                    type="button"
                    @click="resetForm"
                    class="btn-secondary"
                >
                    {{ t('adm_roles.edit.reset_btn') }}
                </button>
                <button
                    type="submit"
                    class="btn-primary"
                    :disabled="form.processing"
                    @click="submit"
                >
                    {{ t('adm_roles.edit.update_role_btn') }}
                </button>
            </div>
            <Link :href="route('admin-roles-index')" class="btn-secondary">
                {{ t('adm_roles.edit.back_to_roles') }}
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="name">{{ t('adm_roles.edit.role_name') }}</label>
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
                        <label for="description">{{ t('adm_roles.edit.role_description') }}</label>
                        <textarea
                            v-model="form.description"
                            id="description"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description }"
                            rows="4"
                        ></textarea>
                        <div v-if="form.errors.description" class="error-message">
                            {{ form.errors.description }}
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

.textarea-field {
    resize: vertical;
    min-height: 100px;
    font-family: inherit;
    line-height: 1.5;
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

    .form-actions {
        flex-direction: column;
        width: 100%;
    }

    .form-actions button,
    .form-actions a {
        width: 100%;
        text-align: center;
    }
}

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }
}

</style>
