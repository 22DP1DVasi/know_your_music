<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { useI18n } from 'vue-i18n'
import {Link} from "@inertiajs/vue3";
import {route} from "ziggy-js";

defineProps({
    stats: Object
});

const { t } = useI18n()

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_dashboard.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('home')" class="btn-secondary">
                    {{ t('adm_artists.index.back_to_website') }}
                </Link>
            </div>
        </div>
        <div class="stats-grid">
            <div class="stat-card" v-for="(value, key) in stats" :key="key">
                <h3>{{ key }}</h3>
                <p>{{ value }}</p>
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
    flex-wrap: wrap;
    gap: 1rem;
}

.header-container h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

.header-actions {
    display: flex;
    gap: 0.75rem;
    align-items: center;
}

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
    background-color: #6b7280;
    color: white;
}

.btn-secondary:hover {
    background-color: #4b5563;
}

@media (max-width: 768px) {
    .header-container {
        flex-direction: column;
        align-items: stretch;
    }

    .header-actions {
        flex-direction: column;
        width: 100%;
    }

    .header-actions a,
    .header-actions button {
        width: 100%;
        text-align: center;
    }

    .btn-secondary {
        padding: 0.375rem 0.75rem;
        font-size: 0.8rem;
    }
}

</style>
