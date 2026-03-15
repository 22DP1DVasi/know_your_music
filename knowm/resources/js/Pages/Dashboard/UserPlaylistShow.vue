<script setup>
import { Head, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { useDate } from '@/composables/useDate';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import TrackCard from '@/Components/Tracks/TrackCard.vue';
import { route } from "ziggy-js";

const { t } = useI18n();
const { formatDateLL } = useDate();

const props = defineProps({
    playlist: Object,
    tracks: Object,
    canEdit: Boolean
});

// stāvoklis bezgalīgai ritināšanai
const currentPageFromUrl = new URLSearchParams(window.location.search).get('page') || 1
const displayedTracks = ref([])
const currentPage = ref(1)
const lastPage = ref(props.tracks.last_page)
const isLoading = ref(false)
const hasMore = ref(true);
const trackListRef = ref(null);
const loadTrigger = ref(null)

// izvēlnes stāvoklis dziesmu kartēm
const openMenuId = ref(null);

onMounted(async () => {
    const targetPage = parseInt(currentPageFromUrl)
    for (let page = 1; page <= targetPage; page++) {
        await loadPage(page)
    }
    setupObserver()
})

const loadPage = (page) => {
    return new Promise((resolve) => {
        router.get(
            route('playlists.show', { playlist: props.playlist.slug, page }),
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

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});

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

// izņemt dziesmu no atskaņošanas saraksta
const handleRemoveTrack = async (track) => {
    if (!confirm(t('user_pages.playlistshow.remove_track_confirm'))) return;
    try {
        await router.delete(route('playlists.tracks.destroy', {
            playlist: props.playlist.slug,
            track: track.id
        }), {
            preserveScroll: true,
            onSuccess: () => {
                // noņemt dziesmu no lokālajiem masīviem
                displayedTracks.value = displayedTracks.value.filter(t => t.id !== track.id);
                // ja nepieciešams, atjaunināt arī galveno dziesmu masīvu
                props.tracks = props.tracks.filter(t => t.id !== track.id);
            }
        });
    } catch (error) {
        console.error('Error removing track:', error);
        alert(t('user_pages.playlistshow.remove_track_error'));
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
            <!-- Atskaņošanas saraksta informācijas sadaļa -->
            <div class="playlist-info-section">
                <div class="playlist-image">
                    <img
                        :src="playlist.tracks && playlist.tracks[0]?.cover_url || '/images/default-playlist-banner.webp'"
                        :alt="playlist.name"
                    >
                    <div class="track-count-badge">
                        <i class="fa-solid fa-music"></i>
                        <span>{{ tracks.length }} {{ t('user_pages.playlistshow.tracks') }}</span>
                    </div>
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

                            <button v-if="canEdit" @click="goToEdit" class="edit-button">
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

            <!-- Dziesmu saraksta sadaļa -->
            <div class="tracklist-section">
                <h3 class="tracklist-title">
                    <i class="fa-solid fa-list"></i>
                    {{ t('user_pages.playlistshow.tracks') }}
<!--                    <span class="track-count">({{ tracks.length }})</span>-->
                    <span class="track-count">({{ tracks.length }})</span>
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
                <div v-else class="empty-tracks">
                    <i class="fa-regular fa-list empty-icon"></i>
                    <h3 class="empty-title">
                        {{ t('user_pages.playlistshow.no_tracks_title') }}
                    </h3>
                    <p class="empty-description">
                        {{ t('user_pages.playlistshow.no_tracks_description') }}
                    </p>
                    <button
                        v-if="canEdit"
                        @click="router.get(route('playlists.add-tracks', playlist.slug))"
                        class="add-tracks-button"
                    >
                        <i class="fa-solid fa-plus"></i>
                        <span>{{ t('user_pages.playlistshow.add_tracks') }}</span>
                    </button>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.header-content {
    display: flex;
    align-items: center;
    gap: 1rem;
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

@media (prefers-color-scheme: dark) {
    .playlist-info-section {
        background: #1f2937;
    }
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

.track-count-badge {
    position: absolute;
    bottom: 8px;
    right: 8px;
    background: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(4px);
    color: white;
    padding: 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    display: flex;
    align-items: center;
    gap: 0.35rem;
}

.playlist-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.playlist-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
}

.playlist-title {
    font-size: 2rem;
    font-weight: 700;
    color: #333;
    margin: 0;
}

@media (prefers-color-scheme: dark) {
    .playlist-title {
        color: #f3f4f6;
    }
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
}

@media (prefers-color-scheme: dark) {
    .playlist-description {
        color: #9ca3af;
    }
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

.tracklist-section {
    background: white;
    border-radius: 16px;
    padding: 2rem;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.08);
}

@media (prefers-color-scheme: dark) {
    .tracklist-section {
        background: #1f2937;
    }
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

@media (prefers-color-scheme: dark) {
    .tracklist-title {
        color: #f3f4f6;
    }

    .track-count {
        color: #9ca3af;
    }
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

.end-message {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 2rem;
    color: #6b7280;
    font-size: 0.9rem;
}

.end-message i {
    color: #16a34a;
    font-size: 1rem;
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

@media (prefers-color-scheme: dark) {
    .empty-title {
        color: #f3f4f6;
    }
}

.empty-description {
    font-size: 1rem;
    color: #666;
    max-width: 400px;
    margin: 0 auto 1.5rem;
    line-height: 1.5;
}

@media (prefers-color-scheme: dark) {
    .empty-description {
        color: #9ca3af;
    }
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
