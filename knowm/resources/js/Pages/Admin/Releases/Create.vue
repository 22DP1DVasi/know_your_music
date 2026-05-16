<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, useForm, Link } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    releaseTypes: {
        type: Array,
        default: () => ['album', 'ep', 'single', 'compilation']
    }
});

const { t } = useI18n();

const form = useForm({
    title: '',
    release_date: '',
    release_type: 'album',
    description: '',
    description_lv: ''
});

const submit = () => {
    form.post(route('admin-releases-store'), {
        preserveScroll: true,
        onSuccess: () => {
            form.reset();
        }
    });
};

const resetForm = () => {
    form.reset();
};

</script>

<template>
    <AdminLayout>
        <Head :title="t('adm_releases.create.title')" />

        <div class="header-container">
            <h1>{{ t('adm_releases.create.title') }}</h1>
            <Link :href="route('admin-releases-index')" class="btn-secondary">
                {{ t('adm_releases.create.back_to_releases') }}
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <!-- Title -->
                    <div class="form-group">
                        <label for="title">{{ t('adm_releases.create.title_label') }} <span class="required">*</span></label>
                        <input
                            v-model="form.title"
                            id="title"
                            type="text"
                            maxlength="255"
                            class="input-field"
                            :class="{ 'input-error': form.errors.title }"
                            :placeholder="t('adm_releases.create.title_placeholder')"
                        >
                        <div v-if="form.errors.title" class="error-message">
                            {{ form.errors.title }}
                        </div>
                        <div class="character-count" :class="{ 'near-limit': form.title.length > 200 }">
                            {{ form.title.length }}/255 {{ t('adm_releases.create.characters') }}
                        </div>
                    </div>

                    <!-- Release Date (date picker) -->
                    <div class="form-group">
                        <label for="release_date">{{ t('adm_releases.create.release_date_label') }} <span class="required">*</span></label>
                        <input
                            v-model="form.release_date"
                            id="release_date"
                            type="date"
                            class="input-field"
                            :class="{ 'input-error': form.errors.release_date }"
                        >
                        <div v-if="form.errors.release_date" class="error-message">
                            {{ form.errors.release_date }}
                        </div>
                        <div class="help-text">{{ t('adm_releases.create.release_date_help') }}</div>
                    </div>

                    <!-- Release Type -->
                    <div class="form-group">
                        <label for="release_type">{{ t('adm_releases.create.release_type_label') }}</label>
                        <select
                            v-model="form.release_type"
                            id="release_type"
                            class="input-field"
                            :class="{ 'input-error': form.errors.release_type }"
                        >
                            <option v-for="type in releaseTypes" :key="type" :value="type">
                                {{ t(`releases.type.${type}`) }}
                            </option>
                        </select>
                        <div v-if="form.errors.release_type" class="error-message">
                            {{ form.errors.release_type }}
                        </div>
                    </div>

                    <!-- Description (English) -->
                    <div class="form-group">
                        <label for="description">{{ t('adm_releases.create.description_en') }}</label>
                        <textarea
                            v-model="form.description"
                            id="description"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description }"
                            :placeholder="t('adm_releases.create.description_placeholder')"
                            rows="6"
                        ></textarea>
                        <div v-if="form.errors.description" class="error-message">
                            {{ form.errors.description }}
                        </div>
                    </div>

                    <!-- Description (Latvian) -->
                    <div class="form-group">
                        <label for="description_lv">{{ t('adm_releases.create.description_lv') }}</label>
                        <textarea
                            v-model="form.description_lv"
                            id="description_lv"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description_lv }"
                            :placeholder="t('adm_releases.create.description_placeholder')"
                            rows="6"
                        ></textarea>
                        <div v-if="form.errors.description_lv" class="error-message">
                            {{ form.errors.description_lv }}
                        </div>
                    </div>

                    <!-- Form actions -->
                    <div class="form-actions">
                        <button
                            type="button"
                            @click="resetForm"
                            class="btn-secondary"
                        >
                            {{ t('adm_releases.create.reset_btn') }}
                        </button>
                        <button
                            type="submit"
                            class="btn-primary"
                            :disabled="form.processing"
                        >
                            {{ t('adm_releases.create.create_release_btn') }}
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

.required {
    color: #ef4444;
}

.help-text {
    color: #6b7280;
    font-size: 0.75rem;
    margin-top: 0.25rem;
    font-style: italic;
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
    min-height: 120px;
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

select.input-field {
    appearance: none;
    background-position: right 0.5rem center;
    background-repeat: no-repeat;
    background-size: 1.5em 1.5em;
    padding-right: 2.5rem;
}

/* make entire date input field clickable */
input[type="date"] {
    position: relative;
    cursor: pointer;
}

input[type="date"]::-webkit-calendar-picker-indicator {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    color: transparent;
    background: transparent;
    cursor: pointer;
    opacity: 0;
}

input[type="date"] {
    cursor: pointer;
}

.character-count {
    color: #6b7280;
    font-size: 0.75rem;
    text-align: right;
    margin-top: 0.25rem;
    transition: color 0.2s ease;
}

.character-count.near-limit {
    color: #f59e0b;
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
    margin-top: 0.5rem;
}

/* Responsive design */
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
