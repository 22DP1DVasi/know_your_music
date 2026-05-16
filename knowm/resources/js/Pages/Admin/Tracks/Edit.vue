<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, useForm, router, Link } from '@inertiajs/vue3';
import { ref } from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';

const props = defineProps({
    track: {
        type: Object,
        required: true,
        default: () => ({
            id: null,
            title: '',
            slug: '',
            release_date: '',
            duration: '',
            description: '',
            description_lv: '',
            popularity: null,
            created_at: '',
            updated_at: '',
            cover_url: null
        })
    }
});

dayjs.extend(utc);
const { t } = useI18n();

// Main form for editable fields
const form = useForm({
    title: props.track.title || '',
    release_date: props.track.release_date
        ? props.track.release_date.substring(0, 10)
        : '',
    duration: props.track.duration || '',
    description: props.track.description || '',
    description_lv: props.track.description_lv || ''
});

// Parse duration for display/editing (HH:MM:SS)
// The input will be a text field expecting format "HH:MM:SS"
// We can also split into three separate number inputs, but for simplicity we'll use a single text input
// with a placeholder and pattern hint.
// Alternative: three separate fields for hours, minutes, seconds.
// I'll use three separate fields for better UX.

const durationHours = ref('');
const durationMinutes = ref('');
const durationSeconds = ref('');

// Initialize duration fields from track.duration (format "HH:MM:SS")
const initDurationFields = () => {
    if (props.track.duration) {
        const parts = props.track.duration.split(':');
        if (parts.length === 3) {
            durationHours.value = parts[0];
            durationMinutes.value = parts[1];
            durationSeconds.value = parts[2];
        } else if (parts.length === 2) {
            // If format "MM:SS", assume hours = 0
            durationHours.value = '0';
            durationMinutes.value = parts[0];
            durationSeconds.value = parts[1];
        } else {
            durationHours.value = '';
            durationMinutes.value = '';
            durationSeconds.value = '';
        }
    } else {
        durationHours.value = '';
        durationMinutes.value = '';
        durationSeconds.value = '';
    }
};
initDurationFields();

// Combine hours, minutes, seconds into HH:MM:SS string for form data
const updateDurationString = () => {
    const hours = durationHours.value.padStart(2, '0');
    const minutes = durationMinutes.value.padStart(2, '0');
    const seconds = durationSeconds.value.padStart(2, '0');
    if (hours === '00' && minutes === '00' && seconds === '00') {
        form.duration = '';
    } else {
        form.duration = `${hours}:${minutes}:${seconds}`;
    }
};

// Watch each duration field to update the combined duration
import { watch } from 'vue';
watch([durationHours, durationMinutes, durationSeconds], () => {
    updateDurationString();
});

// Format timestamps in UTC
const formatDateTimeUTC = (dateString) => {
    if (!dateString) return t('adm_tracks.edit.unknown');
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

// Format popularity for display
const formattedPopularity = props.track.popularity ?
    parseFloat(props.track.popularity).toFixed(2) :
    '—';

const submit = () => {
    form.put(route('admin-tracks-update', { id: props.track.id }), {
        preserveScroll: true,
        onError: (errors) => {
            console.error('Update errors:', errors);
        }
    });
};

const resetForm = () => {
    form.reset();
    form.title = props.track.title || '';
    form.release_date = props.track.release_date ? props.track.release_date.substring(0, 10) : '';
    initDurationFields();
    form.description = props.track.description || '';
    form.description_lv = props.track.description_lv || '';
};

</script>

<template>
    <Head :title="`${t('adm_tracks.edit.title')}: ${track.title}`" />

    <AdminLayout>
        <div class="edit-container">
            <div class="edit-header">
                <h1>{{ t('adm_tracks.edit.title') }}</h1>
                <div class="edit-actions">
                    <Link :href="route('admin-tracks-index')" class="btn-secondary">
                        {{ t('adm_tracks.edit.back_to_tracks') }}
                    </Link>
                </div>
            </div>

            <div class="edit-layout">
                <!-- Left column: main form -->
                <div class="edit-main">
                    <form @submit.prevent="submit" class="edit-form">
                        <div class="form-section">
                            <div class="main-info-header">
                                <h2 class="section-title">{{ t('adm_tracks.edit.basic_info') }}</h2>
                                <div class="header-buttons">
                                    <button
                                        type="button"
                                        @click="resetForm"
                                        class="btn-secondary"
                                    >
                                        {{ t('adm_tracks.edit.reset_btn') }}
                                    </button>
                                    <button type="submit" class="btn-primary" :disabled="form.processing">
                                        {{ form.processing ? t('adm_tracks.edit.saving') : t('adm_tracks.edit.save_changes') }}
                                    </button>
                                </div>
                            </div>

                            <!-- Title -->
                            <div class="form-group">
                                <label for="title">{{ t('adm_tracks.edit.title_label') }} <span class="required">*</span></label>
                                <input
                                    id="title"
                                    type="text"
                                    v-model="form.title"
                                    class="input-field"
                                    :class="{ 'error': form.errors.title }"
                                    maxlength="255"
                                    :placeholder="t('adm_tracks.edit.title_placeholder')"
                                />
                                <div v-if="form.errors.title" class="error-message">{{ form.errors.title }}</div>
                                <div class="character-count" :class="{ 'near-limit': form.title.length > 200 }">
                                    {{ form.title.length }}/255 {{ t('adm_tracks.edit.characters') }}
                                </div>
                            </div>

                            <!-- Release Date -->
                            <div class="form-group">
                                <label for="release_date">{{ t('adm_tracks.edit.release_date_label') }}</label>
                                <input
                                    id="release_date"
                                    type="date"
                                    v-model="form.release_date"
                                    class="input-field"
                                    :class="{ 'error': form.errors.release_date }"
                                />
                                <div v-if="form.errors.release_date" class="error-message">{{ form.errors.release_date }}</div>
                            </div>

                            <!-- Duration (three separate fields) -->
                            <div class="form-group">
                                <label>{{ t('adm_tracks.edit.duration_label') }}</label>
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
                                <div class="help-text">{{ t('adm_tracks.edit.duration_help') }}</div>
                            </div>

                            <!-- Description (English) -->
                            <div class="form-group">
                                <label for="description">{{ t('adm_tracks.edit.description_label') }}</label>
                                <textarea
                                    id="description"
                                    v-model="form.description"
                                    rows="6"
                                    class="textarea-field"
                                    :class="{ 'error': form.errors.description }"
                                ></textarea>
                                <div v-if="form.errors.description" class="error-message">{{ form.errors.description }}</div>
                            </div>

                            <!-- Description (Latvian) -->
                            <div class="form-group">
                                <label for="description_lv">{{ t('adm_tracks.edit.description_lv_label') }}</label>
                                <textarea
                                    id="description_lv"
                                    v-model="form.description_lv"
                                    rows="6"
                                    class="textarea-field"
                                    :class="{ 'error': form.errors.description_lv }"
                                ></textarea>
                                <div v-if="form.errors.description_lv" class="error-message">{{ form.errors.description_lv }}</div>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Right column: read-only info & cover image -->
                <div class="edit-sidebar">
                    <!-- Read-only track information -->
                    <div class="info-card">
                        <h3 class="info-title">{{ t('adm_tracks.edit.meta_info') }}</h3>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_tracks.edit.id_label') }}:</span>
                            <span class="info-value">{{ track.id }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_tracks.edit.slug_label') }}:</span>
                            <span class="info-value">{{ track.slug }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_tracks.edit.popularity_label') }}:</span>
                            <span class="info-value popularity-value">{{ formattedPopularity }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_tracks.edit.created_at_label') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(track.created_at) }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_tracks.edit.updated_at_label') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(track.updated_at) }}</span>
                        </div>
                    </div>

                    <!-- Cover image section (READ-ONLY) -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_tracks.edit.cover_image') }}</h3>
                        <div class="cover-container">
                            <div class="cover-preview-square">
                                <img
                                    class="cover-preview"
                                    :src="track.cover_url || '/images/default-track-cover.webp'"
                                    :alt="track.title"
                                    @error="(e) => e.target.src = '/images/default-track-cover.webp'"
                                />
                            </div>
                            <div class="image-info">
                                <div class="image-name">{{ track.cover_url }}</div>
                                <div class="image-size-info">{{ t('adm_tracks.edit.cover_readonly') }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<style scoped>
/* Re-use the exact same styles as Releases/Edit – copy all styles from there */
.edit-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1rem;
}

.edit-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.edit-header h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

.edit-actions {
    display: flex;
    gap: 0.75rem;
}

.btn-secondary {
    background-color: #6b7280;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    text-decoration: none;
    font-weight: 500;
    transition: background 0.2s;
    display: inline-block;
    border: none;
    cursor: pointer;
}

.btn-secondary:hover {
    background-color: #4b5563;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    border: none;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-primary:hover:not(:disabled) {
    background-color: #2563eb;
}

.btn-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.edit-layout {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 2rem;
    align-items: start;
}

.edit-main {
    flex: 2;
    min-width: 0;
    background: white;
    border-radius: 0.75rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.edit-form {
    background: white;
    border-radius: 0.75rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.edit-sidebar {
    flex: 1;
    min-width: 0;
}

.form-section {
    margin-bottom: 2rem;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 1.5rem;
}

.main-info-header {
    display: flex;
    justify-content: space-between;
}

.section-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1.25rem;
}

.header-buttons {
    display: flex;
    gap: 1rem;
}

.form-group {
    margin-bottom: 1.25rem;
}

.form-row {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin-bottom: 0;
}

.form-row .form-group {
    flex: 1;
    min-width: 0;
}

label {
    display: block;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.5rem;
    font-size: 0.875rem;
}

.required {
    color: #ef4444;
}

.input-field,
.textarea-field,
select.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    transition: all 0.2s;
}

.input-field:focus,
.textarea-field:focus,
select.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

.input-field.error,
.textarea-field.error,
select.input-field.error {
    border-color: #ef4444;
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

.character-count {
    color: #6b7280;
    font-size: 0.75rem;
    text-align: right;
    margin-top: 0.25rem;
}

.character-count.near-limit {
    color: #f59e0b;
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

.help-text {
    color: #6b7280;
    font-size: 0.75rem;
    margin-top: 0.25rem;
    font-style: italic;
}

.info-card,
.image-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1.25rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.info-title {
    font-size: 1rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 0.5rem;
}

.info-row {
    display: flex;
    padding: 0.5rem 0;
    font-size: 0.875rem;
    border-bottom: 1px solid #f3f4f6;
}

.info-label {
    flex: 0 0 110px;
    font-weight: 500;
    color: #4b5563;
}

.info-value {
    flex: 1;
    color: #1f2937;
    word-break: break-word;
}

.popularity-value {
    font-family: monospace;
    color: #059669;
    font-weight: 600;
}

.cover-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.cover-preview-square {
    width: 100%;
    aspect-ratio: 1 / 1;
    border-radius: 0.5rem;
    overflow: hidden;
    border: 1px solid #e5e7eb;
    background: #f8fafc;
}

.cover-preview {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.image-info {
    background: #f8fafc;
    padding: 0.5rem;
    border-radius: 0.375rem;
    font-size: 0.75rem;
}

.image-name {
    font-family: monospace;
    color: #1e293b;
    word-break: break-all;
}

.image-size-info {
    font-size: 0.7rem;
    color: #6b7280;
    margin-top: 0.25rem;
}

/* Responsive */
@media (max-width: 1115px) {
    .edit-header {
        flex-direction: column;
        align-items: stretch;
    }

    .edit-actions {
        flex-wrap: wrap;
    }

    .form-row {
        flex-direction: column;
        gap: 0;
    }

    .cover-preview-square {
        max-width: 280px;
        margin: 0 auto;
    }
}

@media (max-width: 1024px) {
    .edit-layout {
        grid-template-columns: 1fr;
    }
}

</style>
