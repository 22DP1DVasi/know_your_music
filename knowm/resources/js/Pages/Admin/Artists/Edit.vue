<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import { computed, watch, ref } from 'vue';
import dayjs from "dayjs";
import utc from 'dayjs/plugin/utc';

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
const isGenresModalOpen = ref(false);
const isReleasesModalOpen = ref(false);
const isTracksModalOpen = ref(false);

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
    '0.00';

// saskaņotais pasaules laiks (UTC), nevis lokāls laiks
const formatDateTimeUTC = (dateString) => {
    if (!dateString) return 'Unknown';
    return dayjs.utc(dateString).format('YYYY-MM-DD HH:mm:ss');
};

// formatēt ilgumu kā MM: SS
const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const date = new Date(timeString);
    const minutes = String(date.getUTCMinutes()).padStart(2, '0');
    const seconds = String(date.getUTCSeconds()).padStart(2, '0');
    return `${minutes}:${seconds}`;
};

// formatēt rādīšanas datumu
const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    return dayjs(dateString).format('DD/MM/YYYY');
};

// iegūt CSS klasi lomas žetonam
const getRoleClass = (role) => {
    switch (role) {
        case 'primary': return 'role-badge-primary';
        case 'featured': return 'role-badge-featured';
        case 'producer': return 'role-badge-producer';
        default: return 'role-badge-default';
    }
};

// notikums, lai novērstu ritināšanu, kad modāls ir atvērts (WIP)
const handleWheel = (event) => {
    event.stopPropagation();
};

// skatīties modālā stāvokļa izmaiņas, lai novērstu ķermeņa ritināšanu (WIP)
watch([isGenresModalOpen, isReleasesModalOpen, isTracksModalOpen], () => {
    const isAnyModalOpen = isGenresModalOpen.value || isReleasesModalOpen.value || isTracksModalOpen.value;
    if (isAnyModalOpen) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
});

// apstrādāt attēla ielādes kļūdas
const handleImageError = (event, type) => {
    const defaultImages = {
        banner: '/images/default-artist-banner.webp',
        profile: '/images/default-artist-profile.webp'
    };
    event.target.src = defaultImages[type];
};

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_artists.edit.title') }}</h1>
            <div class="form-actions">
                <button
                    type="button"
                    @click="resetForm"
                    class="btn-secondary"
                >
                    {{ t('adm_artists.edit.reset_btn') }}
                </button>
                <button
                    type="submit"
                    class="btn-primary"
                    :disabled="form.processing"
                    @click="submit"
                >
                    {{ t('adm_artists.edit.update_artist_btn') }}
                </button>
            </div>
            <Link :href="route('admin-artists-index')" class="btn-secondary">
                {{ t('adm_artists.edit.back_to_artists') }}
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <!-- Izpildītāja vārds -->
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
                        <div v-if="form.errors.name" class="error-message">
                            {{ form.errors.name }}
                        </div>
                        <div class="character-count" :class="{ 'near-limit': form.name.length > 200 }">
                            {{ form.name.length }}/255 {{ t('adm_artists.edit.characters') }}
                        </div>
                    </div>

                    <!-- Tips -->
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
                        <div v-if="form.errors.solo_or_band" class="error-message">
                            {{ form.errors.solo_or_band }}
                        </div>
                    </div>

                    <!-- Karjeras sākšanas gads -->
                    <div class="form-group">
                        <label for="formed_year">{{ t('adm_artists.edit.formed_year') }}</label>
                        <select
                            v-model="form.formed_year"
                            id="formed_year"
                            class="input-field"
                            :class="{ 'input-error': form.errors.formed_year }"
                        >
                            <option value="">{{ t('adm_artists.edit.select_year') }}</option>
                            <option v-for="year in yearOptions"
                                    :value="year"
                                    :key="`formed-${year}`">
                                {{ year }}
                            </option>
                        </select>
                        <div v-if="form.errors.formed_year" class="error-message">
                            {{ form.errors.formed_year }}
                        </div>
                    </div>

                    <!-- Karjeras beigu gads -->
                    <div class="form-group">
                        <label for="disbanded_year">{{ t('adm_artists.edit.disbanded_year') }}</label>
                        <select
                            v-model="form.disbanded_year"
                            id="disbanded_year"
                            class="input-field"
                            :class="{ 'input-error': form.errors.disbanded_year }"
                        >
                            <option value="">
                                {{ t('adm_artists.edit.select_year') }}
                            </option>
                            <option
                                v-for="year in disbandedYearOptions"
                                :key="`disbanded-${year}`"
                                :value="year"
                            >
                                {{ year }}
                            </option>
                        </select>
                        <div v-if="form.errors.disbanded_year" class="error-message">
                            {{ form.errors.disbanded_year }}
                        </div>
                        <div class="help-text" v-if="form.disbanded_year">
                            {{ t('adm_artists.edit.disbanded_note') }}
                        </div>
                    </div>

                    <!-- Aktivitātes statuss -->
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
                        <div v-if="form.errors.is_active" class="error-message">
                            {{ form.errors.is_active }}
                        </div>
                    </div>

                    <!-- Biogrāfija angļu valodā -->
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
                        <div v-if="form.errors.biography" class="error-message">
                            {{ form.errors.biography }}
                        </div>
                    </div>

                    <!-- Biogrāfija latviešu valodā -->
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
                        <div v-if="form.errors.biography_lv" class="error-message">
                            {{ form.errors.biography_lv }}
                        </div>
                    </div>

                    <!-- Saistītā satura pogas -->
                    <div class="content-buttons-group">
                        <h3 class="content-buttons-title">{{ t('adm_artists.edit.associated_content') }}</h3>
                        <div class="content-buttons-grid">
                            <button
                                type="button"
                                class="btn-secondary content-button"
                                @click="isGenresModalOpen = true"
                            >
                                <span class="button-icon">🎵</span>
                                <span class="button-text">{{ t('adm_artists.edit.view_genres') }}</span>
                                <span class="button-count">{{ artist.genres.length }}</span>
                            </button>
                            <button
                                type="button"
                                class="btn-secondary content-button"
                                @click="isReleasesModalOpen = true"
                            >
                                <span class="button-icon">💿</span>
                                <span class="button-text">{{ t('adm_artists.edit.view_releases') }}</span>
                                <span class="button-count">{{ artist.releases.length }}</span>
                            </button>
                            <button
                                type="button"
                                class="btn-secondary content-button"
                                @click="isTracksModalOpen = true"
                            >
                                <span class="button-icon">🎶</span>
                                <span class="button-text">{{ t('adm_artists.edit.view_tracks') }}</span>
                                <span class="button-count">{{ artist.tracks.length }}</span>
                            </button>
                        </div>
                    </div>

                    <!-- Informācija (tikai lasāma) -->
                    <div class="artist-info-section">
                        <h3 class="info-section-title">{{ t('adm_artists.edit.artist_info') }}</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.artist_id') }}:</span>
                                <span class="info-value">{{ artist.id }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.slug') }}:</span>
                                <span class="info-value">{{ artist.slug }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.popularity') }}:</span>
                                <span class="info-value popularity-value">{{ formattedPopularity }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.created_at') }}:</span>
                                <span class="info-value">{{ formatDateTimeUTC(artist.created_at) }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.updated_at') }}:</span>
                                <span class="info-value">{{ formatDateTimeUTC(artist.updated_at) }}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Izpildītāju attēlu displejs -->
                    <div class="images-display-group">
                        <h3 class="images-display-title">{{ t('adm_artists.edit.artist_images') }}</h3>
                        <div class="images-display-stack">
                            <!-- Banera attēls -->
                            <div class="image-container">
                                <div class="image-header">
                                    <div class="image-label">{{ t('adm_artists.edit.banner_image') }}</div>
                                </div>
                                <div class="image-content">
                                    <div class="image-preview-square">
                                        <img
                                            :src="artist.banner_url"
                                            :alt="t('adm_artists.edit.banner_alt', { name: artist.name })"
                                            class="image-preview"
                                            @error="handleImageError($event, 'banner')"
                                        />
                                    </div>

                                    <div class="image-info">
                                        <div class="image-name">{{ artist.banner_url }}</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Profila attēls -->
                            <div class="image-container">
                                <div class="image-header">
                                    <div class="image-label">{{ t('adm_artists.edit.profile_image') }}</div>
                                </div>
                                <div class="image-content">
                                    <div class="image-preview-horizontal">
                                        <img
                                            :src="artist.profile_url"
                                            :alt="t('adm_artists.edit.profile_alt', { name: artist.name })"
                                            class="image-preview"
                                            @error="handleImageError($event, 'profile')"
                                        />
                                    </div>

                                    <div class="image-info">
                                        <div class="image-name">{{ artist.profile_url }}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </form>
        </div>

        <!-- Modālais logs žanriem -->
        <div v-if="isGenresModalOpen" class="modal-overlay" @wheel="handleWheel" @touchmove.prevent @scroll.prevent>
            <div class="modal">
                <div class="modal-header">
                    <h2>{{ t('adm_artists.edit.genres_modal_title') }}</h2>
                    <button class="modal-close" @click="isGenresModalOpen = false">×</button>
                </div>

                <div class="modal-body">
                    <div class="modal-table-container">
                        <div class="modal-table-header">
                            <div class="modal-table-row">
                                <div class="modal-table-cell modal-table-cell-name">
                                    {{ t('adm_artists.edit.genre_name') }}
                                </div>
                            </div>
                        </div>

                        <!--  :href="route('admin-genres-edit', { id: genre.id })" -->
                        <div class="modal-table-body">
                            <Link
                                v-for="genre in artist.genres"
                                :key="genre.id"
                                :href="route('admin-dashboard')"
                                class="modal-table-row clickable-row"
                            >
                                <div class="modal-table-cell modal-table-cell-name">
                                    {{ genre.name }}
                                </div>
                            </Link>

                            <div v-if="!artist.genres || artist.genres.length === 0" class="modal-table-empty">
                                {{ t('adm_artists.edit.no_genres') }}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn-secondary" @click="isGenresModalOpen = false">
                        {{ t('adm_artists.edit.modal_close') }}
                    </button>
                </div>
            </div>
        </div>

        <!-- Modālais logs albumiem (releases) -->
        <div v-if="isReleasesModalOpen" class="modal-overlay" @wheel="handleWheel" @touchmove.prevent @scroll.prevent>
            <div class="modal">
                <div class="modal-header">
                    <h2>{{ t('adm_artists.edit.releases_modal_title') }}</h2>
                    <button class="modal-close" @click="isReleasesModalOpen = false">×</button>
                </div>

                <div class="modal-body">
                    <div class="modal-table-container">
                        <div class="modal-table-header">
                            <div class="modal-table-row">
                                <div class="modal-table-cell modal-table-cell-name">
                                    {{ t('adm_artists.edit.release_title') }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-type">
                                    {{ t('adm_artists.edit.release_type') }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-date">
                                    {{ t('adm_artists.edit.release_date') }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-role">
                                    {{ t('adm_artists.edit.release_role') }}
                                </div>
                            </div>
                        </div>

                        <!--  :href="route('admin-releases-edit', { id: release.id })" -->
                        <div class="modal-table-body">
                            <Link
                                v-for="release in artist.releases"
                                :key="release.id"
                                :href="route('admin-dashboard')"
                                class="modal-table-row clickable-row"
                            >
                                <div class="modal-table-cell modal-table-cell-name">
                                    {{ release.title }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-type">
                                    {{ release.release_type }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-date">
                                    {{ formatDate(release.release_date) }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-role">
                                    <span :class="['role-badge', getRoleClass(release.role)]">
                                        {{ t(`artists.global.${release.role}`) }}
                                    </span>
                                </div>
                            </Link>

                            <div v-if="!artist.releases || artist.releases.length === 0" class="modal-table-empty">
                                {{ t('adm_artists.edit.no_releases') }}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn-secondary" @click="isReleasesModalOpen = false">
                        {{ t('adm_artists.edit.modal_close') }}
                    </button>
                </div>
            </div>
        </div>

        <!-- Modālais logs dziesmām -->
        <div v-if="isTracksModalOpen" class="modal-overlay" @wheel="handleWheel" @touchmove.prevent @scroll.prevent>
            <div class="modal">
                <div class="modal-header">
                    <h2>{{ t('adm_artists.edit.tracks_modal_title') }}</h2>
                    <button class="modal-close" @click="isTracksModalOpen = false">×</button>
                </div>

                <div class="modal-body">
                    <div class="modal-table-container">
                        <div class="modal-table-header">
                            <div class="modal-table-row">
                                <div class="modal-table-cell modal-table-cell-name">
                                    {{ t('adm_artists.edit.track_title') }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-duration">
                                    {{ t('adm_artists.edit.track_duration') }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-role">
                                    {{ t('adm_artists.edit.track_role') }}
                                </div>
                            </div>
                        </div>

                        <!--  :href="route('admin-tracks-edit', { id: track.id })" -->
                        <div class="modal-table-body">
                            <Link
                                v-for="track in artist.tracks"
                                :key="track.id"
                                :href="route('admin-dashboard')"
                                class="modal-table-row clickable-row"
                            >
                                <div class="modal-table-cell modal-table-cell-name">
                                    {{ track.title }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-duration">
                                    {{ formatDuration(track.duration) }}
                                </div>
                                <div class="modal-table-cell modal-table-cell-role">
                                    <span :class="['role-badge', getRoleClass(track.role)]">
                                        {{ t(`artists.global.${track.role}`) }}
                                    </span>
                                </div>
                            </Link>

                            <div v-if="!artist.tracks || artist.tracks.length === 0" class="modal-table-empty">
                                {{ t('adm_artists.edit.no_tracks') }}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn-secondary" @click="isTracksModalOpen = false">
                        {{ t('adm_artists.edit.modal_close') }}
                    </button>
                </div>
            </div>
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

.character-count.at-limit {
    color: #ef4444;
    font-weight: 500;
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

.content-buttons-group {
    background-color: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    padding: 1.5rem;
    margin-top: 1rem;
    grid-column: 1 / -1;
}

.content-buttons-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #e5e7eb;
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
    padding: 1.5rem 1rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    background-color: white;
    color: #374151;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    text-align: center;
}

.content-button:hover {
    background-color: #f3f4f6;
    border-color: #d1d5db;
    transform: translateY(-2px);
}

.button-icon {
    font-size: 2rem;
    margin-bottom: 0.5rem;
}

.button-text {
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 0.25rem;
}

.button-count {
    font-size: 0.875rem;
    color: #6b7280;
    background-color: #f3f4f6;
    padding: 0.125rem 0.5rem;
    border-radius: 9999px;
}

.artist-info-section {
    background-color: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    padding: 1.5rem;
    margin-top: 1rem;
    grid-column: 1 / -1;
}

.info-section-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #e5e7eb;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
}

.info-item {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.info-label {
    font-size: 0.875rem;
    color: #6b7280;
    font-weight: 500;
}

.info-value {
    font-size: 0.875rem;
    color: #374151;
    font-weight: 600;
}

.info-value.popularity-value {
    font-family: monospace;
    color: #059669;
    font-size: 1rem;
}

.images-display-group {
    background-color: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    padding: 1.5rem;
    margin-top: 1rem;
    grid-column: 1 / -1;
}

.images-display-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #e5e7eb;
}

.images-display-stack {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.image-content {
    display: flex;
    gap: 1.5rem;
    align-items: flex-start;
}

.image-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.image-label {
    font-size: 1rem;
    font-weight: 600;
    color: #374151;
}

.image-preview {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

.image-preview:hover {
    transform: scale(1.02);
}

/* Banera kvadrātveida priekšskatījums */
.image-preview-square {
    flex-shrink: 0;
    width: 250px;
    height: 250px;
    border: 2px solid #e5e7eb;
    border-radius: 0.375rem;
    overflow: hidden;
    background-color: white;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* Profila horizontālais priekšskatījums */
.image-preview-horizontal {
    flex-shrink: 0;
    width: 250px;
    height: 166px;   /* 3:2 proporcijas */
    border: 2px solid #e5e7eb;
    border-radius: 0.375rem;
    overflow: hidden;
    background-color: white;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.image-info {
    background-color: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    padding: 0.75rem;
}

.image-name {
    font-size: 0.875rem;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.25rem;
}

/* Modālo logu stili */
.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 2000;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    touch-action: none;
}

.modal {
    background: white;
    width: 100%;
    max-width: 800px;
    border-radius: 0.5rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    display: flex;
    flex-direction: column;
    max-height: 90vh;
}

.modal-header,
.modal-footer {
    padding: 1rem;
    border-bottom: 1px solid #e5e7eb;
    flex-shrink: 0;
}

.modal-footer {
    border-top: 1px solid #e5e7eb;
    border-bottom: none;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.modal-body {
    padding: 1rem;
    overflow-y: auto;
    flex: 1;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.25rem;
    cursor: pointer;
    color: #6b7280;
}

.modal-close:hover {
    color: #374151;
}

/* Modālu logu tabula */
.modal-table-container {
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    overflow: hidden;
    background-color: white;
}

.modal-table-header {
    background-color: #f9fafb;
    border-bottom: 1px solid #e5e7eb;
}

.modal-table-body {
    overflow: visible;
}

.modal-table-body a {
    text-decoration: none;
    color: inherit;
}

.modal-table-row {
    display: flex;
    align-items: center;
    min-height: 3rem;
    border-bottom: 1px solid #f3f4f6;
    position: relative;
}

.modal-table-row:last-child {
    border-bottom: none;
}

.modal-table-row:hover {
    background-color: #f9fafb;
}

.clickable-row {
    text-decoration: none;
    color: inherit;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.clickable-row:hover {
    background-color: #e0f2fe !important;
}

.clickable-row .modal-table-cell {
    text-decoration: none;
}

.modal-table-cell {
    padding: 0.75rem 1rem;
    font-size: 0.875rem;
    color: #374151;
    display: flex;
    align-items: center;
    min-height: 3rem;
    overflow: hidden;
}

.modal-table-cell-name {
    flex: 3;
    min-width: 250px;
    max-width: 400px;
    word-break: break-word;
}

.modal-table-cell-type {
    flex: 1;
    min-width: 100px;
    max-width: 150px;
}

.modal-table-cell-date {
    flex: 1;
    min-width: 100px;
    max-width: 120px;
    font-family: monospace;
    font-size: 0.8125rem;
}

.modal-table-cell-role {
    flex: 1;
    min-width: 100px;
    max-width: 120px;
}

.role-badge {
    display: inline-block;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
    font-size: 0.75rem;
    font-weight: 500;
    text-transform: capitalize;
}

.role-badge-primary {
    background-color: #dbeafe;
    color: #1e40af;
    border: 1px solid #bfdbfe;
}

.role-badge-featured {
    background-color: #f0f9ff;
    color: #0c4a6e;
    border: 1px solid #bae6fd;
}

.role-badge-producer {
    background-color: #f0fdf4;
    color: #166534;
    border: 1px solid #bbf7d0;
}

.role-badge-default {
    background-color: #f3f4f6;
    color: #374151;
    border: 1px solid #e5e7eb;
}

.modal-table-cell-duration {
    flex: 1;
    min-width: 80px;
    max-width: 100px;
    font-family: monospace;
    font-size: 0.8125rem;
}

.modal-table-empty {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
    color: #9ca3af;
    font-style: italic;
    font-size: 0.875rem;
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

    .info-grid {
        grid-template-columns: 1fr;
    }

    .image-preview-square,
    .image-preview-horizontal {
        width: 100%;
        max-width: 250px;
    }

    .image-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.5rem;
    }

    .content-buttons-grid {
        grid-template-columns: 1fr;
    }

    .modal {
        width: 95%;
        max-height: 95vh;
    }

    .modal-table-row {
        flex-direction: column;
        align-items: flex-start;
        padding: 1rem;
        gap: 0.5rem;
    }

    .modal-table-cell {
        padding: 0.25rem 0;
        border-bottom: 1px solid #f3f4f6;
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        flex: none;
        justify-content: flex-start;
    }

    .modal-table-cell:last-child {
        border-bottom: none;
    }

    .modal-table-cell-name {
        font-weight: 600;
        order: 1;
    }

    .modal-table-cell-type,
    .modal-table-cell-date,
    .modal-table-cell-duration {
        color: #4b5563;
        order: 2;
        font-size: 0.75rem;
    }

    .modal-table-cell-role {
        min-width: 80px;
        max-width: 100px;
        font-size: 0.75rem;
    }

    .role-badge {
        padding: 0.125rem 0.375rem;
        font-size: 0.7rem;
    }
}

@media (max-width: 625px) {
    .image-content {
        flex-direction: column;
        align-items: flex-start;
    }

    .image-info {
        width: 100%;
        margin-top: 0.75rem;
    }
}

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }

    .image-preview-square {
        max-width: 200px;
        height: 200px;
    }

    .image-preview-horizontal {
        max-width: 200px;
        height: 133px;
    }
}

</style>
