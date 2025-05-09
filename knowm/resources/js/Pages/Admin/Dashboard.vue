<template>
    <AdminLayout>
        <h1>Admin Dashboard</h1>
        <div class="stats-grid">
            <div class="stat-card" v-for="(value, key) in stats" :key="key">
                <h3>{{ key }}</h3>
                <p>{{ value }}</p>
            </div>
        </div>
    </AdminLayout>
</template>

<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';

defineProps({
    stats: Object
});

</script>
