<script setup>
import { ref, computed, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import axios from 'axios';
import { route } from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    show: {
        type: Boolean,
        default: false
    },
    track: {
        type: Object,
        required: true
    }
});

const emit = defineEmits(['close', 'added']);

// stāvokļi
const playlists = ref([]);
const isLoading = ref(false);
const isAddingToPlaylist = ref(null);
const isCreating = ref(false);
const showCreateForm = ref(false);

// kolekcijas izveidošanas forma
const newPlaylistForm = ref({
    name: '',
    is_private: false
});

const errors = ref({
    name: null
});

// ielādēt lietotāja kolekcijas
const fetchPlaylists = async () => {
    isLoading.value = true;
    try {
        const response = await axios.get(route('playlists.user.list'), {
            params: {
                track_id: props.track.id
            }
        });
        playlists.value = response.data.playlists;
    } catch (error) {
        console.error('Error fetching playlists:', error);
    } finally {
        isLoading.value = false;
    }
};

const close = () => {
    emit('close');
};

// pievienot dziesmu kolekcijai
const selectPlaylist = async (playlist) => {
    if (isAddingToPlaylist.value) return;
    // novērst dublikātus
    if (playlist.contains_track) {
        return;
    }
    isAddingToPlaylist.value = playlist.id;
    try {
        await axios.post(route('playlists.add-track', playlist.slug), {
            track_id: props.track.id
        });
        // atjaunināt UI
        playlist.contains_track = true;
        emit('added', { playlist, track: props.track });
    } catch (error) {
        console.error('Error adding track to playlist:', error);
        alert(t('user_pages.playlists.add_error'));
    } finally {
        isAddingToPlaylist.value = null;
    }
};

const openCreateForm = () => {
    showCreateForm.value = true;
};

const closeCreateForm = () => {
    showCreateForm.value = false;
    newPlaylistForm.value = { name: '', is_private: false };
    errors.value = { name: null };
};

// izveidot jaunu kolekciju un pievienot dziesmu
const createAndAddPlaylist = async () => {
    // Validācija
    if (!newPlaylistForm.value.name.trim()) {
        errors.value.name = t('user_pages.playlists.error_name_required');
        return;
    }
    if (newPlaylistForm.value.name.length > 100) {
        errors.value.name = t('user_pages.playlists.error_name_length');
        return;
    }
    isCreating.value = true;
    try {
        const response = await axios.post(route('playlists.store'), {
            name: newPlaylistForm.value.name.trim(),
            is_private: newPlaylistForm.value.is_private,
            track_id: props.track.id
        });
        emit('added', { playlist: response.data.playlist, track: props.track });
        closeCreateForm();
        close();
    } catch (error) {
        console.error('Error creating playlist:', error);
        if (error.response?.data?.errors) {
            errors.value = error.response.data.errors;
        } else {
            alert(t('user_pages.playlists.create_error'));
        }
    } finally {
        isCreating.value = false;
    }
};

// kad mod. logs atveras, ielādē sarakstus
watch(() => props.show, (newVal) => {
    if (newVal) {
        fetchPlaylists();
    }
});

</script>

<template>
    <Teleport to="body">
        <div v-if="show" class="modal-overlay" @click.self="close">
            <div class="modal-container">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <i class="fa-solid fa-plus-circle"></i>
                        {{ t('user_pages.playlists.add_to_playlist') }}
                        <span v-if="track" class="track-name">"{{ track.title }}"</span>
                    </h3>
                    <button @click="close" class="modal-close-button">
                        <i class="fa-solid fa-times"></i>
                    </button>
                </div>

                <div class="modal-body">
                    <!-- Ielādes indikators -->
                    <div v-if="isLoading" class="loading-state">
                        <i class="fa-solid fa-spinner fa-spin"></i>
                        <span>{{ t('user_pages.playlists.loading') }}</span>
                    </div>

                    <!-- Kolekciju saraksts -->
                    <template v-else>
                        <div class="playlists-list" :class="{ 'has-search': playlists.length > 5 }">
                            <div
                                v-for="playlist in playlists"
                                :key="playlist.id"
                                class="playlist-item"
                                :class="{ 'disabled': playlist.contains_track }"
                                @click="selectPlaylist(playlist)"
                            >
                                <div class="playlist-cover">
                                    <img
                                        :src="playlist.cover_url || '/images/default-playlist-banner.webp'"
                                        :alt="playlist.name"
                                        loading="lazy"
                                    >
                                </div>

                                <div class="playlist-info">
                                    <div class="playlist-name">{{ playlist.name }}</div>
                                    <div class="playlist-meta">
                                        <span class="track-count">{{ playlist.tracks_count || 0 }} {{ t('user_pages.playlists.tracks') }}</span>
                                        <span class="privacy-badge" :class="playlist.is_private ? 'private' : 'public'">
                                            <i :class="playlist.is_private ? 'fa-solid fa-lock' : 'fa-solid fa-globe'"></i>
                                            <span>{{ playlist.is_private ? t('user_pages.playlists.private') : t('user_pages.playlists.public') }}</span>
                                        </span>
                                    </div>
                                </div>

                                <div class="playlist-add-icon">
                                    <i
                                        v-if="isAddingToPlaylist === playlist.id"
                                        class="fa-solid fa-spinner fa-spin"
                                    ></i>

                                    <i
                                        v-else-if="playlist.contains_track"
                                        class="fa-solid fa-bookmark"
                                    ></i>

                                    <i
                                        v-else
                                        class="fa-regular fa-bookmark"
                                    ></i>
                                </div>
                            </div>

                            <!-- Tukšs stāvoklis -->
                            <div v-if="playlists.length === 0" class="empty-state">
                                <i class="fa-regular fa-list-empty"></i>
                                <p>{{ t('user_pages.playlists.no_playlists') }}</p>
                            </div>
                        </div>
                    </template>
                </div>

                <div class="modal-footer">
                    <button @click="close" class="cancel-button" :disabled="isAddingToPlaylist || isCreating">
                        {{ t('user_pages.playlists.cancel') }}
                    </button>
                    <button
                        @click="openCreateForm"
                        class="create-button"
                        :disabled="isAddingToPlaylist || isCreating"
                    >
                        <i class="fa-solid fa-plus"></i>
                        {{ t('user_pages.playlists.create_new') }}
                    </button>
                </div>
            </div>
        </div>
    </Teleport>

    <!-- Jaunas kolekcijas izveides veidlapa -->
    <Teleport to="body">
        <div v-if="showCreateForm" class="modal-overlay" @click.self="closeCreateForm">
            <div class="modal-container modal-small">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <i class="fa-solid fa-plus"></i>
                        {{ t('user_pages.playlists.create_new_playlist') }}
                    </h3>
                    <button @click="closeCreateForm" class="modal-close-button">
                        <i class="fa-solid fa-times"></i>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">
                            {{ t('user_pages.playlists.playlist_name') }} <span class="required">*</span>
                        </label>
                        <input
                            v-model="newPlaylistForm.name"
                            type="text"
                            class="form-input"
                            :class="{ 'error': errors.name }"
                            maxlength="100"
                            :placeholder="t('user_pages.playlists.playlist_name_placeholder')"
                            autofocus
                        >
                        <div v-if="errors.name" class="error-message">{{ errors.name }}</div>
                        <div class="char-counter">{{ newPlaylistForm.name.length }}/100</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">{{ t('user_pages.playlists.privacy') }}</label>
                        <div class="privacy-toggle-compact">
                            <button
                                type="button"
                                class="toggle-option-compact"
                                :class="{ 'active': !newPlaylistForm.is_private }"
                                @click="newPlaylistForm.is_private = false"
                            >
                                <i class="fa-solid fa-globe"></i>
                                <span>{{ t('user_pages.playlists.public') }}</span>
                            </button>
                            <button
                                type="button"
                                class="toggle-option-compact"
                                :class="{ 'active': newPlaylistForm.is_private }"
                                @click="newPlaylistForm.is_private = true"
                            >
                                <i class="fa-solid fa-lock"></i>
                                <span>{{ t('user_pages.playlists.private') }}</span>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button @click="closeCreateForm" class="cancel-button" :disabled="isCreating">
                        {{ t('user_pages.playlists.cancel') }}
                    </button>
                    <button
                        @click="createAndAddPlaylist"
                        class="create-button"
                        :disabled="!newPlaylistForm.name.trim() || isCreating"
                        :class="{ 'loading': isCreating }"
                    >
                        <span v-if="isCreating">
                            <i class="fa-solid fa-spinner fa-spin"></i>
                            {{ t('user_pages.playlists.creating') }}
                        </span>
                        <span v-else>
                            <i class="fa-solid fa-plus"></i>
                            {{ t('user_pages.playlists.create_and_add') }}
                        </span>
                    </button>
                </div>
            </div>
        </div>
    </Teleport>
</template>

<style scoped>
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(5px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    animation: fadeIn 0.2s ease;
}

.modal-container {
    background: white;
    border-radius: 16px;
    width: 90%;
    max-width: 400px;
    max-height: 85vh;
    display: flex;
    flex-direction: column;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    animation: slideUp 0.3s ease;
}

.modal-container.modal-small {
    max-width: 420px;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 1.25rem;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
    flex-shrink: 0;
}

.modal-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #333;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.modal-title i {
    color: #0c4baa;
}

.track-name {
    font-size: 0.85rem;
    font-weight: 400;
    color: #0c4baa;
    background: rgba(12, 75, 170, 0.1);
    padding: 0.2rem 0.5rem;
    border-radius: 20px;
}

.modal-close-button {
    background: none;
    border: none;
    color: #666;
    font-size: 1rem;
    cursor: pointer;
    padding: 0.4rem;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
}

.modal-close-button:hover {
    background: rgba(0, 0, 0, 0.05);
    color: #0c4baa;
}

.modal-body {
    flex: 1;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    padding: 0;
}

.loading-state {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    padding: 2rem;
    color: #0c4baa;
}

.search-wrapper {
    padding: 1rem 1.25rem 0.5rem 1.25rem;
    flex-shrink: 0;
}

.search-input {
    width: 100%;
    padding: 0.6rem 0.75rem;
    border: 1px solid #ddd;
    border-radius: 30px;
    font-size: 0.85rem;
    transition: all 0.2s ease;
    background: #f9fafb;
}

.search-input:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
    background: white;
}

.playlists-list {
    flex: 1;
    overflow-y: auto;
    padding: 0.5rem 0 1rem 0;
}

.playlists-list.has-search {
    padding-top: 0;
}

.playlist-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1.25rem;
    cursor: pointer;
    transition: all 0.2s ease;
    border-bottom: 1px solid rgba(12, 75, 170, 0.05);
}

.playlist-item:hover {
    background: rgba(12, 75, 170, 0.05);
}

.playlist-item.disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.playlist-cover {
    width: 48px;
    height: 48px;
    flex-shrink: 0;
    border-radius: 8px;
    overflow: hidden;
    background: #f0f0f0;
}

.playlist-cover img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.playlist-info {
    flex: 1;
    min-width: 0;
}

.playlist-name {
    font-size: 0.95rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 0.25rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.playlist-meta {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.track-count {
    font-size: 0.7rem;
    color: #666;
}

.privacy-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    font-size: 0.65rem;
    padding: 0.15rem 0.4rem;
    border-radius: 20px;
    font-weight: 500;
}

.privacy-badge i {
    font-size: 0.6rem;
}

.privacy-badge.public {
    background: rgba(34, 197, 94, 0.1);
    color: #16a34a;
    border: 1px solid rgba(34, 197, 94, 0.2);
}

.privacy-badge.private {
    background: rgba(239, 68, 68, 0.1);
    color: #dc2626;
    border: 1px solid rgba(239, 68, 68, 0.2);
}

.playlist-add-icon {
    flex-shrink: 0;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0c4baa;
    font-size: 1rem;
}

.empty-state {
    text-align: center;
    padding: 2rem 1.5rem;
    color: #666;
}

.empty-state i {
    font-size: 2.5rem;
    margin-bottom: 0.5rem;
    opacity: 0.5;
}

.empty-state p {
    font-size: 0.85rem;
    margin: 0;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
    padding: 1rem 1.25rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
    flex-shrink: 0;
}

.cancel-button {
    padding: 0.45rem 1rem;
    background: white;
    border: 1px solid #ddd;
    border-radius: 30px;
    color: #666;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.cancel-button:hover:not(:disabled) {
    background: #f5f5f5;
    border-color: #999;
}

.cancel-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.create-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.45rem 1rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border: none;
    border-radius: 30px;
    color: white;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.create-button:hover:not(:disabled) {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.3);
}

.create-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.create-button.loading {
    opacity: 0.8;
}

.form-group {
    margin: 0 1rem 1.25rem;
}

.form-label {
    display: block;
    font-size: 0.85rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 0.5rem;
}

.required {
    color: #dc2626;
}

.form-input {
    width: 100%;
    padding: 0.6rem 0.75rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 0.9rem;
    transition: all 0.2s ease;
}

.form-input:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
}

.form-input.error {
    border-color: #dc2626;
}

.error-message {
    color: #dc2626;
    font-size: 0.75rem;
    margin-top: 0.25rem;
}

.char-counter {
    font-size: 0.7rem;
    color: #666;
    text-align: right;
    margin-top: 0.25rem;
}

.privacy-toggle-compact {
    display: flex;
    gap: 0.5rem;
}

.toggle-option-compact {
    flex: 1;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.35rem;
    padding: 0.5rem 0.75rem;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 30px;
    color: #666;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.toggle-option-compact.active {
    background: white;
    border-color: #0c4baa;
    color: #0c4baa;
}

.toggle-option-compact.active:first-of-type {
    border-color: #16a34a;
    color: #16a34a;
}

.toggle-option-compact.active:last-of-type {
    border-color: #dc2626;
    color: #dc2626;
}

/* Animācijas */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.playlists-list::-webkit-scrollbar {
    width: 4px;
}

.playlists-list::-webkit-scrollbar-track {
    background: rgba(12, 75, 170, 0.05);
    border-radius: 4px;
}

.playlists-list::-webkit-scrollbar-thumb {
    background: rgba(12, 75, 170, 0.3);
    border-radius: 4px;
}

/* Mobilā versija */
@media (max-width: 640px) {
    .modal-container {
        width: 95%;
        max-height: 80vh;
    }

    .playlist-item {
        padding: 0.625rem 1rem;
    }

    .playlist-cover {
        width: 40px;
        height: 40px;
    }
}

</style>
