<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import {Head, useForm, router, Link} from '@inertiajs/vue3';
import {onMounted, ref, computed, watch} from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import axios from 'axios';
import dayjs from "dayjs";
import utc from 'dayjs/plugin/utc';
import GenreManagerModal from '@/Components/Admin/GenreManagerModal.vue';
import ArtistRelationManager from '@/Components/Admin/ArtistRelationManager.vue';

const props = defineProps({
    release: {
        type: Object,
        required: true,
        default: () => ({
            id: null,
            title: '',
            slug: '',
            release_date: '',
            release_type: 'album',
            description: '',
            description_lv: '',
            popularity: null,
            created_at: '',
            updated_at: '',
            cover_url: null,
            genres: [],
            artists: [],
            tracks: []
        })
    },
    releaseTypes: {
        type: Array,
        default: () => ['album', 'ep', 'single', 'compilation']
    }
});

dayjs.extend(utc);
const { t } = useI18n();

const form = useForm({
    title: props.release.title || '',
    release_date: props.release.release_date
        ? props.release.release_date.substring(0, 10)
        : '',
    release_type: props.release.release_type || 'album',
    description: props.release.description || '',
    description_lv: props.release.description_lv || ''
});

const coverFile = ref(null);
const isUploadingCover = ref(false);
const originalCoverUrl = ref(props.release.cover_url || null);

const submit = () => {
    form.put(route('admin-releases-update', { id: props.release.id }), {
        preserveScroll: true,
        onError: (errors) => {
            console.error('Update errors:', errors);
        }
    });
};

const resetForm = () => {
    form.reset();
    form.title = props.release.title || '';
    form.release_date = props.release.release_date || '';
    form.release_type = props.release.release_type || 'album';
    form.description = props.release.description || '';
    form.description_lv = props.release.description_lv || '';
};

// saskaņotais pasaules laiks (UTC), nevis lokāls laiks
const formatDateTimeUTC = (dateString) => {
    if (!dateString) return t('adm_releases.edit.unknown');
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

// formatēt popularitāti priekš UI
const formattedPopularity = props.release.popularity ?
    parseFloat(props.release.popularity).toFixed(2) :
    '—';

const handleCoverFileChange = (event) => {
    const file = event.target.files[0];
    if (!file) return;
    if (!file.name.toLowerCase().endsWith('.webp')) {
        alert(t('adm_releases.edit.cover_error_type'));
        event.target.value = '';
        return;
    }
    coverFile.value = file;
    if (!originalCoverUrl.value) {
        originalCoverUrl.value = props.release.cover_url;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
        const preview = document.getElementById('cover-preview');
        if (preview) {
            preview.src = e.target.result;
        }
    };
    reader.readAsDataURL(file);
};

const uploadCover = async () => {
    if (!coverFile.value) {
        alert(t('adm_releases.edit.cover_error_no_file'));
        return;
    }
    isUploadingCover.value = true;
    const formData = new FormData();
    formData.append('cover', coverFile.value);
    formData.append('_method', 'PUT');
    try {
        const response = await axios.post(route('admin-releases-update-cover', { id: props.release.id }), formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
        });
        if (response.data.success) {
            const preview = document.getElementById('cover-preview');
            if (preview) {
                preview.src = response.data.cover_url;
            }
            originalCoverUrl.value = response.data.cover_url.replace(/\?t=.*$/, '');
            coverFile.value = null;
            const fileInput = document.getElementById('cover-file-input');
            if (fileInput) fileInput.value = '';
            alert(response.data.message || t('adm_releases.edit.cover_success'));
        } else {
            alert(response.data.message || t('adm_releases.edit.cover_error_upload'));
        }
    } catch (error) {
        console.error('Cover upload error:', error);
        alert(error.response?.data?.message || t('adm_releases.edit.cover_error_upload'));
    } finally {
        isUploadingCover.value = false;
    }
};

const cancelCoverUpload = () => {
    coverFile.value = null;
    const preview = document.getElementById('cover-preview');
    if (preview && originalCoverUrl.value) {
        preview.src = originalCoverUrl.value + '?t=' + Date.now();
    }
    const fileInput = document.getElementById('cover-file-input');
    if (fileInput) {
        fileInput.value = '';
        fileInput.dispatchEvent(new Event('change'));
    }
};

const showGenresModal = ref(false);
const genresList = ref([...props.release.genres]);
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
        // atjaunināt albuma žanrus lokāli ar jaunajiem atlasītajiem žanriem
        genresList.value = payload.genre_ids
            .map(id =>
                allGenresList.value.find(genre => genre.id === id)
            )
            .filter(Boolean);
        showGenresModal.value = false;
    } catch (error) {
        console.error('Failed to sync genres:', error);
        alert(t('adm_releases.edit.failed_update_genres'));
    }
};

const handleArtistsUpdate = async (artists) => {
    try {
        const response = await axios.post(
            route('admin-releases-artists-update', {
                id: props.release.id
            }),
            {
                artist_ids: artists.map(a => a.id)
            }
        )
        if (response.data.success) {
            alert(response.data.message || t('adm_releases.edit.save_artists_success'));
        }
    } catch (error) {
        console.error('Artists update error:', error);
        alert(error.response?.data?.message || t('adm_releases.edit.save_artists_error'));
    }
}

</script>

<template>
    <Head :title="`${t('adm_releases.edit.title')}: ${release.title}`" />

    <AdminLayout>
        <div class="edit-container">
            <div class="edit-header">
                <h1>{{ t('adm_releases.edit.title') }}</h1>
                <div class="edit-actions">
                    <button
                        type="button"
                        @click="resetForm"
                        class="btn-secondary"
                    >
                        {{ t('adm_releases.edit.reset_btn') }}
                    </button>
                    <Link :href="route('admin-releases-index')" class="btn-secondary">
                        {{ t('adm_releases.edit.back_to_releases') }}
                    </Link>
                </div>
            </div>

            <div class="edit-layout">
                <!-- Left column: main form-->
                <div class="edit-main">
                    <form @submit.prevent="submit" class="edit-form">
                        <!-- Basic fields -->
                        <div class="form-section">
                            <div class="main-info-header">
                                <h2 class="section-title">{{ t('adm_releases.edit.basic_info') }}</h2>
                                <button type="submit" class="btn-primary" :disabled="form.processing">
                                    {{ form.processing ? t('adm_releases.edit.saving') : t('adm_releases.edit.save_changes') }}
                                </button>
                            </div>

                            <div class="form-group">
                                <label for="title">{{ t('adm_releases.edit.title_label') }} <span class="required">*</span></label>
                                <input
                                    id="title"
                                    type="text"
                                    v-model="form.title"
                                    class="input-field"
                                    :class="{ 'error': form.errors.title }"
                                    maxlength="255"
                                    :placeholder="t('adm_releases.edit.artist_name_placeholder')"
                                />
                                <div v-if="form.errors.title" class="error-message">{{ form.errors.title }}</div>
                                <div class="character-count" :class="{ 'near-limit': form.title.length > 200 }">
                                    {{ form.title.length }}/255 {{ t('adm_releases.edit.characters') }}
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="release_date">{{ t('adm_releases.edit.release_date_label') }}</label>
                                    <input
                                        id="release_date"
                                        type="date"
                                        v-model="form.release_date"
                                        class="input-field"
                                        :class="{ 'error': form.errors.release_date }"
                                    />
                                    <div v-if="form.errors.release_date" class="error-message">{{ form.errors.release_date }}</div>
                                </div>

                                <div class="form-group">
                                    <label for="release_type">{{ t('adm_releases.edit.release_type_label') }}</label>
                                    <select
                                        id="release_type"
                                        v-model="form.release_type"
                                        class="input-field"
                                        :class="{ 'error': form.errors.release_type }"
                                    >
                                        <option v-for="type in releaseTypes" :key="type" :value="type">
                                            {{ t(`releases.type.${type}`) }}
                                        </option>
                                    </select>
                                    <div v-if="form.errors.release_type" class="error-message">{{ form.errors.release_type }}</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="description">{{ t('adm_releases.edit.description_label') }}</label>
                                <textarea
                                    id="description"
                                    v-model="form.description"
                                    rows="6"
                                    class="textarea-field"
                                    :class="{ 'error': form.errors.description }"
                                ></textarea>
                                <div v-if="form.errors.description" class="error-message">{{ form.errors.description }}</div>
                            </div>

                            <div class="form-group">
                                <label for="description_lv">{{ t('adm_releases.edit.description_lv_label') }}</label>
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

                    <div class="edit-form">
                        <div class="form-section">
                            <h2 class="section-title">{{ t('adm_releases.edit.associated_content') }}</h2>
                            <button
                                type="button"
                                class="content-button"
                                @click="showGenresModal = true"
                            >
                                <span class="button-icon">🎵</span>
                                <span class="button-text">{{ t('adm_releases.edit.view_genres') }}</span>
                                <span class="button-count">{{ genresList.length }}</span>
                            </button>

                            <ArtistRelationManager
                                :title="t('adm_releases.edit.release_artists')"
                                :subtitle="t('adm_releases.edit.release_artists_desc')"
                                :initial-artists="release.artists"
                                :search-route="route('admin-artists-search')"
                                :search-placeholder="t('adm_releases.edit.search_artists')"
                                :save-button-text="t('adm_releases.edit.save_artists')"
                                @update="handleArtistsUpdate"
                            />
                        </div>
                    </div>
                </div>

                <!-- Right column: read-only info & cover image -->
                <div class="edit-sidebar">
                    <!-- Read-only release information -->
                    <div class="info-card">
                        <h3 class="info-title">{{ t('adm_releases.edit.meta_info') }}</h3>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.id_label') }}:</span>
                            <span class="info-value">{{ release.id }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.slug_label') }}:</span>
                            <span class="info-value">{{ release.slug }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.popularity_label') }}:</span>
                            <span class="info-value popularity-value">{{ formattedPopularity }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.created_at_label') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(release.created_at) }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.updated_at_label') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(release.updated_at) }}</span>
                        </div>
                    </div>

                    <!-- Cover image section -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_releases.edit.cover_image') }}</h3>
                        <div class="cover-container">
                            <div class="cover-preview-square" id="cover-preview-wrapper">
                                <img
                                    id="cover-preview"
                                    class="cover-preview"
                                    :src="originalCoverUrl || '/images/default-release-banner.webp'"
                                    :alt="release.title"
                                    @error="(e) => e.target.src = '/images/default-release-banner.webp'"
                                />
                            </div>
                            <div class="image-upload-controls">
                                <div class="file-input-wrapper">
                                    <input
                                        type="file"
                                        id="cover-file-input"
                                        accept=".webp"
                                        class="file-input"
                                        @change="handleCoverFileChange"
                                    />
                                    <label for="cover-file-input" class="btn-secondary btn-file">
                                        {{ t('adm_releases.edit.choose_file') }}
                                    </label>
<!--                                    <span v-if="coverFile" class="file-name">{{ coverFile.name }}</span>-->
                                </div>
                                <div class="upload-buttons" v-if="coverFile">
                                    <button
                                        @click="uploadCover"
                                        :disabled="isUploadingCover"
                                        class="btn-primary btn-sm"
                                    >
                                        {{ isUploadingCover ? t('adm_releases.edit.uploading') : t('adm_releases.edit.upload') }}
                                    </button>
                                    <button
                                        @click="cancelCoverUpload"
                                        class="btn-secondary btn-sm"
                                    >
                                        {{ t('adm_releases.edit.cancel') }}
                                    </button>
                                </div>
                            </div>
                            <div class="image-info">
                                <div class="image-name">{{ release.cover_url }}</div>
                                <div class="image-size-info">{{ t('adm_releases.edit.cover_size') }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <GenreManagerModal
            :visible="showGenresModal"
            entity-type="release"
            :entity-id="release.id"
            :current-genres="genresList"
            :all-genres="allGenresList"
            @close="showGenresModal = false"
            @saved="handleGenresSaved"
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
    display: flex;
    gap: 2rem;
    flex-wrap: wrap;
}

.edit-main {
    flex: 2;
    min-width: 0;
    background: white;
    border-radius: 0.75rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
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

.edit-sidebar {
    flex: 1;
    min-width: 280px;
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

.form-group {
    margin-bottom: 1.25rem;
}

.form-row {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.form-row .form-group {
    flex: 1;
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

.character-count {
    color: #6b7280;
    font-size: 0.75rem;
    text-align: right;
    margin-top: 0.25rem;
}

.character-count.near-limit {
    color: #f59e0b;
}

.info-card,
.image-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1.25rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.75rem;
}

.file-input-wrapper {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    min-width: 0;
}

.file-input {
    display: none;
}

.btn-file {
    cursor: pointer;
}

.file-name {
    font-size: 0.8rem;
    color: #4b5563;

    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;

    max-width: 100%;
    min-width: 0;
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

.cover-placeholder i {
    font-size: 2rem;
    margin-bottom: 0.5rem;
}

/* Responsive design */
@media (max-width: 1115px) {
    .edit-layout {
        flex-direction: column;
    }

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

</style>
