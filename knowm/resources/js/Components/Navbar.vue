<script setup>
import { ref, onMounted, onBeforeUnmount, watch, computed } from "vue";
import { usePage, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n'

const page = usePage();
const { locale, t } = useI18n();

// reaktīvas vērtības
const user = computed(() => page.props.auth?.user ?? null);
const isLoggedIn = computed(() => !!user.value);

const isDarkMode = ref(localStorage.getItem("darkMode") === "true");
const isMenuActive = ref(false);
const isMobile = ref(false);
let mediaQuery;
const activeDropdown = ref(null);
const searchQuery = ref('');
const isMobileExploreOpen = ref(false);

const closeAllDropdowns = () => {
    activeDropdown.value = null;
};

const update = () => {
    isMobile.value = mediaQuery.matches;
    if (!isMobile.value) {
        isMenuActive.value = false;
    }
};

onMounted(() => {
    window.addEventListener('click', closeAllDropdowns);
    mediaQuery = window.matchMedia("(max-width: 1220px)");
    update();
    mediaQuery.addEventListener("change", update);
});

onBeforeUnmount(() => {
    mediaQuery.removeEventListener("change", update);
});

const toggleDarkMode = () => {
    isDarkMode.value = !isDarkMode.value;
    localStorage.setItem("darkMode", isDarkMode.value);
};

watch(isDarkMode, (val) => {
    document.documentElement.classList.toggle("dark-mode", val);
    localStorage.setItem("darkMode", val);
});

const toggleNav = () => {
    isMenuActive.value = !isMenuActive.value;
    // bloķēt ritināšanu, kad izvēlne ir atvērta, WIP
    if (isMenuActive.value) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
};

const toggleDropdown = (name) => {
    activeDropdown.value = activeDropdown.value === name ? null : name;
};

const toggleMobileExplore = () => {
    isMobileExploreOpen.value = !isMobileExploreOpen.value;
};

const redirectToExplore = (type) => {
    router.visit(`/explore/${type}`);
};

const logout = () => {
    router.post('/logout');
};

const performSearch = () => {
    if (searchQuery.value.trim()) {
        router.get('/search', {
            q: searchQuery.value.trim()
        });
    }
};

const changeLanguage = (lang) => {
    locale.value = lang;
    localStorage.setItem('locale', lang);
};

watch(locale, (newLocale) => {
    document.documentElement.lang = newLocale;
});

const getLanguageName = (code) => {
    const languages = {
        'en': 'English',
        'lv': 'Latviešu'
    };
    return languages[code] || code;
};

// aktīvā maršruta iezīmēšanas helper
const isActiveRoute = (routePath) => {
    return window.location.pathname === routePath;
};

</script>

<template>
    <nav class="navbar">
        <div class="nav-left">
            <a href="/" class="logo-container">
                <img src="/images/mini-logo.png" alt="Logo" class="logo">
                <p>Know Your Music</p>
            </a>
        </div>

        <div class="nav-center">
            <div class="search-container">
                <div class="search">
                    <input
                        type="search"
                        autocomplete="off"
                        class="search-term"
                        placeholder="Search..."
                        v-model="searchQuery"
                        @keyup.enter="performSearch"
                    >
                    <button
                        type="submit"
                        class="search-button"
                        @click="performSearch"
                    >
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="nav-right">
            <ul class="nav-links">
                <li class="dropdown-item">
                    <div
                        class="dropdown-trigger"
                        role="button"
                        tabindex="0"
                        @click.stop="toggleDropdown('explore')"
                        @keydown.enter="toggleDropdown('explore')"
                    >
                        Explore <i class="fa fa-caret-down"></i>
                    </div>
                    <transition name="dropdown-fade">
                        <div v-show="activeDropdown === 'explore'" class="dropdown-menu">
                            <a href="#" @click.prevent="redirectToExplore('artists')">Artists</a>
                            <a href="#" @click.prevent="redirectToExplore('releases')">Releases</a>
                            <a href="#" @click.prevent="redirectToExplore('genres')">Genres</a>
                        </div>
                    </transition>
                </li>

                <li><a href="/about" :class="{ active: isActiveRoute('/about') }">About</a></li>

                <li class="dropdown-item">
                    <div
                        class="dropdown-trigger"
                        role="button"
                        tabindex="0"
                        @click.stop="toggleDropdown('language')"
                        @keydown.enter="toggleDropdown('language')"
                    >
                        <span class="lang-code">{{ locale.toUpperCase() }}</span>
                        <i class="fa fa-caret-down"></i>
                    </div>
                    <transition name="dropdown-fade">
                        <div v-show="activeDropdown === 'language'" class="dropdown-menu language-menu">
                            <a href="#" @click.prevent="changeLanguage('en')" :class="{ active: locale === 'en' }">English</a>
                            <a href="#" @click.prevent="changeLanguage('lv')" :class="{ active: locale === 'lv' }">Latviešu</a>
                        </div>
                    </transition>
                </li>

                <li v-if="!isLoggedIn"><a href="/login">Login</a></li>
                <li v-if="!isLoggedIn"><a href="/signup">Sign up</a></li>

                <li v-if="isLoggedIn" class="user-menu">
                    <div
                        class="user-avatar"
                        role="button"
                        tabindex="0"
                        @click.stop="toggleDropdown('user')"
                        @keydown.enter="toggleDropdown('user')"
                    >
                        <img
                            v-if="user.avatar_url"
                            :src="user.avatar_url"
                            :alt="user.name"
                        />
                        <div
                            v-else
                            class="avatar-initial"
                            :style="{
                                background: `linear-gradient(135deg, ${user.avatar_color_1}, ${user.avatar_color_2})`
                            }"
                        >
                            {{ user.initial }}
                        </div>
                        <transition name="dropdown-fade">
                            <div v-show="activeDropdown === 'user'" class="dropdown-menu user-dropdown">
                                <p class="user-name">{{ user.name }}</p>
                                <a href="/dashboard">Dashboard</a>
                                <a href="/dashboard/settings">Profile Settings</a>
                                <a href="#" @click.prevent="logout">Logout</a>
                            </div>
                        </transition>
                    </div>
                </li>
            </ul>

            <div class="hamburger" @click="toggleNav">
                <span class="line"></span>
                <span class="line"></span>
                <span class="line"></span>
            </div>
        </div>
    </nav>

    <!-- Pārklājums -->
    <transition name="fade">
        <div v-if="isMenuActive && isMobile" class="overlay" @click="toggleNav"></div>
    </transition>

    <!-- Mobilo ierīču sānjosla -->
    <transition name="slide-right">
        <div v-if="isMenuActive && isMobile" class="mobile-sidebar">
            <div class="mobile-sidebar-header">
                <span class="menu-title">Menu</span>
                <button class="close-sidebar" @click="toggleNav">
                    <i class="fa-solid fa-times"></i>
                </button>
            </div>
            <div class="mobile-sidebar-content">
                <div class="mobile-language-section">
                    <div class="mobile-language-label">Language</div>
                    <div class="mobile-language-options">
                        <button
                            @click="changeLanguage('en')"
                            :class="{ active: locale === 'en' }"
                        >
                            English
                        </button>
                        <button
                            @click="changeLanguage('lv')"
                            :class="{ active: locale === 'lv' }"
                        >
                            Latviešu
                        </button>
                    </div>
                </div>

                <div
                    class="mobile-explore-section"
                    @click.stop
                >
                    <div
                        class="mobile-explore-header"
                        @click="toggleMobileExplore"
                    >
                        <span>Explore</span>
                        <i class="fa fa-caret-down" :class="{ rotated: isMobileExploreOpen }"></i>
                    </div>
                    <transition name="dropdown-fade">
                        <div v-show="isMobileExploreOpen" class="mobile-explore-dropdown">
                            <a href="#" @click.prevent="redirectToExplore('artists')">Artists</a>
                            <a href="#" @click.prevent="redirectToExplore('releases')">Releases</a>
                            <a href="#" @click.prevent="redirectToExplore('genres')">Genres</a>
                        </div>
                    </transition>
                </div>

                <nav class="mobile-nav">
                    <a href="/about">About</a>
                    <template v-if="!isLoggedIn">
                        <a href="/login">Login</a>
                        <a href="/signup">Sign up</a>
                    </template>
                    <template v-else>
                        <a href="/dashboard">Dashboard</a>
                        <a href="/dashboard/settings">Profile Settings</a>
                        <Link v-if="isAdmin" :href="route('admin-dashboard')" class="admin-link">Admin Panel</Link>
                        <a href="#" @click.prevent="logout">Logout</a>
                    </template>
                </nav>
            </div>
        </div>
    </transition>

    <!-- Mobilo ierīču meklēšanas josla -->
    <div v-show="isMobile" class="mobile-search-container">
        <div class="search">
            <input
                type="search"
                autocomplete="off"
                class="search-term"
                placeholder="Search..."
                v-model="searchQuery"
                @keyup.enter="performSearch"
            />
            <button
                type="submit"
                class="search-button"
                @click="performSearch"
            >
                <i class="fa fa-search"></i>
            </button>
        </div>
    </div>
</template>

<style scoped>
.navbar {
    background: rgba(255, 255, 255, 0.96);
    backdrop-filter: blur(10px);
    padding: 0.5rem 2%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 12px rgba(12, 75, 170, 0.08);
    z-index: 100;
    height: 64px;
    position: sticky;
    top: 0;
    transition: all 0.3s ease;
}

.nav-left,
.nav-right {
    flex: 0 0 auto;
}

.nav-center {
    flex: 1;
    display: flex;
    justify-content: center;
    max-width: 600px;
    margin: 0 auto;
}

.logo-container {
    display: flex;
    align-items: center;
    text-decoration: none;
    gap: 0.5rem;
}

.logo {
    width: 100px;
    height: 56px;
    object-fit: contain;
}

.logo-container p {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    font-size: 1.2rem;
    font-weight: 600;
    color: #0c4baa;
    white-space: nowrap;
}

.search-container {
    width: 100%;
}

.search {
    display: flex;
    width: 100%;
    background: #f5f7fa;
    border-radius: 48px;
    border: 1px solid #e2e8f0;
    transition: all 0.2s ease;
}

.search:focus-within {
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
}

.search-term {
    flex: 1;
    border: none;
    background: transparent;
    padding: 0.6rem 1rem;
    font-size: 0.95rem;
    border-radius: 48px 0 0 48px;
    outline: none;
    color: #1e293b;
}

.search-term::placeholder {
    color: #94a3b8;
}

.search-button {
    background: transparent;
    border: none;
    padding: 0 1rem;
    font-size: 1rem;
    color: #0c4baa;
    cursor: pointer;
    border-radius: 0 48px 48px 0;
    transition: all 0.2s ease;
    position: relative;
    text-align: center;
    overflow: hidden;
}

.search-button i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

/* mainīt uz mūzikas ikonu, novietojot kursoru */
.search-button:hover i {
    opacity: 0;
    transform: scale(0.5);
}

.search-button::after {
    content: "";
    opacity: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.5);
}

/* mūzikas ikonas pievienošana pēc kursora novietošanas */
.search-button:hover::after {
    content: "\f001";
    font-family: "Font Awesome 6 Free", sans-serif;
    font-weight: 900;
    font-size: 20px;
    color: #0c4baa;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin: 0;
    padding: 0;
    list-style: none;
}

.nav-links li a,
.dropdown-trigger {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    font-size: 0.95rem;
    font-weight: 500;
    color: #1e293b;
    text-decoration: none;
    padding: 0.5rem 0.75rem;
    border-radius: 8px;
    transition: all 0.2s ease;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.3rem;
}

.nav-links li a:hover,
.dropdown-trigger:hover {
    color: #0c4baa;
    background: rgba(12, 75, 170, 0.05);
}

.nav-links li a.active {
    color: #0c4baa;
    font-weight: 600;
}

.dropdown-item {
    position: relative;
}

.dropdown-menu {
    position: absolute;
    top: calc(100% + 0.5rem);
    left: 0;
    min-width: 180px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
    padding: 0.5rem 0;
    z-index: 200;
    backdrop-filter: blur(4px);
    border: 1px solid rgba(12, 75, 170, 0.1);
    pointer-events: none;
}

.dropdown-menu a {
    display: block;
    padding: 0.6rem 1rem;
    color: #334155;
    text-decoration: none;
    font-size: 0.9rem;
    transition: all 0.2s ease;
    pointer-events: auto;
}

.dropdown-menu a:hover {
    background: rgba(12, 75, 170, 0.05);
    color: #0c4baa;
}

.dropdown-menu a.active {
    background: rgba(12, 75, 170, 0.1);
    color: #0c4baa;
    font-weight: 500;
}

.language-menu {
    min-width: 140px;
}

.lang-code {
    font-weight: 600;
    letter-spacing: 0.5px;
}

.user-menu {
    margin-left: 0.5rem;
}

.user-avatar {
    width: 40px;
    height: 40px;
    cursor: pointer;
    position: relative;
}

.user-avatar img,
.avatar-initial {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.user-avatar:hover img,
.avatar-initial:hover {
    transform: scale(1.05);
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.15);
}

.avatar-initial {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-weight: 600;
    color: white;
}

.user-dropdown {
    left: auto;
    right: 0;
    min-width: 200px;
}

.user-name {
    padding: 0.6rem 1rem;
    font-weight: 600;
    border-bottom: 1px solid #eef2f6;
    margin-bottom: 0.25rem;
    color: #0f172a;
    pointer-events: none !important;
}

.dropdown-fade-enter-active,
.dropdown-fade-leave-active {
    transition: opacity 0.2s ease, transform 0.2s ease;
}

.dropdown-fade-enter-from,
.dropdown-fade-leave-to {
    opacity: 0;
    transform: translateY(-8px);
}

.mobile-sidebar {
    position: fixed;
    top: 0;
    right: 0;
    width: 85%;
    max-width: 320px;
    height: 100%;
    background: white;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    box-shadow: -4px 0 24px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.mobile-sidebar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 1.25rem;
    border-bottom: 1px solid #eef2f6;
    background: white;
    position: sticky;
    top: 0;
    z-index: 5;
}

.menu-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #0c4baa;
}

.close-sidebar {
    background: none;
    border: none;
    font-size: 1.25rem;
    cursor: pointer;
    color: #64748b;
    transition: color 0.2s;
}

.close-sidebar:hover {
    color: #0c4baa;
}

.mobile-sidebar-content {
    flex: 1;
    padding: 1rem 1.25rem;
}

.mobile-language-section {
    margin-bottom: 1.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid #eef2f6;
}

.mobile-language-label {
    font-size: 0.85rem;
    font-weight: 500;
    color: #64748b;
    margin-bottom: 0.5rem;
}

.mobile-language-options {
    display: flex;
    gap: 0.75rem;
}

.mobile-language-options button {
    flex: 1;
    padding: 0.5rem;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s;
    color: #1e293b;
}

.mobile-language-options button.active {
    background: #0c4baa;
    border-color: #0c4baa;
    color: white;
}

.mobile-explore-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem 0;
    font-size: 1rem;
    font-weight: 500;
    color: #1e293b;
    cursor: pointer;
}

.mobile-explore-header i {
    transition: transform 0.2s ease;
    color: #64748b;
}

.mobile-explore-header i.rotated {
    transform: rotate(180deg);
}

.mobile-explore-dropdown {
    display: flex;
    flex-direction: column;
    margin-top: 0.5rem;
    padding-left: 0.5rem;
    border-left: 2px solid #0c4baa;
}

.mobile-explore-dropdown a {
    padding: 0.6rem 0;
    font-size: 0.95rem;
    color: #475569;
    text-decoration: none;
    transition: color 0.2s;
}

.mobile-explore-dropdown a:hover {
    color: #0c4baa;
}

.mobile-nav {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.mobile-nav a {
    padding: 0.75rem 0;
    font-size: 1rem;
    color: #1e293b;
    text-decoration: none;
    transition: color 0.2s;
    border-bottom: 1px solid #f1f5f9;
}

.mobile-nav a:hover {
    color: #0c4baa;
}

.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    backdrop-filter: blur(4px);
    z-index: 900;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}

.slide-right-enter-active,
.slide-right-leave-active {
    transition: transform 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
}
.slide-right-enter-from,
.slide-right-leave-to {
    transform: translateX(100%);
}

.mobile-search-container {
    background: white;
    padding: 0.75rem 1rem;
    border-top: 1px solid #eef2f6;
    position: sticky;
    bottom: 0;
    z-index: 10;
    box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.05);
}

.mobile-search-container .search {
    background: #f8fafc;
}

/* Responsivitāte */
@media (max-width: 1220px) {
    .nav-center {
        display: none;
    }

    .nav-links {
        display: none;
    }

    .hamburger {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 32px;
        height: 32px;
        cursor: pointer;
        gap: 5px;
    }

    .hamburger .line {
        width: 24px;
        height: 2px;
        background: #0c4baa;
        border-radius: 2px;
        transition: all 0.2s;
    }

    .hamburger:hover .line {
        background: #20c1f7;
    }
}

@media (min-width: 1221px) {
    .hamburger,
    .mobile-search-container {
        display: none;
    }
}

@media (max-width: 480px) {
    .logo-container p {
        display: none;
    }

    .mobile-sidebar {
        width: 85%;
    }

    .mobile-language-options {
        flex-direction: column;
    }
}

</style>
