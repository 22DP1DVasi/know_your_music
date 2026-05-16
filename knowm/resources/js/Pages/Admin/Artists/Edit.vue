<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import {computed, watch, ref, onMounted} from 'vue';
import dayjs from "dayjs";
import utc from 'dayjs/plugin/utc';
import axios from 'axios';
import GenreManagerModal from '@/Components/Admin/GenreManagerModal.vue';
import RelatedReleasesModal from '@/Components/Admin/RelatedReleasesModal.vue';
import RelatedTracksModal from '@/Components/Admin/RelatedTracksModal.vue';

dayjs.extend(utc);

const props = defineProps({
    artist: Object,
    soloOrBandOptions: Array
});

const form = useForm({
    name: props.artist.name,
    biography: props.artist.biography || '',
    biography_lv: props.artist.biography_lv || '',
    formed_year: props.artist.formed_year || '',
    disbanded_year: props.artist.disbanded_year || '',
    is_active: props.artist.is_active ? 1 : 0,
    solo_or_band: props.artist.solo_or_band || 'band',
});

const { t } = useI18n();

// modālie stāvokļi
const showGenresModal = ref(false);
const showReleasesModal = ref(false);
const showTracksModal = ref(false);

const allGenresList = ref([]);
const isLoadingGenres = ref(false);

const genresList = ref([...props.artist.genres]);
const releasesList = ref([...props.artist.releases]);
const tracksList = ref([...props.artist.tracks]);

const submit = () => {
    form.put(route('admin-artists-update', { id: props.artist.id }));
};

const resetForm = () => {
    form.reset();
    form.name = props.artist.name;
    form.biography = props.artist.biography || '';
    form.biography_lv = props.artist.biography_lv || '';
    form.formed_year = props.artist.formed_year || '';
    form.disbanded_year = props.artist.disbanded_year || '';
    form.is_active = props.artist.is_active ? 1 : 0;
    form.solo_or_band = props.artist.solo_or_band || 'band';
};

// palīga (helper) funkcija ievades garuma ierobežošanai
const limitInput = (field, maxLength) => {
    if (form[field].length > maxLength) {
        form[field] = form[field].substring(0, maxLength);
    }
};

// skatīties vārda garuma ierobežojumu
watch(() => form.name, () => {
    limitInput('name', 255);
});

// ģenerēt gada opcijas nolaižamajiem sarakstiem (no 1900. gada līdz pašreizējam gadam + 10)
const currentYear = new Date().getFullYear();
const yearOptions = Array.from({ length: currentYear + 10 - 1900 + 1 },
    (_, i) => 1900 + i)
    .reverse();

const disbandedYearOptions = computed(() => {
    if (!form.formed_year) {
        return yearOptions;
    }

    return yearOptions.filter(
        year => year >= Number(form.formed_year)
    );
});

watch(() => form.formed_year, (newFormedYear) => {
    if (
        form.disbanded_year &&
        newFormedYear &&
        Number(form.disbanded_year) < Number(newFormedYear)
    ) {
        form.disbanded_year = '';
    }
});

// formatēt popularitāti priekš UI
const formattedPopularity = props.artist.popularity ?
    parseFloat(props.artist.popularity).toFixed(2) :
    '—';

// saskaņotais pasaules laiks (UTC), nevis lokāls laiks
const formatDateTimeUTC = (dateString) => {
    if (!dateString) return t('adm_artists.edit.unknown');
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

// skatīties modālā stāvokļa izmaiņas, lai novērstu ķermeņa ritināšanu (WIP)
watch([showGenresModal, showReleasesModal, showTracksModal], () => {
    const isAnyModalOpen = showGenresModal.value || showReleasesModal.value || showTracksModal.value;
    if (isAnyModalOpen) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
});

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

const handleGenresSaved = async (payload) => {
    try {
        await axios.post(route('admin.genres.sync'), payload);
        // atjaunināt izpildītāja žanrus lokāli ar jaunajiem atlasītajiem žanriem
        genresList.value = payload.genre_ids
            .map(id =>
                allGenresList.value.find(genre => genre.id === id)
            )
            .filter(Boolean);
        showGenresModal.value = false;
    } catch (error) {
        console.error('Failed to sync genres:', error);
        alert(t('adm_artists.edit.failed_update_genres'));
    }
};

// fetch all genres when component mounts
onMounted(() => {
    fetchAllGenres();
});

// attēlu augšupielādes stāvokļi
const bannerFile = ref(null);
const profileFile = ref(null);
const isUploadingBanner = ref(false);
const isUploadingProfile = ref(false);
// refs oriģinālo attēlu URL glabāšanai
const originalBannerUrl = ref(props.artist.banner_url);
const originalProfileUrl = ref(props.artist.profile_url);

// apstrādāt attēla ielādes kļūdas
const handleImageError = (event, type) => {
    const defaultImages = {
        banner: '/images/default-artist-banner.webp',
        profile: '/images/default-artist-profile.webp'
    };
    event.target.src = defaultImages[type];
};

// apstrādāt banera faila atlasi
const handleBannerFileChange = (event) => {
    const file = event.target.files[0];
    if (!file) return;
    // pārbaudīt, vai fails ir .webp
    if (!file.name.toLowerCase().endsWith('.webp')) {
        alert(t('adm_artists.edit.image_error_webp'));
        event.target.value = '';
        return;
    }
    bannerFile.value = file;
    // pirms priekšskatījuma maiņas saglabāt sākotnējo URL
    if (!originalBannerUrl.value) {
        originalBannerUrl.value = props.artist.banner_url;
    }
    // priekšskatīt attēlu
    const reader = new FileReader();
    reader.onload = (e) => {
        const preview = document.getElementById('banner-preview');
        if (preview) {
            preview.src = e.target.result;
        }
    };
    reader.readAsDataURL(file);
};

// apstrādāt profila faila atlasi
const handleProfileFileChange = (event) => {
    const file = event.target.files[0];
    if (!file) return;
    // pārbaudīt, vai fails ir .webp
    if (!file.name.toLowerCase().endsWith('.webp')) {
        alert(t('adm_artists.edit.image_error_webp'));
        event.target.value = '';
        return;
    }
    profileFile.value = file;
    // pirms priekšskatījuma maiņas saglabāt sākotnējo URL
    if (!originalProfileUrl.value) {
        originalProfileUrl.value = props.artist.profile_url;
    }
    // priekšskatīt attēlu
    const reader = new FileReader();
    reader.onload = (e) => {
        const preview = document.getElementById('profile-preview');
        if (preview) {
            preview.src = e.target.result;
        }
    };
    reader.readAsDataURL(file);
};

// augšupielādēt banera attēlu
const uploadBanner = async () => {
    if (!bannerFile.value) {
        alert(t('adm_artists.edit.image_error_no_file'));
        return;
    }
    isUploadingBanner.value = true;
    const formData = new FormData();
    formData.append('banner', bannerFile.value);
    formData.append('type', 'banner');
    formData.append('_method', 'PUT');
    try {
        const response = await axios.post(route('admin-artists-update-image', { id: props.artist.id }), formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
        if (response.data.success) {
            // atjaunināt parādīto attēlu
            const bannerPreview = document.getElementById('banner-preview');
            if (bannerPreview) {
                bannerPreview.src = response.data.image_url;
            }
            // atjaunināt sākotnējo URL turpmākai atcelšanai
            originalBannerUrl.value = response.data.image_url.replace(/\?t=.*$/, ''); // noņemt timestamp'u
            bannerFile.value = null;
            // notīrīt faila ievadi
            const fileInput = document.getElementById('banner-file-input');
            if (fileInput) fileInput.value = '';
            alert(response.data.message || t('adm_artists.edit.image_success_banner'));
        } else {
            alert(response.data.message || t('adm_artists.edit.image_error_upload'));
        }
    } catch (error) {
        console.error('Upload error:', error);
        alert(error.response?.data?.message || error.response?.data?.errors?.banner?.[0] || t('adm_artists.edit.image_error_upload'));
    } finally {
        isUploadingBanner.value = false;
    }
};

// augšupielādēt profila attēlu
const uploadProfile = async () => {
    if (!profileFile.value) {
        alert(t('adm_artists.edit.image_error_no_file'));
        return;
    }
    isUploadingProfile.value = true;
    const formData = new FormData();
    formData.append('profile', profileFile.value);
    formData.append('type', 'profile');
    formData.append('_method', 'PUT');
    try {
        const response = await axios.post(route('admin-artists-update-image', { id: props.artist.id }), formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
        if (response.data.success) {
            // atjaunināt parādīto attēlu
            const profilePreview = document.getElementById('profile-preview');
            if (profilePreview) {
                profilePreview.src = response.data.image_url;
            }
            // atjaunināt sākotnējo URL turpmākai atcelšanai
            originalProfileUrl.value = response.data.image_url.replace(/\?t=.*$/, ''); // Remove timestamp
            profileFile.value = null;
            // notīrīt faila ievadi
            const fileInput = document.getElementById('profile-file-input');
            if (fileInput) fileInput.value = '';
            alert(response.data.message || t('adm_artists.edit.image_success_profile'));
        } else {
            alert(response.data.message || t('adm_artists.edit.image_error_upload'));
        }
    } catch (error) {
        console.error('Upload error:', error);
        alert(error.response?.data?.message || error.response?.data?.errors?.profile?.[0] || t('adm_artists.edit.image_error_upload'));
    } finally {
        isUploadingProfile.value = false;
    }
};

// atcelt banera augšupielādi
const cancelBannerUpload = () => {
    bannerFile.value = null;
    // atiestatīt uz sākotnējo attēlu
    const preview = document.getElementById('banner-preview');
    if (preview && originalBannerUrl.value) {
        preview.src = originalBannerUrl.value + '?t=' + Date.now(); // oievienot timestamp'u, lai novērstu kešdarbi
    }
    // notīrīt faila ievadi
    const fileInput = document.getElementById('banner-file-input');
    if (fileInput) {
        fileInput.value = '';
        // aktivizēt change event, lai atiestatītu visus listener'us
        fileInput.dispatchEvent(new Event('change'));
    }
};

// atcelt profila augšupielādi
const cancelProfileUpload = () => {
    profileFile.value = null;
    // atiestatīt uz sākotnējo attēlu
    const preview = document.getElementById('profile-preview');
    if (preview && originalProfileUrl.value) {
        preview.src = originalProfileUrl.value + '?t=' + Date.now(); // Add timestamp to prevent caching
    }
    // notīrīt faila ievadi
    const fileInput = document.getElementById('profile-file-input');
    if (fileInput) {
        fileInput.value = '';
        // aktivizēt change event, lai atiestatītu visus listener'us
        fileInput.dispatchEvent(new Event('change'));
    }
};

</script>

<template>
    <AdminLayout>
        <div class="edit-container">
            <div class="edit-header">
                <h1>{{ t('adm_artists.edit.title') }}</h1>
                <div class="edit-actions">
                    <Link :href="route('admin-artists-index')" class="btn-secondary">
                        {{ t('adm_artists.edit.back_to_artists') }}
                    </Link>
                </div>
            </div>

            <div class="edit-layout">
                <!-- Left column: main form -->
                <div class="edit-main">
                    <form @submit.prevent="submit" class="edit-form">
                        <!-- Basic fields -->
                        <div class="form-section">
                            <div class="main-info-header">
                                <h2 class="section-title">{{ t('adm_artists.edit.main_info') }}</h2>
                                <div class="header-buttons">
                                    <button
                                        type="button"
                                        @click="resetForm"
                                        class="btn-secondary"
                                    >
                                        {{ t('adm_artists.edit.reset_btn') }}
                                    </button>
                                    <button type="submit" class="btn-primary" :disabled="form.processing">
                                        {{ form.processing ? t('adm_artists.edit.saving') : t('adm_artists.edit.save_changes') }}
                                    </button>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="name">{{ t('adm_artists.edit.artist_name') }}</label>
                                <input
                                    v-model="form.name"
                                    id="name"
                                    type="text"
                                    maxlength="255"
                                    class="input-field"
                                    :class="{ 'input-error': form.errors.name }"
                                    :placeholder="t('adm_artists.edit.artist_name_placeholder')"
                                >
                                <div v-if="form.errors.name" class="error-message">{{ form.errors.name }}</div>
                                <div class="character-count" :class="{ 'near-limit': form.name.length > 200 }">
                                    {{ form.name.length }}/255 {{ t('adm_artists.edit.characters') }}
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="solo_or_band">{{ t('adm_artists.edit.artist_type') }}</label>
                                    <select
                                        v-model="form.solo_or_band"
                                        id="solo_or_band"
                                        class="input-field"
                                        :class="{ 'input-error': form.errors.solo_or_band }"
                                    >
                                        <option
                                            v-for="option in soloOrBandOptions"
                                            :key="option"
                                            :value="option"
                                        >
                                            {{ t(`adm_artists.edit.type_${option}`) }}
                                        </option>
                                    </select>
                                    <div v-if="form.errors.solo_or_band" class="error-message">{{ form.errors.solo_or_band }}</div>
                                </div>

                                <div class="form-group">
                                    <label for="formed_year">{{ t('adm_artists.edit.formed_year') }}</label>
                                    <select
                                        v-model="form.formed_year"
                                        id="formed_year"
                                        class="input-field"
                                        :class="{ 'input-error': form.errors.formed_year }"
                                    >
                                        <option value="">{{ t('adm_artists.edit.select_year') }}</option>
                                        <option v-for="year in yearOptions" :value="year" :key="`formed-${year}`">
                                            {{ year }}
                                        </option>
                                    </select>
                                    <div v-if="form.errors.formed_year" class="error-message">{{ form.errors.formed_year }}</div>
                                </div>

                                <div class="form-group">
                                    <label for="disbanded_year">{{ t('adm_artists.edit.disbanded_year') }}</label>
                                    <select
                                        v-model="form.disbanded_year"
                                        id="disbanded_year"
                                        class="input-field"
                                        :class="{ 'input-error': form.errors.disbanded_year }"
                                    >
                                        <option value="">{{ t('adm_artists.edit.select_year') }}</option>
                                        <option
                                            v-for="year in disbandedYearOptions"
                                            :key="`disbanded-${year}`"
                                            :value="year"
                                        >
                                            {{ year }}
                                        </option>
                                    </select>
                                    <div v-if="form.errors.disbanded_year" class="error-message">{{ form.errors.disbanded_year }}</div>
                                    <div class="help-text" v-if="form.disbanded_year">
                                        {{ t('adm_artists.edit.disbanded_note') }}
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="is_active">{{ t('adm_artists.edit.activity_status') }}</label>
                                    <select
                                        v-model="form.is_active"
                                        id="is_active"
                                        class="input-field"
                                        :class="{ 'input-error': form.errors.is_active }"
                                    >
                                        <option :value="1">{{ t('adm_artists.edit.active') }}</option>
                                        <option :value="0">{{ t('adm_artists.edit.inactive') }}</option>
                                    </select>
                                    <div v-if="form.errors.is_active" class="error-message">{{ form.errors.is_active }}</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="biography">{{ t('adm_artists.edit.biography_en') }}</label>
                                <textarea
                                    v-model="form.biography"
                                    id="biography"
                                    class="input-field textarea-field"
                                    :class="{ 'input-error': form.errors.biography }"
                                    :placeholder="t('adm_artists.edit.biography_placeholder')"
                                    rows="6"
                                ></textarea>
                                <div v-if="form.errors.biography" class="error-message">{{ form.errors.biography }}</div>
                            </div>

                            <div class="form-group">
                                <label for="biography_lv">{{ t('adm_artists.edit.biography_lv') }}</label>
                                <textarea
                                    v-model="form.biography_lv"
                                    id="biography_lv"
                                    class="input-field textarea-field"
                                    :class="{ 'input-error': form.errors.biography_lv }"
                                    :placeholder="t('adm_artists.edit.biography_placeholder')"
                                    rows="6"
                                ></textarea>
                                <div v-if="form.errors.biography_lv" class="error-message">{{ form.errors.biography_lv }}</div>
                            </div>
                        </div>

                        <!-- Associated content buttons (placeholder) -->
                        <div class="form-section">
                            <h2 class="section-title">{{ t('adm_artists.edit.associated_content') }}</h2>
                            <div class="content-buttons-grid">
                                <button
                                    type="button"
                                    class="content-button"
                                    @click="showGenresModal = true"
                                >
                                    <span class="button-icon">🎵</span>
                                    <span class="button-text">{{ t('adm_artists.edit.view_genres') }}</span>
                                    <span class="button-count">{{ genresList.length }}</span>
                                </button>
                                <button
                                    type="button"
                                    class="content-button"
                                    @click="showReleasesModal = true"
                                >
                                    <span class="button-icon">💿</span>
                                    <span class="button-text">{{ t('adm_artists.edit.view_releases') }}</span>
                                    <span class="button-count">{{ artist.releases.length }}</span>
                                </button>
                                <button
                                    type="button"
                                    class="content-button"
                                    @click="showTracksModal = true"
                                >
                                    <span class="button-icon">🎶</span>
                                    <span class="button-text">{{ t('adm_artists.edit.view_tracks') }}</span>
                                    <span class="button-count">{{ artist.tracks.length }}</span>
                                </button>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-primary" :disabled="form.processing">
                                {{ form.processing ? t('adm_artists.edit.saving') : t('adm_artists.edit.save_changes') }}
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Right column: read-only info and images -->
                <div class="edit-sidebar">
                    <!-- Read-only artist information -->
                    <div class="info-card">
                        <h3 class="info-title">{{ t('adm_artists.edit.meta_info') }}</h3>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_artists.edit.artist_id') }}:</span>
                            <span class="info-value">{{ artist.id }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_artists.edit.slug') }}:</span>
                            <span class="info-value">{{ artist.slug }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_artists.edit.popularity') }}:</span>
                            <span class="info-value popularity-value">{{ formattedPopularity }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_artists.edit.created_at') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(artist.created_at) }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_artists.edit.updated_at') }}:</span>
                            <span class="info-value">{{ formatDateTimeUTC(artist.updated_at) }}</span>
                        </div>
                    </div>

                    <!-- Banner Image Section -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_artists.edit.banner_image') }}</h3>
                        <div class="image-container">
                            <div class="image-preview-square">
                                <img
                                    :src="originalBannerUrl"
                                    :alt="t('adm_artists.edit.banner_alt', { name: artist.name })"
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
                                        {{ t('adm_artists.edit.choose_file') }}
                                    </label>
                                    <span v-if="bannerFile" class="file-name">{{ bannerFile.name }}</span>
                                </div>
                                <div class="upload-buttons" v-if="bannerFile">
                                    <button
                                        @click="uploadBanner"
                                        :disabled="isUploadingBanner"
                                        class="btn-primary btn-sm"
                                    >
                                        {{ isUploadingBanner ? t('adm_artists.edit.uploading') : t('adm_artists.edit.upload') }}
                                    </button>
                                    <button
                                        @click="cancelBannerUpload"
                                        class="btn-secondary btn-sm"
                                    >
                                        {{ t('adm_artists.edit.cancel') }}
                                    </button>
                                </div>
                            </div>
                            <div class="image-info">
                                <div class="image-name">{{ artist.banner_url }}</div>
                                <div class="image-size-info">{{ t('adm_artists.edit.banner_size') }}</div>
                            </div>
                        </div>
                    </div>

                    <!-- Profile Image Section -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_artists.edit.profile_image') }}</h3>
                        <div class="image-container">
                            <div class="image-preview-horizontal">
                                <img
                                    :src="originalProfileUrl"
                                    :alt="t('adm_artists.edit.profile_alt', { name: artist.name })"
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
                                        {{ t('adm_artists.edit.choose_file') }}
                                    </label>
                                    <span v-if="profileFile" class="file-name">{{ profileFile.name }}</span>
                                </div>
                                <div class="upload-buttons" v-if="profileFile">
                                    <button
                                        @click="uploadProfile"
                                        :disabled="isUploadingProfile"
                                        class="btn-primary btn-sm"
                                    >
                                        {{ isUploadingProfile ? t('adm_artists.edit.uploading') : t('adm_artists.edit.upload') }}
                                    </button>
                                    <button
                                        @click="cancelProfileUpload"
                                        class="btn-secondary btn-sm"
                                    >
                                        {{ t('adm_artists.edit.cancel') }}
                                    </button>
                                </div>
                            </div>
                            <div class="image-info">
                                <div class="image-name">{{ artist.profile_url }}</div>
                                <div class="image-size-info">{{ t('adm_artists.edit.profile_size') }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <GenreManagerModal
            :visible="showGenresModal"
            entity-type="artist"
            :entity-id="artist.id"
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

        <RelatedTracksModal
            :visible="showTracksModal"
            :tracks="tracksList"
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

.help-text {
    color: #6b7280;
    font-size: 0.75rem;
    margin-top: 0.25rem;
    font-style: italic;
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
