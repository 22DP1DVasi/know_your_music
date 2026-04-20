<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, usePage, Link } from '@inertiajs/vue3';
import { useDate } from '@/composables/useDate';
import { useI18n } from 'vue-i18n';
import { computed } from 'vue';

const page = usePage();
const user = page.props.auth.user;
const { t } = useI18n();
const { formatDateDmyNumeric } = useDate();

const props = defineProps({
    favoriteArtistsCount: {
        type: Number,
        default: 0
    },
    collectionsCount: {
        type: Number,
        default: 0
    },
    topGenres: {
        type: Array,
        default: () => []
    },
    hasNoData: {
        type: Boolean,
        default: false
    }
});

</script>

<template>
    <Head title="Dashboard" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="dashboard-header">
                {{ t('user_pages.overview.account_header') }}
            </h2>
        </template>

        <div class="dashboard-container">
            <!-- Lietotāja profila karte -->
            <div class="profile-card">
                <div class="profile-card-inner">
                    <!-- Avatārs -->
                    <div class="avatar-container">
                        <img
                            v-if="user.avatar_url"
                            :src="user.avatar_url"
                            :alt="user.name"
                            class="avatar"
                        >
                        <div
                            v-else
                            class="avatar-initial"
                            :style="{
                                background: `linear-gradient(135deg, ${user.avatar_color_1}, ${user.avatar_color_2})`
                            }"
                        >
                            {{ user.initial }}
                        </div>
                    </div>

                    <!-- Informāciju par lietotāju -->
                    <div class="user-info">
                        <h3 class="user-name">{{ user?.name }}</h3>
                        <p class="user-email">{{ user?.email }}</p>
                        <p class="join-date">
                            <i class="fa-regular fa-calendar"></i>
                            {{ t('user_pages.overview.member_since') }}: {{ formatDateDmyNumeric(user?.created_at) }}
                        </p>
                    </div>
                </div>
            </div>

            <!-- Statistikas priekšskatījums -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fa-regular fa-heart"></i>
                    </div>
                    <div class="stat-content">
                        <span class="stat-value">{{ favoriteArtistsCount }}</span>
                        <span class="stat-label">{{ t('user_pages.overview.favorite_artists') }}</span>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fa-regular fa-rectangle-list"></i>
                    </div>
                    <div class="stat-content">
                        <span class="stat-value">{{ collectionsCount }}</span>
                        <span class="stat-label">{{ t('user_pages.overview.collections') }}</span>
                    </div>
                </div>

                <div class="stat-card genres-card">
                    <div class="stat-icon">
                        <i class="fa-solid fa-chart-simple"></i>
                    </div>
                    <div class="stat-content genres-content">
                        <span class="stat-label">{{ t('user_pages.overview.top_genres') }}</span>
                        <div v-if="topGenres.length > 0" class="genres-list">
                            <div v-for="(genre, index) in topGenres" :key="genre.id" class="genre-item">
                                <span class="genre-rank">{{ index + 1 }}</span>
                                <span class="genre-name">{{ genre.name }}</span>
                                <span class="genre-score">{{ genre.score }} pts</span>
                            </div>
                        </div>
                        <div v-else-if="hasNoData" class="genres-empty">
                            <p class="empty-message">{{ t('user_pages.overview.no_listening_data') }}</p>
                            <Link :href="route('explore.artists')" class="empty-cta">
                                {{ t('user_pages.overview.start_adding') }}
                            </Link>
                        </div>
                        <div v-else class="genres-empty">
                            <p class="empty-message">{{ t('user_pages.overview.genres_not_available') }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.dashboard-header {
    font-size: 1.5rem;
    font-weight: 600;
    color: #0c4baa;
    margin: 0;
}

.dashboard-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1.5rem;
}

.profile-card {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(12, 75, 170, 0.1);
    margin-bottom: 2rem;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.profile-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(12, 75, 170, 0.15);
}

.profile-card-inner {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    background: linear-gradient(135deg, #ffffff 0%, #f8fbff 100%);
}

.avatar-container {
    margin-bottom: 1rem;
}

.avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    border: 4px solid white;
    box-shadow: 0 4px 15px rgba(12, 75, 170, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.avatar:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(12, 75, 170, 0.3);
}

.avatar-initial {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
    font-weight: 600;
    border: 4px solid white;
    box-shadow: 0 4px 15px rgba(12, 75, 170, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.avatar-initial:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(12, 75, 170, 0.3);
}

.user-info {
    width: 100%;
}

.user-name {
    font-size: 1.5rem;
    font-weight: 600;
    color: #333;
    margin: 0 0 0.25rem 0;
}

.user-email {
    font-size: 1rem;
    color: #666;
    margin: 0 0 0.75rem 0;
}

.join-date {
    font-size: 0.9rem;
    color: #888;
    margin: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.join-date i {
    color: #0c4baa;
    font-size: 0.9rem;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    margin-top: 1rem;
}

.stat-card {
    background: white;
    border-radius: 16px;
    padding: 1.5rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    box-shadow: 0 4px 20px rgba(12, 75, 170, 0.08);
    transition: all 0.3s ease;
    border: 1px solid rgba(12, 75, 170, 0.06);
}

.stat-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 30px rgba(12, 75, 170, 0.12);
    border-color: rgba(12, 75, 170, 0.12);
}

.stat-icon {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, rgba(12, 75, 170, 0.1), rgba(32, 193, 247, 0.1));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.stat-icon i {
    font-size: 1.5rem;
    color: #0c4baa;
}

.stat-content {
    display: flex;
    flex-direction: column;
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: #1e293b;
    line-height: 1.2;
}

.stat-label {
    font-size: 0.85rem;
    color: #64748b;
    font-weight: 500;
}

.genres-card {
    flex-direction: column;
    align-items: flex-start;
}

.genres-content {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.genres-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    width: 100%;
}

.genre-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.5rem 0;
    border-bottom: 1px solid rgba(12, 75, 170, 0.08);
}

.genre-item:last-child {
    border-bottom: none;
}

.genre-rank {
    width: 28px;
    height: 28px;
    background: linear-gradient(135deg, rgba(12, 75, 170, 0.1), rgba(32, 193, 247, 0.1));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.8rem;
    font-weight: 600;
    color: #0c4baa;
}

.genre-name {
    flex: 1;
    font-size: 1rem;
    font-weight: 500;
    color: #1e293b;
}

.genre-score {
    font-size: 1rem;
    color: #64748b;
    font-weight: 500;
}

.genres-empty {
    width: 100%;
    text-align: center;
    padding: 1rem 0;
}

.empty-message {
    font-size: 0.85rem;
    color: #64748b;
    margin: 0 0 0.75rem 0;
}

.empty-cta {
    display: inline-block;
    padding: 0.5rem 1rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    color: white;
    text-decoration: none;
    border-radius: 40px;
    font-size: 0.8rem;
    font-weight: 500;
    transition: all 0.2s ease;
}

.empty-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.25);
}

.stat-card.genres-card {
    grid-column: span 2;
}

/* Responsivitāte */
@media (min-width: 768px) {
    .dashboard-container {
        padding: 2rem;
    }

    .profile-card-inner {
        padding: 2rem;
    }

    .avatar {
        width: 120px;
        height: 120px;
    }

    .avatar-placeholder {
        width: 120px;
        height: 120px;
        font-size: 3rem;
    }

    .user-name {
        font-size: 1.8rem;
    }

    .user-email {
        font-size: 1.1rem;
    }

    .join-date {
        font-size: 1rem;
    }

    .stats-grid {
        gap: 1.5rem;
    }
}

@media (min-width: 1024px) {
    .profile-card-inner {
        flex-direction: row;
        text-align: left;
        gap: 2rem;
    }

    .avatar-container {
        margin-bottom: 0;
    }

    .user-info {
        flex: 1;
    }

    .join-date {
        justify-content: flex-start;
    }
}

@media (max-width: 640px) {
    .stats-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
    }

    .stat-card {
        padding: 1.25rem;
    }

    .stat-value {
        font-size: 1.75rem;
    }

    .stat-card.genres-card {
        grid-column: span 1;
    }

    .genre-item {
        gap: 0.5rem;
    }

    .genre-rank {
        width: 24px;
        height: 24px;
        font-size: 0.7rem;
    }

    .genre-name {
        font-size: 0.85rem;
    }
}

@media (min-width: 769px) and (max-width: 1024px) {
    .stats-grid {
        gap: 1rem;
    }

    .stat-card {
        padding: 1.25rem;
    }

    .stat-value {
        font-size: 1.5rem;
    }
}

/* Animācijas */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.profile-card {
    animation: fadeInUp 0.5s ease-out;
}

.stat-card {
    animation: fadeInUp 0.7s ease-out;
}

</style>
