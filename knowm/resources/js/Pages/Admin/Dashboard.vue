<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { useI18n } from 'vue-i18n'

defineProps({
    stats: Object
});

const { t } = useI18n()

</script>

<template>
    <AdminLayout>
        <h1>{{ t('adm_dashboard.title') }}</h1>
        <div class="stats-grid">
            <div class="stat-card" v-for="(value, key) in stats" :key="key">
                <h3>{{ key }}</h3>
                <p>{{ value }}</p>
            </div>
        </div>
    </AdminLayout>
</template>
