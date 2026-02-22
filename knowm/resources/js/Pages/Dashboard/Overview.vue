<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, usePage } from '@inertiajs/vue3';
import { useDate } from '@/composables/useDate';
import { useI18n } from 'vue-i18n';

const user = usePage().props.auth.user;
const { t } = useI18n();
const { formatDateDmyNumeric } = useDate()

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
                            v-if="user?.avatar_url"
                            :src="user.avatar_url"
                            :alt="user.name"
                            class="avatar"
                        >
                        <div v-else class="avatar-placeholder">
                            {{ user?.name?.charAt(0) || 'U' }}
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

            <!-- Sarakstu priekšskatījums -->
            <div class="stats-grid">

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

.avatar-placeholder {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
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

.avatar-placeholder:hover {
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
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 1rem;
    margin-top: 1rem;
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

    .stats-grid {
        grid-template-columns: repeat(3, 1fr);
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

</style>
