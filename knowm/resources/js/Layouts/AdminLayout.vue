<script setup>
import { Link } from '@inertiajs/vue3';
import { ref } from 'vue';

const mobileMenuOpen = ref(false);

const toggleMobileMenu = () => {
    mobileMenuOpen.value = !mobileMenuOpen.value;
};

</script>

<template>
    <div class="admin-layout">
        <button class="mobile-menu-btn" @click="toggleMobileMenu" v-if="!mobileMenuOpen">
            ☰
        </button>

        <aside class="sidebar" :class="{ 'mobile-open': mobileMenuOpen }">
            <nav>
                <ul>
                    <li><Link :href="route('admin-dashboard')">Dashboard</Link></li>
                    <li><Link :href="route('admin-users-index')">Users</Link></li>
                    <li><Link :href="route('admin-artists-index')">Artists</Link></li>
                </ul>
            </nav>
        </aside>

        <div
            v-if="mobileMenuOpen"
            class="mobile-overlay"
            @click="toggleMobileMenu"
        ></div>

        <main class="content">
            <slot />
        </main>
    </div>
</template>

<style scoped>
.admin-layout {
    display: flex;
    min-height: 100vh;
    position: relative;
}

.sidebar {
    width: 150px;
    background: #2c3e50;
    color: white;
    padding: 1rem;
    transition: transform 0.3s ease;
    z-index: 1000;
}

.content {
    flex: 1;
    padding: 2rem;
}

.mobile-menu-btn {
    display: none;
    position: fixed;
    top: 1rem;
    left: 1rem;
    z-index: 1001;
    background: #2c3e50;
    color: white;
    border: none;
    padding: 0.5rem;
    border-radius: 0.25rem;
    cursor: pointer;
    font-size: 1.25rem;
}

.mobile-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
    opacity: 1;
}

.mobile-overlay.active {
    opacity: 1;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .mobile-menu-btn {
        display: block;
    }

    .mobile-overlay {
        display: block;
    }

    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        bottom: 0;
        z-index: 1000;
        transform: translateX(-100%);
    }

    .sidebar.mobile-open {
        transform: translateX(0);
    }

    .content {
        padding: 1rem;
        padding-top: 4rem;
    }
}

@media (max-width: 480px) {
    .sidebar {
        width: 200px;
    }

    .content {
        padding: 0.5rem;
        padding-top: 3.5rem;
    }
}

</style>
