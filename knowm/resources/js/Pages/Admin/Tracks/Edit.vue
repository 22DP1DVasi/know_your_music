<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, useForm, router, Link } from '@inertiajs/vue3';
import {onMounted, ref, watch} from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import axios from "axios";
import GenreManagerModal from "@/Components/Admin/GenreManagerModal.vue";
import ArtistRelationManager from "@/Components/Admin/ArtistRelationManager.vue";
import RelatedReleasesModal from '@/Components/Admin/RelatedReleasesModal.vue';

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
            cover_url: null,
            genres: [],
            artists: [],
            releases: [],
            lyrics: null
        })
    }
});

dayjs.extend(utc);
const { t } = useI18n();

// main form for editable fields
const form = useForm({
    title: props.track.title || '',
    release_date: props.track.release_date
        ? props.track.release_date.substring(0, 10)
        : '',
    duration: props.track.duration || '',
    description: props.track.description || '',
    description_lv: props.track.description_lv || '',
    lyrics: props.track.lyrics?.lyrics || '',
    lyrics_status: props.track.lyrics?.status || 'requires verification',
});

// parse duration for display/editing HH:MM:SS
// the input will be a text field expecting format HH:MM:SS
const durationHours = ref('');
const durationMinutes = ref('');
const durationSeconds = ref('');

// initialize duration fields from track.duration (format HH:MM:SS)
const initDurationFields = () => {
    if (props.track.duration) {
        const parts = props.track.duration.split(':');
        if (parts.length === 3) {
            durationHours.value = parts[0];
            durationMinutes.value = parts[1];
            durationSeconds.value = parts[2];
        } else if (parts.length === 2) {
            // if format "MM:SS", hours = 0
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

// combine hours, minutes, seconds into HH:MM:SS string for form data
const updateDurationString = () => {
    const hours = String(durationHours.value || 0).padStart(2, '0');
    const minutes = String(durationMinutes.value || 0).padStart(2, '0');
    const seconds = String(durationSeconds.value || 0).padStart(2, '0');
    if (hours === '00' && minutes === '00' && seconds === '00') {
        form.duration = '';
    } else {
        form.duration = `${hours}:${minutes}:${seconds}`;
    }
};

// watch each duration field to update the combined duration
watch([durationHours, durationMinutes, durationSeconds], () => {
    updateDurationString();
});

// format timestamps in UTC
const formatDateTimeUTC = (dateString) => {
    if (!dateString) return t('adm_tracks.edit.unknown');
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

// format popularity for display
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
    form.lyrics = props.track.lyrics?.lyrics || '';
    form.lyrics_status = props.track.lyrics?.status || 'requires verification';
};

const showGenresModal = ref(false);
const genresList = ref([...props.track.genres]);
const allGenresList = ref([]);
const isLoadingGenres = ref(false);

const fetchAllGenres = async () => {
    isLoadingGenres.value = true;
    try {
        const response = await axios.get(route('genres.all'));
        allGenresList.value = response.data;
    } catch (error) {
        console.error('Failed to fetch genres:', error);
    } finally {
        isLoadingGenres.value = false;
    }
};

// fetch all genres when component mounts
onMounted(() => {
    fetchAllGenres();
});

const handleGenresSaved = async (payload) => {
    try {
        await axios.post(route('admin.genres.sync'), payload);
        // atjaunināt dziesmas žanrus lokāli ar jaunajiem atlasītajiem žanriem
        genresList.value = payload.genre_ids
            .map(id =>
                allGenresList.value.find(genre => genre.id === id)
            )
            .filter(Boolean);
        showGenresModal.value = false;
        alert(t('adm_components.genre_manager.success_message'))
    } catch (error) {
        console.error('Failed to sync genres:', error);
        alert(t('adm_tracks.edit.failed_update_genres'));
    }
};

const handleArtistsUpdate = async (artists) => {
    try {
        const response = await axios.post(
            route('admin-tracks-artists-update', {
                id: props.track.id
            }),
            {
                artists: artists.map(a => ({
                    id: a.id,
                    role: a.role || 'primary'
                }))
            }
        )
        if (response.data.success) {
            alert(response.data.message || t('adm_components.artist_relation_manager.save_artists_success'));
        }
    } catch (error) {
        console.error('Artists update error:', error);
        alert(error.response?.data?.message || t('adm_components.artist_relation_manager.save_artists_error'));
    }
}

const showReleasesModal = ref(false);
const releasesList = ref([...props.track.releases]);

const lyricsText = ref(props.track.lyrics?.lyrics || '');
const lyricsStatus = ref(props.track.lyrics?.status || 'requires verification');
const lastUpdatedBy = ref(props.track.lyrics?.last_updated_by_user || null);

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
                                <label for="release_date">{{ t('adm_tracks.edit.release_date_label') }} <span class="required">*</span></label>
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
                                <label>{{ t('adm_tracks.edit.duration_label') }} <span class="required">*</span></label>
                                <div class="duration-fields">
                                    <div class="duration-field">
                                        <input
                                            type="number"
                                            v-model.number="durationHours"
                                            class="input-field duration-input"
                                            placeholder="HH"
                                            min="0"
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

                            <!-- Lyrics -->
                            <div class="form-section">
                                <h2 class="section-title">{{ t('adm_tracks.edit.lyrics_section') }}</h2>

                                <div class="form-group">
                                    <label for="lyrics">{{ t('adm_tracks.edit.lyrics_label') }}</label>
                                    <textarea
                                        id="lyrics"
                                        v-model="form.lyrics"
                                        rows="18"
                                        class="textarea-field"
                                        :class="{ 'error': form.errors.lyrics }"
                                        :placeholder="t('adm_tracks.edit.lyrics_placeholder')"
                                    ></textarea>
                                    <div v-if="form.errors.lyrics" class="error-message">{{ form.errors.lyrics }}</div>
                                </div>

                                <div class="form-group">
                                    <label for="lyrics_status">{{ t('adm_tracks.edit.lyrics_status_label') }}</label>
                                    <select
                                        id="lyrics_status"
                                        v-model="form.lyrics_status"
                                        class="input-field"
                                        :class="{ 'error': form.errors.lyrics_status }"
                                    >
                                        <option value="requires verification">{{ t('adm_tracks.edit.status_requires_verification') }}</option>
                                        <option value="verified">{{ t('adm_tracks.edit.status_verified') }}</option>
                                    </select>
                                    <div v-if="form.errors.lyrics_status" class="error-message">{{ form.errors.lyrics_status }}</div>
                                </div>

                                <div class="form-group">
                                    <label>{{ t('adm_tracks.edit.last_updated_by') }}</label>
                                    <div class="readonly-field">{{ lastUpdatedBy || '—' }}</div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <div class="edit-form">
                        <div class="form-section">
                            <h2 class="section-title">{{ t('adm_tracks.edit.associated_content') }}</h2>
                            <button
                                type="button"
                                class="content-button"
                                @click="showGenresModal = true"
                            >
                                <span class="button-icon">🎵</span>
                                <span class="button-text">{{ t('adm_tracks.edit.view_genres') }}</span>
                                <span class="button-count">{{ genresList.length }}</span>
                            </button>

                            <ArtistRelationManager
                                :initial-artists="track.artists"
                                :search-route="route('admin-artists-search')"
                                entity-type="track"
                                @update="handleArtistsUpdate"
                            />

                            <button
                                type="button"
                                class="content-button"
                                @click="showReleasesModal = true"
                            >
                                <span class="button-icon">💿</span>
                                <span class="button-text">{{ t('adm_tracks.edit.view_releases') }}</span>
                                <span class="button-count">{{ track.releases.length }}</span>
                            </button>
                        </div>
                    </div>
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

        <GenreManagerModal
            :visible="showGenresModal"
            entity-type="track"
            :entity-id="track.id"
            :current-genres="genresList"
            :all-genres="allGenresList"
            @close="showGenresModal = false"
            @saved="handleGenresSaved"
        />

        <RelatedReleasesModal
            :visible="showReleasesModal"
            :releases="releasesList"
            @close="showReleasesModal = false"
        />
    </AdminLayout>
</template>

<style scoped>
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

.required {
    color: #ef4444;
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

.readonly-field {
    padding: 0.625rem 0.75rem;
    background: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    color: #4b5563;
    font-size: 0.875rem;
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

.content-button {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    width: 100%;
    padding: 1.5rem 1rem;
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    cursor: pointer;
    transition:
        transform 0.2s ease,
        box-shadow 0.2s ease,
        border-color 0.2s ease,
        background-color 0.2s ease;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.04);
}

.content-button:hover {
    transform: translateY(-2px);
    border-color: #cbd5e1;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    background: #fdfdfd;
}

.button-icon {
    font-size: 2rem;
    line-height: 1;
}

.button-text {
    font-size: 1rem;
    font-weight: 600;
    color: #111827;
    text-align: center;
    line-height: 1.3;
}

.button-count {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 32px;
    height: 32px;
    padding: 0 0.75rem;
    border-radius: 9999px;
    background: #334155;
    color: white;
    font-size: 0.8rem;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
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

/* Responsive design */
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
