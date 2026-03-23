<script setup>
import { Head, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import { computed } from 'vue';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';
import PlaylistCard from '@/Components/Playlists/PlaylistCard.vue';
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
                <PlaylistCard
                    v-for="playlist in playlists.data"
                    :key="playlist.id"
                    :playlist="playlist"
                    :clickable="true"
                    :show-privacy="true"
                    :show-track-count="true"
                    @playlist-click="(p) => redirectToPlaylist(p.slug)"
                />
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

    .create-button {
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
}

</style>
