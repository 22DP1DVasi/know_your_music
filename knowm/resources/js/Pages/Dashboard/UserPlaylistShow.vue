<script setup>
import { Head, usePage, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { useDate } from '@/composables/useDate';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import TrackCard from '@/Components/Tracks/TrackCard.vue';
import AddToPlaylistModal from "@/Components/Playlists/AddToPlaylistModal.vue";
import { useConfirm } from '@/composables/useConfirm';
import { route } from "ziggy-js";

const { t } = useI18n();
const { formatDateLL } = useDate();
const { confirm } = useConfirm();

const props = defineProps({
    playlist: Object,
    tracks: Object,
    canEdit: Boolean
});

// piekļuve koplietojamiem datiem no servera puses
const page = usePage();
const user = page.props.auth?.user;

// stāvoklis bezgalīgai ritināšanai
const currentPageFromUrl = new URLSearchParams(window.location.search).get('page') || 1;
const displayedTracks = ref([]);
const currentPage = ref(1);
const lastPage = ref(props.tracks.last_page);
const totalTracks = ref(props.tracks.total);
const isLoading = ref(false);
const trackListRef = ref(null);
const loadTrigger = ref(null);
const isInitializing = ref(true);

// izvēlnes stāvoklis dziesmu kartēm
const openMenuId = ref(null);

// rediģēšanas mod. loga stāvoklis
const showEditModal = ref(false);
const isSaving = ref(false);

// rediģēšanas forma
const editForm = ref({
    name: props.playlist.name || '',
    description: props.playlist.description || '',
    is_private: props.playlist.is_private || false
});

// refs priekš modālajam logam priekš dziesmas pievienošanas kolekcijām
const showPlaylistModal = ref(false);
const selectedTrack = ref(null);

const openAddToPlaylistModal = (track) => {
    if (!user) {
        router.get(route('login'));
        return;
    }
    selectedTrack.value = track;
    showPlaylistModal.value = true;
};

const closeModal = () => {
    showPlaylistModal.value = false
    selectedTrack.value = null
};

// kļūdu apstrāde
const editErrors = ref({
    name: null,
    description: null,
    general: null
});

onMounted(async () => {
    const targetPage = parseInt(currentPageFromUrl)
    for (let page = 1; page <= targetPage; page++) {
        await loadPage(page)
    }
    isInitializing.value = false
    setupObserver()
})

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});

const loadPage = (page) => {
    return new Promise((resolve) => {
        router.get(
            route('playlists.show', {
                user: props.playlist.user.slug,
                playlist: props.playlist.slug,
                page
            }),
            {},
            {
                preserveState: true,
                preserveScroll: true,
                replace: true,
                only: ['tracks'],
                onSuccess: (pageData) => {
                    displayedTracks.value.push(...pageData.props.tracks.data)
                    currentPage.value = page
                    resolve()
                }
            }
        )
    })
}

const loadMoreTracks = async () => {
    if (isLoading.value) return
    if (currentPage.value >= lastPage.value) return
    isLoading.value = true
    const nextPage = currentPage.value + 1
    await loadPage(nextPage)
    isLoading.value = false
}

const setupObserver = () => {
    const observer = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting) {
            loadMoreTracks()
        }
    }, {
        rootMargin: '400px'
    })

    observer.observe(loadTrigger.value)
}

const handleScroll = () => {
    if (!nextPage.value || isLoading.value) return;
    const scrollPosition = window.innerHeight + window.scrollY;
    const threshold = document.documentElement.scrollHeight - 600;
    if (scrollPosition >= threshold) {
        loadMoreTracks();
    }
};

const handleTrackClick = (track) => {
    router.get(`/tracks/${track.slug}`);
};

// izņemt dziesmu no kolekcijas
const handleRemoveTrack = async (track) => {
    const confirmed = await confirm({
        title: t('user_pages.playlistshow.remove_track_conf_title'),
        message: t('user_pages.playlistshow.remove_track_conf_message', { name: track.title }),
        confirmText: t('user_pages.playlistshow.remove_track_conf_confirm'),
        cancelText: t('user_pages.playlistshow.remove_track_conf_cancel')
    })

    if (!confirmed) return
    try {
        await axios.delete(route('playlists.tracks.destroy', {
            user: user.slug,
            playlist: props.playlist.slug,
            track: track.id
        }));
        // noņemt no parādītajām dziesmām
        displayedTracks.value = displayedTracks.value.filter(t => t.id !== track.id);
        // noņemt no sākotnējās datu kopas
        props.tracks.data = props.tracks.data.filter(t => t.id !== track.id);
        // pārrēķināt indeksus
        displayedTracks.value = displayedTracks.value.map((t, index) => ({
            ...t,
            track_position: index + 1
        }));
        totalTracks.value -= 1;

    } catch (error) {
        console.error('Error removing track:', error);
    }
};

const toggleTrackMenu = (trackId) => {
    openMenuId.value = openMenuId.value === trackId ? null : trackId;
};

const goBack = () => {
    router.get(route('dashboard.playlists'));
};

const goToEdit = () => {
    router.get(route('playlists.edit', props.playlist.slug));
};

// Atvērt rediģēšanas modāli
const openEditModal = () => {
    editForm.value = {
        name: props.playlist.name || '',
        description: props.playlist.description || '',
        is_private: props.playlist.is_private || false
    };
    editErrors.value = { name: null, description: null, general: null };
    showEditModal.value = true;
};

// Aizvērt rediģēšanas modāli
const closeEditModal = () => {
    showEditModal.value = false;
    isSaving.value = false;
};

// Saglabāt izmaiņas
const savePlaylistChanges = async () => {
    // Validācija
    let hasErrors = false;
    editErrors.value = { name: null, description: null, general: null };

    if (!editForm.value.name || editForm.value.name.trim() === '') {
        editErrors.value.name = t('user_pages.playlistshow.edit_error_name_required');
        hasErrors = true;
    } else if (editForm.value.name.length > 100) {
        editErrors.value.name = t('user_pages.playlistshow.edit_error_name_length');
        hasErrors = true;
    }
    if (editForm.value.description && editForm.value.description.length > 255) {
        editErrors.value.description = t('user_pages.playlistshow.edit_error_description_length');
        hasErrors = true;
    }
    if (hasErrors) return;
    isSaving.value = true;
    try {
        await router.put(route('playlists.update', {user: props.playlist.user.slug, playlist: props.playlist.slug}), {
            name: editForm.value.name.trim(),
            description: editForm.value.description?.trim() || null,
            is_private: editForm.value.is_private
        }, {
            preserveScroll: true,
            onSuccess: () => {
                closeEditModal();
            },
            onError: (errors) => {
                if (errors.name) editErrors.value.name = errors.name;
                if (errors.description) editErrors.value.description = errors.description;
                if (errors.general) editErrors.value.general = errors.general;
            }
        });
    } catch (error) {
        console.error('Error saving playlist:', error);
        editErrors.value.general = t('user_pages.playlistshow.edit_error_general');
    } finally {
        isSaving.value = false;
    }
};

// Pārslēgt privātuma statusu
const togglePrivacy = () => {
    editForm.value.is_private = !editForm.value.is_private;
};

</script>

<template>
    <Head :title="playlist.name" />

    <AuthenticatedLayout>
        <template #header>
            <div class="header-content">
                <button @click="goBack" class="back-button">
                    <i class="fa-solid fa-arrow-left"></i>
                </button>
                <h2 class="page-header">{{ playlist.name }}</h2>
            </div>
        </template>

        <div class="playlist-container">
            <!-- Kolekcijas informācijas sadaļa -->
            <div class="playlist-info-section">
                <div class="playlist-image">
                    <img
                        :src="playlist.cover_url || '/images/default-playlist-banner.webp'"
                        :alt="playlist.name"
                    >
                </div>

                <div class="playlist-details">
                    <div class="playlist-header">
                        <h1 class="playlist-title">{{ playlist.name }}</h1>

                        <div class="playlist-actions">
                            <span
                                class="privacy-badge"
                                :class="{ 'private': playlist.is_private, 'public': !playlist.is_private }"
                            >
                                <i :class="playlist.is_private ? 'fa-solid fa-lock' : 'fa-solid fa-globe'"></i>
                                <span>
                                    {{ playlist.is_private
                                    ? t('user_pages.playlistshow.private')
                                    : t('user_pages.playlistshow.public')
                                    }}
                                </span>
                            </span>

                            <button v-if="canEdit" @click="openEditModal" class="edit-button">
                                <i class="fa-regular fa-pen-to-square"></i>
                                <span>{{ t('user_pages.playlistshow.edit') }}</span>
                            </button>
                        </div>
                    </div>

                    <p v-if="playlist.description" class="playlist-description">
                        {{ playlist.description }}
                    </p>

                    <div class="playlist-meta">
                        <span class="meta-item">
                            <i class="fa-regular fa-calendar"></i>
                            {{ t('user_pages.playlistshow.created') }} {{ formatDateLL(playlist.created_at) }}
                        </span>
                        <span class="meta-item">
                            <i class="fa-regular fa-clock"></i>
                            {{ t('user_pages.playlistshow.updated') }} {{ formatDateLL(playlist.updated_at) }}
                        </span>
                    </div>
                </div>
            </div>

            <div v-if="isInitializing" class="loading-initial">
                <i class="fa-solid fa-spinner fa-spin" style="margin-right: 3px;"></i>
                <span>{{ t('user_pages.playlistshow.loading') }}</span>
            </div>

            <!-- Dziesmu saraksta sadaļa -->
            <div class="tracklist-section">
                <h3 class="tracklist-title">
                    <i class="fa-solid fa-list"></i>
                    {{ t('user_pages.playlistshow.tracks') }}
                    <span class="track-count">({{ totalTracks }})</span>
                </h3>

                <div v-if="displayedTracks.length > 0" ref="trackListRef" class="track-list">
                    <TrackCard
                        v-for="(track, index) in displayedTracks"
                        :key="track.id"
                        :track="track"
                        :index="index"
                        :show-artists="true"
                        :can-remove="canEdit"
                        :menu-open="openMenuId === track.id"
                        duration-format="HH:mm:ss"
                        @track-click="handleTrackClick"
                        @add-to-playlist="openAddToPlaylistModal"
                        @remove="handleRemoveTrack"
                        @toggle-menu="toggleTrackMenu"
                    />

                    <!-- div, kas iedarbina nākamas dziesmu kopas ielādēšanu -->
                    <div ref="loadTrigger" class="load-trigger"></div>

                    <!-- Ielādēšanas indikators -->
                    <div v-if="isLoading" class="loading-indicator">
                        <i class="fa-solid fa-spinner fa-spin"></i>
                        <span>{{ t('user_pages.playlistshow.loading') }}</span>
                    </div>
                </div>

                <!-- Tukšs stāvoklis -->
                <div v-else-if="!isInitializing" class="empty-tracks">
                    <i class="fa-regular fa-list empty-icon"></i>
                    <h3 class="empty-title">
                        {{ t('user_pages.playlistshow.no_tracks_title') }}
                    </h3>
                    <p class="empty-description">
                        {{ t('user_pages.playlistshow.no_tracks_description') }}
                    </p>
                    <button
                        v-if="canEdit"
                        @click="router.get(route('explore.releases'))"
                        class="add-tracks-button"
                    >
                        <i class="fa-solid fa-plus"></i>
                        <span>{{ t('user_pages.playlistshow.add_tracks') }}</span>
                    </button>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>

    <!-- Rediģēšanas modālais logs -->
    <!--
    to know:
    Teleport elements pārvieto elementu no pašreizējās HTML struktūras uz citu elementu,
    kas jau ir uzstādīts DOM.
    -->
    <Teleport to="body">
        <div v-if="showEditModal" class="modal-overlay" @click.self="closeEditModal">
            <div class="modal-container modal-compact">
                <div class="modal-header">
                    <h3 class="modal-title">{{ t('user_pages.playlistshow.edit_modal_title') }}</h3>
                    <button @click="closeEditModal" class="modal-close-button">
                        <i class="fa-solid fa-times"></i>
                    </button>
                </div>

                <div class="modal-body">
                    <!-- Kļūda -->
                    <div v-if="editErrors.general" class="general-error">
                        {{ editErrors.general }}
                    </div>

                    <!-- Nosaukums -->
                    <div class="form-group">
                        <label for="playlist-name" class="form-label">
                            {{ t('user_pages.playlistshow.edit_name_label') }} <span class="required">*</span>
                        </label>
                        <input
                            id="playlist-name"
                            v-model="editForm.name"
                            type="text"
                            class="form-input"
                            :class="{ 'error': editErrors.name }"
                            maxlength="100"
                            :placeholder="t('user_pages.playlistshow.edit_name_placeholder')"
                        >
                        <div class="input-footer">
                            <span v-if="editErrors.name" class="error-message">{{ editErrors.name }}</span>
                            <span class="char-counter">{{ editForm.name.length }}/100</span>
                        </div>
                    </div>

                    <!-- Aprakst -->
                    <div class="form-group">
                        <label for="playlist-description" class="form-label">
                            {{ t('user_pages.playlistshow.edit_description_label') }}
                        </label>
                        <textarea
                            id="playlist-description"
                            v-model="editForm.description"
                            class="form-textarea"
                            :class="{ 'error': editErrors.description }"
                            maxlength="255"
                            rows="2"
                            :placeholder="t('user_pages.playlistshow.edit_description_placeholder')"
                        ></textarea>
                        <div class="input-footer">
                            <span v-if="editErrors.description" class="error-message">{{ editErrors.description }}</span>
                            <span class="char-counter">{{ editForm.description?.length || 0 }}/255</span>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <!-- Privātuma statusa pārslēgs, kreisajā pusē -->
                    <div class="privacy-toggle">
                        <span class="privacy-label">{{ t('user_pages.playlistshow.edit_privacy_label') }}:</span>
                        <button
                            type="button"
                            class="toggle-option"
                            :class="{ 'active': !editForm.is_private }"
                            @click="editForm.is_private = false"
                        >
                            <i class="fa-solid fa-globe"></i>
                            <span>{{ t('user_pages.playlistshow.public') }}</span>
                        </button>
                        <button
                            type="button"
                            class="toggle-option"
                            :class="{ 'active': editForm.is_private }"
                            @click="editForm.is_private = true"
                        >
                            <i class="fa-solid fa-lock"></i>
                            <span>{{ t('user_pages.playlistshow.private') }}</span>
                        </button>
                    </div>

                    <!-- Darbību pogas, labajā pusē -->
                    <div class="modal-actions">
                        <button @click="closeEditModal" class="cancel-button" :disabled="isSaving">
                            {{ t('user_pages.playlistshow.edit_cancel') }}
                        </button>
                        <button
                            @click="savePlaylistChanges"
                            class="save-button"
                            :disabled="isSaving"
                            :class="{ 'loading': isSaving }"
                        >
                        <span v-if="isSaving">
                            <i class="fa-solid fa-spinner fa-spin"></i>
                            {{ t('user_pages.playlistshow.edit_saving') }}
                        </span>
                            <span v-else>{{ t('user_pages.playlistshow.edit_save') }}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </Teleport>

    <AddToPlaylistModal
        :show="showPlaylistModal"
        :track="selectedTrack"
        @close="closeModal"
    />
</template>

<style scoped>
.header-content {
    display: flex;
    min-width: 0;
    align-items: center;
    gap: 1rem;
}

@media (max-width: 1024px) {
    .header-content {
        margin-top: 15px;
    }
}

.back-button {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1.2rem;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
}

.back-button:hover {
    background: rgba(12, 75, 170, 0.1);
}

.page-header {
    font-size: 1.5rem;
    font-weight: 600;
    color: #0c4baa;
    margin: 0;
    min-width: 0;
    flex: 1;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.playlist-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
}

.playlist-info-section {
    display: flex;
    gap: 2rem;
    margin-bottom: 3rem;
    background: white;
    border-radius: 16px;
    padding: 2rem;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.08);
}

.playlist-image {
    position: relative;
    width: 200px;
    height: 200px;
    flex-shrink: 0;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.playlist-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.playlist-details {
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    overflow: hidden;
}

.playlist-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 1rem;
    flex-wrap: wrap;
}

.playlist-title {
    font-size: 2rem;
    font-weight: 700;
    margin: 0;
    min-width: 0;
    word-break: break-word;
    overflow-wrap: anywhere;
}

.playlist-actions {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.privacy-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.4rem 0.8rem;
    border-radius: 30px;
    font-size: 0.85rem;
    font-weight: 500;
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

.edit-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.4rem 1rem;
    background: white;
    border: 1px solid rgba(12, 75, 170, 0.2);
    border-radius: 30px;
    color: #0c4baa;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.edit-button:hover {
    background: rgba(12, 75, 170, 0.05);
    border-color: #0c4baa;
}

.playlist-description {
    font-size: 1rem;
    color: #4b5563;
    line-height: 1.6;
    margin: 0;
    overflow-wrap: anywhere;
    word-break: break-word;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.playlist-meta {
    display: flex;
    gap: 1.5rem;
    margin-top: auto;
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #6b7280;
    font-size: 0.9rem;
}

.meta-item i {
    color: #0c4baa;
    font-size: 0.9rem;
}

.loading-initial {
    margin-bottom: 5px;
}

.tracklist-section {
    background: white;
    border-radius: 16px;
    padding: 2rem;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.08);
}

.tracklist-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
    margin: 0 0 1.5rem 0;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.tracklist-title i {
    color: #0c4baa;
}

.track-count {
    font-size: 0.9rem;
    font-weight: 400;
    color: #666;
    margin-left: 0.25rem;
}

.track-list {
    overflow: visible; /* svarīgi nolaižamajai izvēlnei */
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.load-trigger {
    height: 1px;
}

.loading-indicator {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    padding: 2rem;
    color: #0c4baa;
    font-size: 0.95rem;
}

.loading-indicator i {
    font-size: 1.2rem;
}

.empty-tracks {
    text-align: center;
    padding: 4rem 1rem;
}

.empty-icon {
    font-size: 4rem;
    color: rgba(12, 75, 170, 0.3);
    margin-bottom: 1rem;
}

.empty-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
    margin: 0 0 0.5rem 0;
}

.empty-description {
    font-size: 1rem;
    color: #666;
    max-width: 400px;
    margin: 0 auto 1.5rem;
    line-height: 1.5;
}

.add-tracks-button {
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1.5rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border: none;
    border-radius: 30px;
    color: white;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.2);
}

.add-tracks-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(12, 75, 170, 0.3);
}

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
    max-width: 500px;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    animation: slideUp 0.3s ease;
}

.modal-container.modal-compact {
    max-width: 550px;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 1.25rem;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
}

.modal-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #333;
    margin: 0;
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
    padding: 1rem 1.25rem;
}

.form-group {
    margin-bottom: 1rem;
}

.form-group:last-child {
    margin-bottom: 0;
}

.form-label {
    display: block;
    font-size: 0.85rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 0.4rem;
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

.form-textarea {
    width: 100%;
    padding: 0.6rem 0.75rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 0.9rem;
    resize: vertical;
    transition: all 0.2s ease;
    font-family: inherit;
}

.form-textarea:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
}

.form-textarea.error {
    border-color: #dc2626;
}

.input-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 0.35rem;
}

.error-message {
    color: #dc2626;
    font-size: 0.75rem;
}

.char-counter {
    color: #666;
    font-size: 0.7rem;
    margin-left: auto;
}

.general-error {
    background: #fee2e2;
    color: #dc2626;
    padding: 0.6rem;
    border-radius: 8px;
    margin-bottom: 1rem;
    font-size: 0.85rem;
    border: 1px solid #fecaca;
}

.modal-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 1.25rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
    gap: 1rem;
    flex-wrap: wrap;
}

.privacy-toggle {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.privacy-label {
    font-size: 0.85rem;
    font-weight: 500;
    color: #333;
}

.toggle-option {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    padding: 0.4rem 0.75rem;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 30px;
    color: #666;
    font-size: 0.8rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.toggle-option i {
    font-size: 0.8rem;
}

.toggle-option.active {
    background: white;
    border-color: #0c4baa;
    color: #0c4baa;
    box-shadow: 0 2px 6px rgba(12, 75, 170, 0.1);
}

.toggle-option.active:first-of-type {
    border-color: #16a34a;
    color: #16a34a;
}

.toggle-option.active:last-of-type {
    border-color: #dc2626;
    color: #dc2626;
}

.modal-actions {
    display: flex;
    align-items: center;
    gap: 0.75rem;
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

.save-button {
    padding: 0.45rem 1.25rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border: none;
    border-radius: 30px;
    color: white;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    min-width: 85px;
    text-align: center;
}

.save-button:hover:not(:disabled) {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.3);
}

.save-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.save-button.loading {
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    opacity: 0.8;
}

.save-button.loading i {
    margin-right: 0.35rem;
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
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

/* Responsivitāte */
@media (max-width: 768px) {
    .playlist-info-section {
        flex-direction: column;
        align-items: center;
        text-align: center;
        padding: 1.5rem;
    }

    .playlist-header {
        flex-direction: column;
        align-items: center;
    }

    .playlist-meta {
        justify-content: center;
    }

    .playlist-title {
        font-size: 1.5rem;
    }
}

@media (max-width: 640px) {
    .modal-container {
        width: 95%;
        max-height: 95vh;
    }

    .modal-footer {
        flex-direction: column;
        align-items: stretch;
        gap: 0.75rem;
    }

    .privacy-toggle {
        justify-content: center;
    }

    .modal-actions {
        justify-content: center;
    }

    .cancel-button,
    .save-button {
        min-width: 100px;
    }

    .playlist-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .playlist-actions {
        width: 100%;
        justify-content: space-between;
    }
}

@media (max-width: 480px) {
    .playlist-container {
        padding: 1rem;
    }

    .playlist-info-section {
        padding: 1rem;
    }

    .playlist-image {
        width: 150px;
        height: 150px;
    }

    .playlist-meta {
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
    }

    .tracklist-section {
        padding: 1rem;
    }
}

</style>
