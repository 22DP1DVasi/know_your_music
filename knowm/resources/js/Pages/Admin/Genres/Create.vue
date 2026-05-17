<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, useForm, Link } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

// current year for year options
const currentYear = new Date().getFullYear();
const yearOptions = Array.from({ length: currentYear + 10 - 1900 + 1 }, (_, i) => 1900 + i).reverse();

const form = useForm({
    name: '',
    origin_year: '',
    origin_country: '',
    description: '',
    description_lv: ''
});

// limit input length
const limitInput = (field, maxLength) => {
    if (form[field].length > maxLength) {
        form[field] = form[field].substring(0, maxLength);
    }
};

watch(() => form.name, () => limitInput('name', 100));
watch(() => form.origin_country, () => limitInput('origin_country', 100));

const submit = () => {
    form.post(route('admin-genres-store'), {
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
        <Head :title="t('adm_genres.create.title')" />

        <div class="header-container">
            <h1>{{ t('adm_genres.create.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('admin-genres-index')" class="btn-secondary">
                    {{ t('adm_genres.create.back_to_genres') }}
                </Link>
            </div>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <!-- Name -->
                    <div class="form-group">
                        <label for="name">{{ t('adm_genres.create.name_label') }} <span class="required">*</span></label>
                        <input
                            v-model="form.name"
                            id="name"
                            type="text"
                            maxlength="100"
                            class="input-field"
                            :class="{ 'input-error': form.errors.name }"
                            :placeholder="t('adm_genres.create.name_placeholder')"
                        />
                        <div v-if="form.errors.name" class="error-message">
                            {{ form.errors.name }}
                        </div>
                        <div class="character-count" :class="{ 'near-limit': form.name.length > 80 }">
                            {{ form.name.length }}/100 {{ t('adm_genres.create.characters') }}
                        </div>
                    </div>

                    <div class="form-row">
                        <!-- Origin Year -->
                        <div class="form-group">
                            <label for="origin_year">{{ t('adm_genres.create.origin_year_label') }}</label>
                            <select
                                v-model="form.origin_year"
                                id="origin_year"
                                class="input-field"
                                :class="{ 'input-error': form.errors.origin_year }"
                            >
                                <option value="">{{ t('adm_genres.create.select_year') }}</option>
                                <option v-for="year in yearOptions" :key="year" :value="year">
                                    {{ year }}
                                </option>
                            </select>
                            <div v-if="form.errors.origin_year" class="error-message">{{ form.errors.origin_year }}</div>
                        </div>

                        <!-- Origin Country -->
                        <div class="form-group">
                            <label for="origin_country">{{ t('adm_genres.create.origin_country_label') }}</label>
                            <input
                                v-model="form.origin_country"
                                id="origin_country"
                                type="text"
                                maxlength="100"
                                class="input-field"
                                :class="{ 'input-error': form.errors.origin_country }"
                                :placeholder="t('adm_genres.create.origin_country_placeholder')"
                            />
                            <div v-if="form.errors.origin_country" class="error-message">{{ form.errors.origin_country }}</div>
                            <div class="character-count">{{ form.origin_country.length }}/100 {{ t('adm_genres.create.characters') }}</div>
                        </div>
                    </div>

                    <!-- Description (English) -->
                    <div class="form-group">
                        <label for="description">{{ t('adm_genres.create.description_en') }}</label>
                        <textarea
                            v-model="form.description"
                            id="description"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description }"
                            :placeholder="t('adm_genres.create.description_placeholder')"
                            rows="6"
                        ></textarea>
                        <div v-if="form.errors.description" class="error-message">
                            {{ form.errors.description }}
                        </div>
                    </div>

                    <!-- Description (Latvian) -->
                    <div class="form-group">
                        <label for="description_lv">{{ t('adm_genres.create.description_lv') }}</label>
                        <textarea
                            v-model="form.description_lv"
                            id="description_lv"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description_lv }"
                            :placeholder="t('adm_genres.create.description_placeholder')"
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
                            {{ t('adm_genres.create.reset_btn') }}
                        </button>
                        <button
                            type="submit"
                            class="btn-primary"
                            :disabled="form.processing"
                        >
                            {{ t('adm_genres.create.create_genre_btn') }}
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
.btn-primary {
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

.btn-primary:hover:not(:disabled) {
    background-color: #2563eb;
}

.btn-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.form-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
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
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

.input-field.input-error {
    border-color: #ef4444;
}

.input-field.input-error:focus {
    border-color: #ef4444;
    box-shadow: 0 0 0 3px rgba(239,68,68,0.1);
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

.form-row {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.form-row .form-group {
    flex: 1;
}

.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
    margin-top: 0.5rem;
}

/* Responsive */
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

    .form-row {
        flex-direction: column;
        gap: 0;
    }
}

</style>
