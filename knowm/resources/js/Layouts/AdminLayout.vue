<template>
    <div class="admin-layout">
        <button class="mobile-menu-btn" @click="toggleMobileMenu" v-if="!mobileMenuOpen">
            ☰
        </button>

        <aside class="sidebar" :class="{ 'mobile-open': mobileMenuOpen }">
            <button class="sidebar-close-btn" @click="toggleMobileMenu" v-if="mobileMenuOpen">
                ✕
            </button>
            <nav>
                <ul>
                    <li><Link :href="route('admin-dashboard')" @click="closeMobileMenu">Dashboard</Link></li>
                    <li><Link :href="route('admin-users-index')" @click="closeMobileMenu">Users</Link></li>
                    <li><Link :href="route('admin-artists-index')" @click="closeMobileMenu">Artists</Link></li>
                </ul>
            </nav>
        </aside>

        <div class="mobile-overlay" :class="{ 'active': mobileMenuOpen }" @click="toggleMobileMenu"></div>

        <main class="content">
            <slot />
        </main>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';
import { ref } from 'vue';

const mobileMenuOpen = ref(false);

const toggleMobileMenu = () => {
    mobileMenuOpen.value = !mobileMenuOpen.value;
};

const closeMobileMenu = () => {
    mobileMenuOpen.value = false;
};

</script>

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
    position: relative;
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

.sidebar-close-btn {
    display: none;
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: none;
    color: white;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    padding: 0;
    width: 30px;
    height: 30px;
    border-radius: 0.25rem;
}

.sidebar-close-btn:hover {
    background: rgba(255, 255, 255, 0.1);
}

.mobile-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.mobile-overlay.active {
    opacity: 1;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .mobile-menu-btn {
        display: block;
    }

    .sidebar-close-btn {
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
        padding-top: 3rem;
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
