<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import { ref, watch } from 'vue';
import dayjs from "dayjs";
import utc from 'dayjs/plugin/utc';
import axios from 'axios';
import RelatedTracksModal from '@/Components/Admin/RelatedTracksModal.vue';
import RelatedReleasesModal from "@/Components/Admin/RelatedReleasesModal.vue";

dayjs.extend(utc);

const props = defineProps({
    genre: {
        type: Object,
        required: true,
        default: () => ({
            id: null,
            name: '',
            slug: '',
            origin_year: null,
            origin_country: '',
            description: '',
            description_lv: '',
            popularity: null,
            created_at: '',
            updated_at: '',
            banner_url: null,
            profile_url: null,
            initial_releases: [],
            initial_tracks: []
        })
    }
});

const { t } = useI18n();

// main form
const form = useForm({
    name: props.genre.name || '',
    origin_year: props.genre.origin_year || '',
    origin_country: props.genre.origin_country || '',
    description: props.genre.description || '',
    description_lv: props.genre.description_lv || ''
});

// limit input length helper
const limitInput = (field, maxLength) => {
    if (form[field].length > maxLength) {
        form[field] = form[field].substring(0, maxLength);
    }
};

watch(() => form.name, () => limitInput('name', 100));
watch(() => form.origin_country, () => limitInput('origin_country', 100));

// year options (1900 to current year + 10)
const currentYear = new Date().getFullYear();
const yearOptions = Array.from({ length: currentYear + 10 - 1900 + 1 }, (_, i) => 1900 + i).reverse();

const submit = () => {
    form.put(route('admin-genres-update', { id: props.genre.id }));
};

const resetForm = () => {
    form.reset();
    form.name = props.genre.name || '';
    form.origin_year = props.genre.origin_year || '';
    form.origin_country = props.genre.origin_country || '';
    form.description = props.genre.description || '';
    form.description_lv = props.genre.description_lv || '';
};

// format popularity value for UI
const formattedPopularity = props.genre.popularity ?
    parseFloat(props.genre.popularity).toFixed(2) :
    '—';

// format timestamps in UTC
const formatDateTimeUTC = (dateString) => {
    if (!dateString) return t('adm_genres.edit.unknown');
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

// image upload states
const bannerFile = ref(null);
const profileFile = ref(null);
const isUploadingBanner = ref(false);
const isUploadingProfile = ref(false);
const originalBannerUrl = ref(props.genre.banner_url);
const originalProfileUrl = ref(props.genre.profile_url);

const handleImageError = (event, type) => {
    const defaultImages = {
        banner: '/images/default-genre-banner.webp',
        profile: '/images/default-genre-profile.webp'
    };
    event.target.src = defaultImages[type];
};

const handleBannerFileChange = (event) => {
    const file = event.target.files[0];
    if (!file) return;
    if (!file.name.toLowerCase().endsWith('.webp')) {
        alert(t('adm_genres.edit.image_error_webp'));
        event.target.value = '';
        return;
    }
    bannerFile.value = file;
    if (!originalBannerUrl.value) {
        originalBannerUrl.value = props.genre.banner_url;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
        const preview = document.getElementById('banner-preview');
        if (preview) preview.src = e.target.result;
    };
    reader.readAsDataURL(file);
};

const handleProfileFileChange = (event) => {
    const file = event.target.files[0];
    if (!file) return;
    if (!file.name.toLowerCase().endsWith('.webp')) {
        alert(t('adm_genres.edit.image_error_webp'));
        event.target.value = '';
        return;
    }
    profileFile.value = file;
    if (!originalProfileUrl.value) {
        originalProfileUrl.value = props.genre.profile_url;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
        const preview = document.getElementById('profile-preview');
        if (preview) preview.src = e.target.result;
    };
    reader.readAsDataURL(file);
};

const uploadBanner = async () => {
    if (!bannerFile.value) {
        alert(t('adm_genres.edit.image_error_no_file'));
        return;
    }
    isUploadingBanner.value = true;
    const formData = new FormData();
    formData.append('banner', bannerFile.value);
    formData.append('type', 'banner');
    formData.append('_method', 'PUT');
    try {
        const response = await axios.post(route('admin-genres-update-image', { id: props.genre.id }), formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
        });
        if (response.data.success) {
            const preview = document.getElementById('banner-preview');
            if (preview) preview.src = response.data.image_url;
            originalBannerUrl.value = response.data.image_url.replace(/\?t=.*$/, '');
            bannerFile.value = null;
            const fileInput = document.getElementById('banner-file-input');
            if (fileInput) fileInput.value = '';
            alert(response.data.message || t('adm_genres.edit.image_success_banner'));
        } else {
            alert(response.data.message || t('adm_genres.edit.image_error_upload'));
        }
    } catch (error) {
        console.error('Upload error:', error);
        alert(error.response?.data?.message || t('adm_genres.edit.image_error_upload'));
    } finally {
        isUploadingBanner.value = false;
    }
};

const uploadProfile = async () => {
    if (!profileFile.value) {
        alert(t('adm_genres.edit.image_error_no_file'));
        return;
    }
    isUploadingProfile.value = true;
    const formData = new FormData();
    formData.append('profile', profileFile.value);
    formData.append('type', 'profile');
    formData.append('_method', 'PUT');
    try {
        const response = await axios.post(route('admin-genres-update-image', { id: props.genre.id }), formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
        });
        if (response.data.success) {
            const preview = document.getElementById('profile-preview');
            if (preview) preview.src = response.data.image_url;
            originalProfileUrl.value = response.data.image_url.replace(/\?t=.*$/, '');
            profileFile.value = null;
            const fileInput = document.getElementById('profile-file-input');
            if (fileInput) fileInput.value = '';
            alert(response.data.message || t('adm_genres.edit.image_success_profile'));
        } else {
            alert(response.data.message || t('adm_genres.edit.image_error_upload'));
        }
    } catch (error) {
        console.error('Upload error:', error);
        alert(error.response?.data?.message || t('adm_genres.edit.image_error_upload'));
    } finally {
        isUploadingProfile.value = false;
    }
};

const cancelBannerUpload = () => {
    bannerFile.value = null;
    const preview = document.getElementById('banner-preview');
    if (preview && originalBannerUrl.value) {
        preview.src = originalBannerUrl.value + '?t=' + Date.now();
    }
    const fileInput = document.getElementById('banner-file-input');
    if (fileInput) {
        fileInput.value = '';
        fileInput.dispatchEvent(new Event('change'));
    }
};

const cancelProfileUpload = () => {
    profileFile.value = null;
    const preview = document.getElementById('profile-preview');
    if (preview && originalProfileUrl.value) {
        preview.src = originalProfileUrl.value + '?t=' + Date.now();
    }
    const fileInput = document.getElementById('profile-file-input');
    if (fileInput) {
        fileInput.value = '';
        fileInput.dispatchEvent(new Event('change'));
    }
};

// modālie stāvokļi
const showTracksModal = ref(false);
const showReleasesModal = ref(false);

</script>

<template>
    <AdminLayout>
        <div class="edit-container">
            <div class="edit-header">
                <h1>{{ t('adm_genres.edit.title') }}</h1>
                <div class="edit-actions">
                    <Link :href="route('admin-genres-index')" class="btn-secondary">
                        {{ t('adm_genres.edit.back_to_genres') }}
                    </Link>
                </div>
            </div>

            <div class="edit-layout">
                <!-- Left column: main form -->
                <div class="edit-main">
                    <form @submit.prevent="submit" class="edit-form">
                        <div class="form-section">
                            <div class="main-info-header">
                                <h2 class="section-title">{{ t('adm_genres.edit.main_info') }}</h2>
                                <div class="header-buttons">
                                    <button type="button" @click="resetForm" class="btn-secondary">
                                        {{ t('adm_genres.edit.reset_btn') }}
                                    </button>
                                    <button type="submit" class="btn-primary" :disabled="form.processing">
                                        {{ form.processing ? t('adm_genres.edit.saving') : t('adm_genres.edit.save_changes') }}
                                    </button>
                                </div>
                            </div>

                            <!-- Name -->
                            <div class="form-group">
                                <label for="name">{{ t('adm_genres.edit.name_label') }} <span class="required">*</span></label>
                                <input
                                    v-model="form.name"
                                    id="name"
                                    type="text"
                                    maxlength="100"
                                    class="input-field"
                                    :class="{ 'input-error': form.errors.name }"
                                    :placeholder="t('adm_genres.edit.name_placeholder')"
                                />
                                <div v-if="form.errors.name" class="error-message">{{ form.errors.name }}</div>
                                <div class="character-count" :class="{ 'near-limit': form.name.length > 80 }">
                                    {{ form.name.length }}/100 {{ t('adm_genres.edit.characters') }}
                                </div>
                            </div>

                            <div class="form-row">
                                <!-- Origin Year -->
                                <div class="form-group">
                                    <label for="origin_year">{{ t('adm_genres.edit.origin_year_label') }}</label>
                                    <select
                                        v-model="form.origin_year"
                                        id="origin_year"
                                        class="input-field"
                                        :class="{ 'input-error': form.errors.origin_year }"
                                    >
                                        <option value="">{{ t('adm_genres.edit.select_year') }}</option>
                                        <option v-for="year in yearOptions" :key="year" :value="year">{{ year }}</option>
                                    </select>
                                    <div v-if="form.errors.origin_year" class="error-message">{{ form.errors.origin_year }}</div>
                                </div>

                                <!-- Origin Country -->
                                <div class="form-group">
                                    <label for="origin_country">{{ t('adm_genres.edit.origin_country_label') }}</label>
                                    <input
                                        v-model="form.origin_country"
                                        id="origin_country"
                                        type="text"
                                        maxlength="100"
                                        class="input-field"
                                        :class="{ 'input-error': form.errors.origin_country }"
                                        :placeholder="t('adm_genres.edit.origin_country_placeholder')"
                                    />
                                    <div v-if="form.errors.origin_country" class="error-message">{{ form.errors.origin_country }}</div>
                                    <div class="character-count">{{ form.origin_country.length }}/100 {{ t('adm_genres.edit.characters') }}</div>
                                </div>
                            </div>

                            <!-- Description (English) -->
                            <div class="form-group">
                                <label for="description">{{ t('adm_genres.edit.description_label') }}</label>
                                <textarea
                                    v-model="form.description"
                                    id="description"
                                    class="input-field textarea-field"
                                    :class="{ 'input-error': form.errors.description }"
                                    :placeholder="t('adm_genres.edit.description_placeholder')"
                                    rows="6"
                                ></textarea>
                                <div v-if="form.errors.description" class="error-message">{{ form.errors.description }}</div>
                            </div>

                            <!-- Description (Latvian) -->
                            <div class="form-group">
                                <label for="description_lv">{{ t('adm_genres.edit.description_lv_label') }}</label>
                                <textarea
                                    v-model="form.description_lv"
                                    id="description_lv"
                                    class="input-field textarea-field"
                                    :class="{ 'input-error': form.errors.description_lv }"
                                    :placeholder="t('adm_genres.edit.description_placeholder')"
                                    rows="6"
                                ></textarea>
                                <div v-if="form.errors.description_lv" class="error-message">{{ form.errors.description_lv }}</div>
                            </div>
                        </div>
                    </form>

                    <div class="edit-form">
                        <div class="form-section">
                            <h2 class="section-title">{{ t('adm_artists.edit.associated_content') }}</h2>
                            <div class="content-buttons-grid">
    <!--                            <button-->
    <!--                                type="button"-->
    <!--                                class="content-button"-->
    <!--                                @click="showGenresModal = true"-->
    <!--                            >-->
    <!--                                <span class="button-icon">🎵</span>-->
    <!--                                <span class="button-text">{{ t('adm_artists.edit.view_genres') }}</span>-->
    <!--                                <span class="button-count">{{ genresList.length }}</span>-->
    <!--                            </button>-->
                                <button
                                    type="button"
                                    class="content-button"
                                    @click="showReleasesModal = true"
                                >
                                    <span class="button-icon">💿</span>
                                    <span class="button-text">{{ t('adm_genres.edit.view_releases') }}</span>
                                    <span class="button-count">{{ genre.initial_releases.length }}</span>
                                </button>
                                <button
                                    type="button"
                                    class="content-button"
                                    @click="showTracksModal = true"
                                >
                                    <span class="button-icon">🎶</span>
                                    <span class="button-text">{{ t('adm_genres.edit.view_tracks') }}</span>
                                    <span class="button-count">{{ genre.initial_tracks.length }}</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right column: read-only info and images -->
                <div class="edit-sidebar">
                    <!-- Read-only genre information -->
                    <div class="info-card">
                        <h3 class="info-title">{{ t('adm_genres.edit.meta_info') }}</h3>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_genres.edit.id_label') }}:</span>
                            <span class="info-value">{{ genre.id }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_genres.edit.slug_label') }}:</span>
                            <span class="info-value">{{ genre.slug }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_genres.edit.popularity_label') }}:</span>
                            <span class="info-value popularity-value">{{ formattedPopularity }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_genres.edit.created_at_label') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(genre.created_at) }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_genres.edit.updated_at_label') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(genre.updated_at) }}</span>
                        </div>
                    </div>

                    <!-- Banner Image Section -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_genres.edit.banner_image') }}</h3>
                        <div class="image-container">
                            <div class="image-preview-square">
                                <img
                                    :src="originalBannerUrl || '/images/default-genre-banner.webp'"
                                    :alt="t('adm_genres.edit.banner_alt', { name: genre.name })"
                                    class="image-preview"
                                    id="banner-preview"
                                    @error="handleImageError($event, 'banner')"
                                />
                            </div>
                            <div class="image-upload-controls">
                                <div class="file-input-wrapper">
                                    <input
                                        type="file"
                                        id="banner-file-input"
                                        accept=".webp"
                                        class="file-input"
                                        @change="handleBannerFileChange"
                                    />
                                    <label for="banner-file-input" class="btn-secondary btn-file">
                                        {{ t('adm_genres.edit.choose_file') }}
                                    </label>
                                    <span v-if="bannerFile" class="file-name">{{ bannerFile.name }}</span>
                                </div>
                                <div class="upload-buttons" v-if="bannerFile">
                                    <button @click="uploadBanner" :disabled="isUploadingBanner" class="btn-primary btn-sm">
                                        {{ isUploadingBanner ? t('adm_genres.edit.uploading') : t('adm_genres.edit.upload') }}
                                    </button>
                                    <button @click="cancelBannerUpload" class="btn-secondary btn-sm">
                                        {{ t('adm_genres.edit.cancel') }}
                                    </button>
                                </div>
                            </div>
                            <div class="image-info">
                                <div class="image-name">{{ genre.banner_url }}</div>
                                <div class="image-size-info">{{ t('adm_genres.edit.banner_size') }}</div>
                            </div>
                        </div>
                    </div>

                    <!-- Profile Image Section -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_genres.edit.profile_image') }}</h3>
                        <div class="image-container">
                            <div class="image-preview-horizontal">
                                <img
                                    :src="originalProfileUrl || '/images/default-genre-profile.webp'"
                                    :alt="t('adm_genres.edit.profile_alt', { name: genre.name })"
                                    class="image-preview"
                                    id="profile-preview"
                                    @error="handleImageError($event, 'profile')"
                                />
                            </div>
                            <div class="image-upload-controls">
                                <div class="file-input-wrapper">
                                    <input
                                        type="file"
                                        id="profile-file-input"
                                        accept=".webp"
                                        class="file-input"
                                        @change="handleProfileFileChange"
                                    />
                                    <label for="profile-file-input" class="btn-secondary btn-file">
                                        {{ t('adm_genres.edit.choose_file') }}
                                    </label>
                                    <span v-if="profileFile" class="file-name">{{ profileFile.name }}</span>
                                </div>
                                <div class="upload-buttons" v-if="profileFile">
                                    <button @click="uploadProfile" :disabled="isUploadingProfile" class="btn-primary btn-sm">
                                        {{ isUploadingProfile ? t('adm_genres.edit.uploading') : t('adm_genres.edit.upload') }}
                                    </button>
                                    <button @click="cancelProfileUpload" class="btn-secondary btn-sm">
                                        {{ t('adm_genres.edit.cancel') }}
                                    </button>
                                </div>
                            </div>
                            <div class="image-info">
                                <div class="image-name">{{ genre.profile_url }}</div>
                                <div class="image-size-info">{{ t('adm_genres.edit.profile_size') }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <RelatedReleasesModal
            :visible="showReleasesModal"
            :releases="genre.initial_releases"
            :remote-search="true"
            :search-route="route('admin-genres-search-releases', genre.id)"
            @close="showReleasesModal = false"
        />

        <RelatedTracksModal
            :visible="showTracksModal"
            :tracks="genre.initial_tracks"
            :remote-search="true"
            :search-route="route('admin-genres-search-tracks', genre.id)"
            @close="showTracksModal = false"
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

.edit-layout {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 2rem;
    align-items: start;
}

.edit-main {
    min-width: 0;
}

.edit-sidebar {
    min-width: 0;
}

.edit-form {
    background: white;
    border-radius: 0.75rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
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

.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    transition: all 0.2s;
}

.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

.input-field.input-error {
    border-color: #ef4444;
}

.textarea-field {
    resize: vertical;
    min-height: 120px;
    font-family: inherit;
    line-height: 1.5;
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

.content-buttons-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
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

.form-actions {
    text-align: right;
    margin-top: 1rem;
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

.image-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.image-preview-square {
    width: 100%;
    aspect-ratio: 1 / 1;
    border-radius: 0.5rem;
    overflow: hidden;
    border: 1px solid #e5e7eb;
    background: #f8fafc;
}

.image-preview-horizontal {
    width: 100%;
    aspect-ratio: 3 / 2;
    border-radius: 0.5rem;
    overflow: hidden;
    border: 1px solid #e5e7eb;
    background: #f8fafc;
}

.image-preview {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.image-upload-controls {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.file-input-wrapper {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
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
}

.upload-buttons {
    display: flex;
    gap: 0.5rem;
}

.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.75rem;
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
    .image-preview-square,
    .image-preview-horizontal {
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
