<script setup>
import { Head, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import ArtistCardMain from '@/Components/Artists/ArtistCardMain.vue';
import Pagination from '@/Components/Admin/Pagination.vue';
import { computed } from 'vue';
import { route } from "ziggy-js";

const { t, locale } = useI18n();

const props = defineProps({
    artists: {
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

const redirectToArtist = (slug) => {
    router.get(`/artists/${slug}`);
};

// computed rekvizīts pluralizētam skaitam
const totalCountText = computed(() => {
    const count = props.artists.total || 0;
    if (count === 1) {
        return t('user_pages.favorites.total_count_singular', { count });
    }
    return t('user_pages.favorites.total_count_plural', { count });
});

</script>

<template>
    <Head :title="t('user_pages.favorites.favorite_artists_title')" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="page-header">
                {{ t('user_pages.favorites.favorite_artists_title') }}
            </h2>
        </template>

        <div class="favorites-container">
            <!-- Galvene ar skaitu un pogu atpakaļ -->
            <div class="favorites-header">
                <p class="favorites-count">
                    {{ totalCountText }}
                </p>
            </div>

            <!-- Izpildītāju saraksts -->
            <div v-if="artists.data && artists.data.length > 0" class="artists-list">
                <ArtistCardMain
                    v-for="artist in artists.data"
                    :key="artist.id"
                    :artist="artist"
                    :redirect-to="redirectToArtist"
                    :show-track-count="false"
                />
            </div>

            <!-- Ja tukšs -->
            <div v-else class="empty-state">
                <i class="fa-regular fa-heart empty-icon"></i>
                <h3 class="empty-title">
                    {{ t('user_pages.favorites.no_favorites_title') }}
                </h3>
                <p class="empty-description">
                    {{ t('user_pages.favorites.no_favorites_description') }}
                </p>
                <button
                    @click="router.get(route('artists.explore'))"
                    class="explore-button"
                >
                    <i class="fa-solid fa-compass"></i>
                    <span>{{ t('user_pages.favorites.explore_artists') }}</span>
                </button>
            </div>

            <div v-if="artists.data && artists.data.length > 0" class="pagination-wrapper">
                <Pagination :links="artists.links" />
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

.favorites-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
}

.favorites-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.favorites-count {
    font-size: 1rem;
    color: #4b5563;
    margin: 0;
}

/*
kaut kur šajā brīdī uzzināju, ka pēc jaunām tendencēm pieņemts
@media vaicājumus likt uzreiz zem elementa, kuram šis vaicājums tiek rakstīts,
nevis likt visus kopā lapas beigās.
iepriekšējās lapas paliek kā ir vai tiks atjauninātas,
ja būs nepieciešams. :|
 */

@media (prefers-color-scheme: dark) {
    .favorites-count {
        color: #9ca3af;
    }
}

.artists-list {
    display: flex;
    flex-wrap: wrap;
    gap: 1.2rem;
    justify-content: flex-start;
    padding: 0 2rem;
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

.explore-button {
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

.explore-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(12, 75, 170, 0.3);
}

.explore-button i {
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

.artists-list {
    animation: fadeIn 0.4s ease-out;
}

.empty-state {
    animation: fadeIn 0.4s ease-out;
}

/* Responsivitāte */
@media (max-width: 640px) {
    .favorites-header {
        flex-direction: column;
        align-items: flex-start;
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

    .explore-button {
        width: 100%;
        justify-content: center;
        padding: 0.75rem 1rem;
    }
}

</style>
