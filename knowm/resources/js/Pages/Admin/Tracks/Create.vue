<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, useForm, Link } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const form = useForm({
    title: '',
    release_date: '',
    duration: '',
    description: '',
    description_lv: ''
});

// duration fields
const durationHours = ref('');
const durationMinutes = ref('');
const durationSeconds = ref('');

// combine hours, minutes, seconds into HH:MM:SS string for form data
const updateDurationString = () => {
    const hours = durationHours.value ? String(durationHours.value).padStart(2, '0') : '00';
    const minutes = durationMinutes.value ? String(durationMinutes.value).padStart(2, '0') : '00';
    const seconds = durationSeconds.value ? String(durationSeconds.value).padStart(2, '0') : '00';
    if (hours === '00' && minutes === '00' && seconds === '00') {
        form.duration = '';
    } else {
        form.duration = `${hours}:${minutes}:${seconds}`;
    }
};

watch([durationHours, durationMinutes, durationSeconds], () => {
    updateDurationString();
});

const submit = () => {
    form.post(route('admin-tracks-store'), {
        preserveScroll: true,
        onSuccess: () => {
            form.reset();
            durationHours.value = '';
            durationMinutes.value = '';
            durationSeconds.value = '';
        }
    });
};

const resetForm = () => {
    form.reset();
    durationHours.value = '';
    durationMinutes.value = '';
    durationSeconds.value = '';
};

</script>

<template>
    <AdminLayout>
        <Head :title="t('adm_tracks.create.title')" />

        <div class="header-container">
            <h1>{{ t('adm_tracks.create.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('admin-tracks-index')" class="btn-secondary">
                    {{ t('adm_tracks.create.back_to_tracks') }}
                </Link>
            </div>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <!-- Title -->
                    <div class="form-group">
                        <label for="title">{{ t('adm_tracks.create.title_label') }} <span class="required">*</span></label>
                        <input
                            v-model="form.title"
                            id="title"
                            type="text"
                            maxlength="255"
                            class="input-field"
                            :class="{ 'input-error': form.errors.title }"
                            :placeholder="t('adm_tracks.create.title_placeholder')"
                        />
                        <div v-if="form.errors.title" class="error-message">
                            {{ form.errors.title }}
                        </div>
                        <div class="character-count" :class="{ 'near-limit': form.title.length > 200 }">
                            {{ form.title.length }}/255 {{ t('adm_tracks.create.characters') }}
                        </div>
                    </div>

                    <!-- Release Date -->
                    <div class="form-group">
                        <label for="release_date">{{ t('adm_tracks.create.release_date_label') }} <span class="required">*</span></label>
                        <input
                            v-model="form.release_date"
                            id="release_date"
                            type="date"
                            class="input-field"
                            :class="{ 'input-error': form.errors.release_date }"
                        />
                        <div v-if="form.errors.release_date" class="error-message">
                            {{ form.errors.release_date }}
                        </div>
                        <div class="help-text">{{ t('adm_tracks.create.release_date_help') }}</div>
                    </div>

                    <!-- Duration (three separate fields) -->
                    <div class="form-group">
                        <label>{{ t('adm_tracks.create.duration_label') }} <span class="required">*</span></label>
                        <div class="duration-fields">
                            <div class="duration-field">
                                <input
                                    type="number"
                                    v-model.number="durationHours"
                                    class="input-field duration-input"
                                    placeholder="HH"
                                    min="0"
                                    max="23"
                                    step="1"
                                />
                                <span class="duration-sep">:</span>
                            </div>
                            <div class="duration-field">
                                <input
                                    type="number"
                                    v-model.number="durationMinutes"
                                    class="input-field duration-input"
                                    placeholder="MM"
                                    min="0"
                                    max="59"
                                    step="1"
                                />
                                <span class="duration-sep">:</span>
                            </div>
                            <div class="duration-field">
                                <input
                                    type="number"
                                    v-model.number="durationSeconds"
                                    class="input-field duration-input"
                                    placeholder="SS"
                                    min="0"
                                    max="59"
                                    step="1"
                                />
                            </div>
                        </div>
                        <div v-if="form.errors.duration" class="error-message">{{ form.errors.duration }}</div>
                        <div class="help-text">{{ t('adm_tracks.create.duration_help') }}</div>
                    </div>

                    <!-- Description (English) -->
                    <div class="form-group">
                        <label for="description">{{ t('adm_tracks.create.description_en') }}</label>
                        <textarea
                            v-model="form.description"
                            id="description"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description }"
                            :placeholder="t('adm_tracks.create.description_placeholder')"
                            rows="6"
                        ></textarea>
                        <div v-if="form.errors.description" class="error-message">
                            {{ form.errors.description }}
                        </div>
                    </div>

                    <!-- Description (Latvian) -->
                    <div class="form-group">
                        <label for="description_lv">{{ t('adm_tracks.create.description_lv') }}</label>
                        <textarea
                            v-model="form.description_lv"
                            id="description_lv"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.description_lv }"
                            :placeholder="t('adm_tracks.create.description_placeholder')"
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
                            {{ t('adm_tracks.create.reset_btn') }}
                        </button>
                        <button
                            type="submit"
                            class="btn-primary"
                            :disabled="form.processing"
                        >
                            {{ t('adm_tracks.create.create_track_btn') }}
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

.duration-fields {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.duration-field {
    display: flex;
    align-items: center;
    gap: 0.25rem;
}

.duration-input {
    width: 80px;
    text-align: center;
}

.duration-sep {
    font-size: 1rem;
    font-weight: bold;
    color: #4b5563;
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

    .duration-fields {
        flex-direction: column;
        align-items: stretch;
    }

    .duration-field {
        justify-content: space-between;
    }

    .duration-input {
        width: 100%;
    }
}

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }
}

</style>
