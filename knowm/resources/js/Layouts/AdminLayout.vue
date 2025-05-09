<template>
    <div class="admin-layout">
        <aside class="sidebar">
            <nav>
                <ul>
                    <li><Link :href="route('admin-dashboard')">Dashboard</Link></li>
                    <li><Link :href="route('admin-users-index')">Users</Link></li>
<!--                <Link :href="route('admin.artists.index')">Artists</Link>-->
<!--                <Link :href="route('admin.releases.index')">Releases</Link>-->
<!--                <Link :href="route('admin.tracks.index')">Tracks</Link>-->
                </ul>
            </nav>
        </aside>
        <main class="content">
            <slot />
        </main>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

</script>

<style scoped>

.admin-layout {
    display: flex;
    min-height: 100vh;
}

.sidebar {
    width: 250px;
    background: #2c3e50;
    color: white;
    padding: 1rem;
}

.content {
    flex: 1;
    padding: 2rem;
}

</style>
