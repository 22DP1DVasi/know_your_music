<script setup>
import { Head, Link } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import { route } from 'ziggy-js';

const { t } = useI18n();

</script>

<template>
    <Head :title="t('errors.account_suspended.title')" />

    <div class="suspended-container">
        <div class="suspended-card">
            <div class="suspended-icon">
                <i class="fa-solid fa-ban"></i>
            </div>

            <h1 class="suspended-title">{{ t('errors.account_suspended.heading') }}</h1>

            <p class="suspended-message">
                {{ t('errors.account_suspended.message') }}
            </p>

            <Link :href="route('home')" class="suspended-button">
                <i class="fa-solid fa-arrow-right-to-bracket"></i>
                {{ t('errors.account_suspended.guest_button') }}
            </Link>
        </div>
    </div>
</template>

<style scoped>
.suspended-container {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #ffffff 0%, #b3eaff 100%);
    padding: 1rem;
}

.suspended-card {
    background: white;
    border-radius: 1rem;
    box-shadow: 0 20px 35px rgba(12, 75, 170, 0.2);
    padding: 2.5rem;
    max-width: 480px;
    width: 100%;
    text-align: center;
    animation: fadeInUp 0.5s ease-out;
}

.suspended-icon {
    font-size: 4rem;
    color: #dc2626;
    margin-bottom: 1.5rem;
}

.suspended-title {
    font-size: 1.875rem;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 1rem;
}

.suspended-message {
    font-size: 1rem;
    color: #4b5563;
    line-height: 1.6;
    margin-bottom: 2rem;
}

.suspended-button {
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1.5rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    color: white;
    border-radius: 2rem;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.2);
}

.suspended-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(12, 75, 170, 0.3);
}

.suspended-button i {
    font-size: 1rem;
}

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

/* Responsive design */
@media (max-width: 640px) {
    .suspended-card {
        padding: 1.5rem;
    }
    .suspended-icon {
        font-size: 3rem;
    }
    .suspended-title {
        font-size: 1.5rem;
    }
}

</style>
