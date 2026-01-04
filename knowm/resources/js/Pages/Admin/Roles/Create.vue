<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';
import {route} from "ziggy-js";
import { useI18n } from 'vue-i18n';

const form = useForm({
    name: '',
    description: ''
});

const submit = () => {
    form.post(route('admin-roles-store'));
};

const resetForm = () => {
    form.reset();
};

const { t } = useI18n()

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_roles.create.title') }}</h1>
            <Link :href="route('admin-roles-index')" class="btn-secondary">
                {{ t('adm_roles.create.back_to_roles') }}
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <!-- Role Name Field -->
                    <div class="form-group">
                        <label for="name">{{ t('adm_roles.create.role_name') }}</label>
                        <input
                            v-model="form.name"
                            id="name"
                            type="text"
                            maxlength="80"
                            class="input-field"
                            :class="{ 'input-error': form.errors.name }"
                            :placeholder="t('adm_roles.create.role_name_placeholder')"
                        >
                        <div v-if="form.errors.name" class="error-message">
                            {{ form.errors.name }}
                        </div>
                        <div class="character-count">
                            {{ form.name.length }}/80 {{ t('adm_roles.create.characters') }}
                        </div>
                    </div>

                    <!-- Role Description Field -->
                    <div class="form-group">
                        <label for="description">{{ t('adm_roles.create.role_description') }}</label>
                        <textarea
                            v-model="form.description"
                            id="description"
                            maxlength="255"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description }"
                            :placeholder="t('adm_roles.create.role_description_placeholder')"
                            rows="4"
                        ></textarea>
                        <div v-if="form.errors.description" class="error-message">
                            {{ form.errors.description }}
                        </div>
                        <div class="character-count">
                            {{ form.description.length }}/255 {{ t('adm_roles.create.characters') }}
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button
                            type="button"
                            @click="resetForm"
                            class="btn-secondary"
                        >
                            {{ t('adm_roles.create.reset_btn') }}
                        </button>
                        <button
                            type="submit"
                            class="btn-primary"
                            :disabled="form.processing"
                        >
                            {{ t('adm_roles.create.create_role_btn') }}
                        </button>
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
    max-width: 800px;
    margin: 0 auto;
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

.character-count {
    color: #6b7280;
    font-size: 0.75rem;
    text-align: right;
    margin-top: 0.25rem;
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

.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
    margin-top: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #e5e7eb;
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
