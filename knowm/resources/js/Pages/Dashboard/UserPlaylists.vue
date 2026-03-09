<script setup>
import { Head, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import { computed } from 'vue';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';
import { route } from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    playlists: {
        type: Object,
        required: true,
        default: () => ({
            data: [],
            links: [],
            total: 0,
            current_page: 1,
            last_page: 1,
            from: 0,
            to: 0
        })
    }
});

// computed rekvizīts pluralizētam skaitam
const totalCountText = computed(() => {
    const count = props.playlists.total || 0;
    if (count === 1) {
        return t('user_pages.playlists.total_count_singular', { count });
    }
    return t('user_pages.playlists.total_count_plural', { count });
});

// helper, lai iegūtu pirmās dziesmas attēlu vai noklusējuma attēlu
const getPlaylistImage = (playlist) => {
    if (playlist.tracks && playlist.tracks.length > 0 && playlist.tracks[0].cover_url) {
        return playlist.tracks[0].cover_url;
    }
    return '/images/default-release-banner.webp';
};

// helper, lai iegūtu dziesmu skaita tekstu
const getTracksCountText = (count) => {
    if (count === 1) {
        return t('user_pages.playlists.track_count_singular', { count });
    }
    return t('user_pages.playlists.track_count_plural', { count });
};

const redirectToPlaylist = (slug) => {
    router.get(`/playlists/${slug}`);
};

const createNewPlaylist = () => {
    router.get(route('playlists.create'));
};

</script>

<template>
    <Head :title="t('user_pages.playlists.page_title')" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="page-header">
                {{ t('user_pages.playlists.page_title') }}
            </h2>
        </template>

        <div class="playlists-container">
            <!-- Virsraksts ar skaitu un darbībām -->
            <div class="playlists-header">
                <p class="playlists-count">
                    {{ totalCountText }}
                </p>

                <div class="header-actions">
                    <button
                        @click="createNewPlaylist"
                        class="create-button"
                    >
                        <i class="fa-solid fa-plus"></i>
                        <span>{{ t('user_pages.playlists.create_new') }}</span>
                    </button>
                </div>
            </div>

            <!-- Atskaņošanas sarakstu grid -->
            <div v-if="playlists.data && playlists.data.length > 0" class="playlists-grid">
                <div
                    v-for="playlist in playlists.data"
                    :key="playlist.id"
                    class="playlist-card"
                    @click="redirectToPlaylist(playlist.slug)"
                >
                    <div class="playlist-image-wrapper">
                        <img
                            :src="getPlaylistImage(playlist)"
                            :alt="playlist.name"
                            class="playlist-image"
                            loading="lazy"
                        >
                        <div class="tracks-count-badge">
                            <i class="fa-solid fa-music"></i>
                            <span>{{ getTracksCountText(playlist.tracks?.length || 0) }}</span>
                        </div>
                    </div>

                    <div class="playlist-info">
                        <h3 class="playlist-name">{{ playlist.name }}</h3>
                        <div class="playlist-meta">
                            <span
                                class="privacy-badge"
                                :class="{ 'private': playlist.is_private, 'public': !playlist.is_private }"
                            >
                                <i
                                    :class="playlist.is_private ? 'fa-solid fa-lock' : 'fa-solid fa-globe'"
                                ></i>
                                <span>
                                    {{ playlist.is_private
                                    ? t('user_pages.playlists.private')
                                    : t('user_pages.playlists.public')
                                    }}
                                </span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div v-else class="empty-state">
                <i class="fa-solid fa-list empty-icon"></i>
                <h3 class="empty-title">
                    {{ t('user_pages.playlists.no_playlists_title') }}
                </h3>
                <p class="empty-description">
                    {{ t('user_pages.playlists.no_playlists_description') }}
                </p>
                <button
                    @click="createNewPlaylist"
                    class="create-playlist-button"
                >
                    <i class="fa-solid fa-plus"></i>
                    <span>{{ t('user_pages.playlists.create_first') }}</span>
                </button>
            </div>

            <!-- Lapdale -->
            <div v-if="playlists.data && playlists.data.length > 0" class="pagination-wrapper">
                <Pagination :links="playlists.links" />
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.page-header {
    font-size: 1.5rem;
    font-weight: 600;
    color: #0c4baa;
    margin: 0;
}

.playlists-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
}

.playlists-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.playlists-count {
    font-size: 1rem;
    color: #4b5563;
    margin: 0;
}

@media (prefers-color-scheme: dark) {
    .playlists-count {
        color: #9ca3af;
    }
}

.header-actions {
    display: flex;
    gap: 1rem;
}

.create-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border: none;
    border-radius: 8px;
    color: white;
    font-size: 0.9rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.create-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.3);
}

.create-button i {
    font-size: 0.9rem;
}

.back-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: white;
    border: 1px solid rgba(12, 75, 170, 0.2);
    border-radius: 8px;
    color: #0c4baa;
    font-size: 0.9rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.back-button:hover {
    background: rgba(12, 75, 170, 0.05);
    border-color: #0c4baa;
    transform: translateY(-1px);
}

.back-button i {
    font-size: 0.9rem;
}

.playlists-grid {
    display: grid;
    grid-template-columns: repeat(1, 1fr);
    gap: 1.5rem;
    margin-bottom: 2rem;
}

@media (min-width: 480px) {
    .playlists-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (min-width: 768px) {
    .playlists-grid {
        grid-template-columns: repeat(3, 1fr);
        gap: 1.75rem;
    }
}

@media (min-width: 1024px) {
    .playlists-grid {
        grid-template-columns: repeat(4, 1fr);
        gap: 2rem;
    }
}

@media (min-width: 1280px) {
    .playlists-grid {
        grid-template-columns: repeat(5, 1fr);
    }
}

.playlist-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.08);
    cursor: pointer;
    transition: all 0.3s ease;
    animation: fadeIn 0.4s ease-out;
}

.playlist-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(12, 75, 170, 0.15);
}

@media (prefers-color-scheme: dark) {
    .playlist-card {
        background: #1f2937;
    }
}

.playlist-image-wrapper {
    position: relative;
    width: 100%;
    aspect-ratio: 1 / 1;
    overflow: hidden;
}

.playlist-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.playlist-card:hover .playlist-image {
    transform: scale(1.05);
}

.tracks-count-badge {
    position: absolute;
    bottom: 8px;
    right: 8px;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(4px);
    color: white;
    padding: 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 0.35rem;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.tracks-count-badge i {
    font-size: 0.7rem;
}

.playlist-info {
    padding: 1rem;
}

.playlist-name {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
    margin: 0 0 0.5rem 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

@media (prefers-color-scheme: dark) {
    .playlist-name {
        color: #f3f4f6;
    }
}

.playlist-meta {
    display: flex;
    align-items: center;
}

.privacy-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    padding: 0.25rem 0.6rem;
    border-radius: 16px;
    font-size: 0.75rem;
    font-weight: 500;
}

.privacy-badge i {
    font-size: 0.7rem;
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

.empty-state {
    text-align: center;
    padding: 4rem 1rem;
    background: white;
    border-radius: 16px;
    box-shadow: 0 2px 12px rgba(12, 75, 170, 0.08);
    margin: 2rem 0;
}

@media (prefers-color-scheme: dark) {
    .empty-state {
        background: #1f2937;
    }
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

.create-playlist-button {
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

.create-playlist-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(12, 75, 170, 0.3);
}

.create-playlist-button i {
    font-size: 1.1rem;
}

.pagination-wrapper {
    margin-top: 2rem;
    display: flex;
    justify-content: center;
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsivitāte */
@media (max-width: 640px) {
    .playlists-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .header-actions {
        width: 100%;
        flex-direction: column;
    }

    .create-button,
    .back-button {
        width: 100%;
        justify-content: center;
    }

    .empty-icon {
        font-size: 3rem;
    }

    .empty-title {
        font-size: 1.1rem;
    }

    .empty-description {
        font-size: 0.9rem;
    }

    .create-playlist-button {
        width: 100%;
        justify-content: center;
    }

    .tracks-count-badge {
        padding: 0.25rem 0.6rem;
        font-size: 0.7rem;
    }
}

</style>
