<script setup>
import { ref } from 'vue';
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import Dropdown from '@/Components/Dropdown.vue';
import DropdownLink from '@/Components/DropdownLink.vue';
import NavLink from '@/Components/NavLink.vue';
import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
import Navbar from '@/Components/Navbar.vue'
import { Link, usePage } from '@inertiajs/vue3';
import {route} from "ziggy-js";

const showingNavigationDropdown = ref(false);
const user = usePage().props.auth.user;
</script>

<template>
    <Navbar />
    <div class="app-layout">
        <div class="min-h-screen">
            <!-- Navigācija -->
            <nav class="main-nav">
                <div class="nav-container">
                    <div class="nav-content">
                        <!-- Primārā navigācija -->
                        <div class="nav-left">
                            <!-- Navigācijas saites (datora darbvirsma) -->
                            <div class="nav-links-desktop">
                                <NavLink
                                    :href="route('dashboard')"
                                    :active="route().current('dashboard')"
                                    class="nav-link"
                                >
                                    Dashboard
                                </NavLink>
                            </div>
                        </div>

                        <!-- Lietotāja izvēlne (datora darbvirsma) -->
                        <div class="nav-right-desktop">
                            <div class="user-menu-container">
                                <Dropdown align="right" width="48">
                                    <template #trigger>
                                        <button class="user-menu-button">
                                            <span class="user-name">{{ user?.name }}</span>
                                            <svg class="dropdown-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                                            </svg>
                                        </button>
                                    </template>

                                    <template #content>
                                        <DropdownLink :href="route('profile.edit')" class="dropdown-item">
                                            Profile
                                        </DropdownLink>
                                        <DropdownLink :href="route('logout')" method="post" as="button" class="dropdown-item">
                                            Log Out
                                        </DropdownLink>
                                    </template>
                                </Dropdown>
                            </div>
                        </div>

                        <!-- Mobilās izvēlnes poga -->
                        <div class="mobile-menu-button-container">
                            <button
                                @click="showingNavigationDropdown = !showingNavigationDropdown"
                                class="mobile-menu-button"
                            >
                                <svg class="menu-icon" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                                    <path
                                        :class="{ hidden: showingNavigationDropdown, 'inline-flex': !showingNavigationDropdown }"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M4 6h16M4 12h16M4 18h16"
                                    />
                                    <path
                                        :class="{ hidden: !showingNavigationDropdown, 'inline-flex': showingNavigationDropdown }"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M6 18L18 6M6 6l12 12"
                                    />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Mobilās navigācijas izvēlne -->
                <div v-show="showingNavigationDropdown" class="mobile-nav">
                    <div class="mobile-nav-links">
                        <ResponsiveNavLink
                            :href="route('dashboard')"
                            :active="route().current('dashboard')"
                            class="mobile-nav-link"
                        >
                            Dashboard
                        </ResponsiveNavLink>
                    </div>

                    <!-- Mobilā lietotāja izvēlne -->
                    <div class="mobile-user-menu">
                        <div class="mobile-user-info">
                            <div class="mobile-user-name">{{ user?.name }}</div>
                            <div class="mobile-user-email">{{ user?.email }}</div>
                        </div>

                        <div class="mobile-nav-links">
                            <ResponsiveNavLink :href="route('profile.edit')" class="mobile-nav-link">
                                Profile
                            </ResponsiveNavLink>
                            <ResponsiveNavLink
                                :href="route('logout')"
                                method="post"
                                as="button"
                                class="mobile-nav-link"
                            >
                                Log Out
                            </ResponsiveNavLink>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Lapas galvene -->
            <header v-if="$slots.header" class="page-header">
                <div class="header-container">
                    <slot name="header" />
                </div>
            </header>

            <!-- Lapas saturs -->
            <main class="page-content">
                <slot />
            </main>
        </div>
    </div>
</template>

<style scoped>
.app-layout {
    min-height: 100vh;
    background: linear-gradient(to right, #ffffff, #b3eaff);
}

.min-h-screen {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.main-nav {
    background: white;
    border-bottom: 1px solid #e5e7eb;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.nav-container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 1rem;
}

.nav-content {
    display: flex;
    justify-content: space-between;
    height: 4rem;
}

.nav-left {
    display: flex;
    align-items: center;
}

.nav-links-desktop {
    display: none;
    margin-left: 2.5rem;
    gap: 2rem;
}

.nav-link {
    display: inline-flex;
    align-items: center;
    padding: 0.25rem 0;
    font-size: 0.875rem;
    font-weight: 500;
    color: #4b5563;
    border-bottom: 2px solid transparent;
    transition: all 0.2s ease;
    text-decoration: none;
}

.nav-link:hover {
    color: #0c4baa;
    border-bottom-color: #0c4baa;
}

.nav-link.active {
    color: #0c4baa;
    border-bottom-color: #0c4baa;
}

.nav-right-desktop {
    display: none;
    align-items: center;
    margin-left: 1.5rem;
}

.user-menu-container {
    position: relative;
    margin-left: 0.75rem;
}

.user-menu-button {
    display: inline-flex;
    align-items: center;
    padding: 0.5rem 0.75rem;
    background: white;
    border: 1px solid transparent;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    font-weight: 500;
    color: #6b7280;
    transition: all 0.2s ease;
    cursor: pointer;
}

.user-menu-button:hover {
    color: #0c4baa;
}

.user-name {
    margin-right: 0.5rem;
}

.dropdown-icon {
    margin-left: 0.25rem;
    height: 1rem;
    width: 1rem;
    transition: transform 0.2s ease;
}

.user-menu-button:hover .dropdown-icon {
    transform: rotate(180deg);
}

.dropdown-item {
    display: block;
    width: 100%;
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
    color: #374151;
    text-align: left;
    transition: all 0.2s ease;
    text-decoration: none;
    border: none;
    background: none;
    cursor: pointer;
}

.dropdown-item:hover {
    background: #f3f4f6;
    color: #0c4baa;
}

.mobile-menu-button-container {
    display: flex;
    align-items: center;
    margin-right: -0.5rem;
}

.mobile-menu-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.5rem;
    border-radius: 0.375rem;
    color: #9ca3af;
    background: none;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
}

.mobile-menu-button:hover {
    background: #f3f4f6;
    color: #0c4baa;
}

.mobile-menu-button:focus {
    outline: none;
    background: #f3f4f6;
    color: #0c4baa;
}

.menu-icon {
    height: 1.5rem;
    width: 1.5rem;
}

.mobile-nav {
    display: block;
    padding: 0.5rem 0 0.75rem;
    border-top: 1px solid #e5e7eb;
}

.mobile-nav-links {
    padding: 0.5rem 0;
}

.mobile-nav-link {
    display: block;
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
    font-weight: 500;
    color: #4b5563;
    text-decoration: none;
    transition: all 0.2s ease;
    border-left: 3px solid transparent;
}

.mobile-nav-link:hover {
    background: #f9fafb;
    color: #0c4baa;
    border-left-color: #0c4baa;
}

.mobile-nav-link.active {
    color: #0c4baa;
    background: #f0f7ff;
    border-left-color: #0c4baa;
}

.mobile-user-menu {
    border-top: 1px solid #e5e7eb;
    padding: 0.75rem 0;
}

.mobile-user-info {
    padding: 0 1rem;
    margin-bottom: 0.75rem;
}

.mobile-user-name {
    font-size: 0.875rem;
    font-weight: 500;
    color: #1f2937;
}

.mobile-user-email {
    font-size: 0.75rem;
    color: #6b7280;
}

.page-header {
    background: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.header-container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 1.5rem 1rem;
}

.page-content {
    flex: 1;
}

.hidden {
    display: none;
}

.inline-flex {
    display: inline-flex;
}

/* Responsivitāte */
@media (min-width: 1024px) {
    .nav-container {
        padding: 0 2rem;
    }

    .header-container {
        padding: 1.5rem 2rem;
    }
}

@media (min-width: 640px) {
    .nav-container {
        padding: 0 1.5rem;
    }

    .nav-links-desktop {
        display: flex;
    }

    .nav-right-desktop {
        display: flex;
    }

    .mobile-menu-button-container {
        display: none;
    }

    .mobile-nav {
        display: none;
    }

    .header-container {
        padding: 1.5rem;
    }
}

</style>
