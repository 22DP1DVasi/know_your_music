<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';
import { route } from "ziggy-js";
import { useI18n } from 'vue-i18n';

const showingMobileSidebar = ref(false);
const expandedMenus = ref([]); // izseko izvērstās sadaļas
const activeLanguageDropdown = ref(false);

const user = usePage().props.auth.user;
const { locale, t } = useI18n();

const toggleMobileSidebar = () => {
    showingMobileSidebar.value = !showingMobileSidebar.value;
};

const closeMobileSidebar = () => {
    showingMobileSidebar.value = false;
};

// pārslēgt izvēlnes sadaļas paplašinājumu
const toggleMenu = (menu) => {
    const index = expandedMenus.value.indexOf(menu);
    if (index === -1) {
        expandedMenus.value.push(menu);
    } else {
        expandedMenus.value.splice(index, 1);
    }
};

const isMenuExpanded = (menu) => {
    return expandedMenus.value.includes(menu);
};

const changeLanguage = (lang) => {
    locale.value = lang;
    localStorage.setItem('locale', lang);
    activeLanguageDropdown.value = false;
};

const toggleLanguageDropdown = () => {
    activeLanguageDropdown.value = !activeLanguageDropdown.value;
};

const handleClickOutside = (event) => {
    if (!event.target.closest('.language-switch')) {
        activeLanguageDropdown.value = false;
    }
};

// Add watch for language
watch(locale, (newLocale) => {
    document.documentElement.lang = newLocale;
});

onMounted(() => {
    document.addEventListener('click', handleClickOutside);
});

onBeforeUnmount(() => {
    document.removeEventListener('click', handleClickOutside);
});

</script>

<template>
    <div class="app-layout">
        <!-- Datora darbvirsmas sānjosla -->
        <aside class="desktop-sidebar">
            <div class="sidebar-content">
                <!-- Logotips -->
                <div class="logo-container">
                    <Link :href="route('home')" class="logo-link">
                        <img src="/images/mini-logo.png" alt="Logo" class="logo">
                    </Link>
                </div>

                <!-- Informācija par lietotāju -->
                <div class="user-info">
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
                    <div class="user-details">
                        <span class="user-name">{{ user?.name }}</span>
                    </div>
                </div>

                <!-- Navigācijas izvēlne -->
                <nav class="sidebar-nav">
                    <ul class="nav-list">
                        <!-- Pārskats -->
                        <li class="nav-item">
                            <Link href="#" class="nav-link primary">
                                <i class="fa-solid fa-gauge-high nav-icon"></i>
                                <span>{{ t('user_pages.layout.overview_label') }}</span>
                            </Link>
                        </li>

                        <!-- Profila iestatījumi -->
                        <li class="nav-item">
                            <Link href="#" class="nav-link primary">
                                <i class="fa-solid fa-user-gear nav-icon"></i>
                                <span>{{ t('user_pages.layout.profile_settings') }}</span>
                            </Link>
                        </li>

                        <!-- Izlase -->
                        <li class="nav-item has-submenu">
                            <button
                                @click="toggleMenu('favorites')"
                                class="nav-link primary submenu-toggle"
                                :class="{ 'expanded': isMenuExpanded('favorites') }"
                            >
                                <i class="fa-regular fa-heart nav-icon"></i>
                                <span>{{ t('user_pages.layout.favorites') }}</span>
                                <i class="fa-solid fa-chevron-right toggle-icon"></i>
                            </button>
                            <ul class="submenu" v-show="isMenuExpanded('favorites')">
                                <li>
                                    <Link href="#" class="submenu-link">
                                        <i class="fa-solid fa-user-group submenu-icon"></i>
                                        {{ t('user_pages.layout.favorite_artists') }}
                                    </Link>
                                </li>
                            </ul>
                        </li>

                        <!-- Kolekcijas -->
                        <li class="nav-item has-submenu">
                            <button
                                @click="toggleMenu('playlists')"
                                class="nav-link primary submenu-toggle"
                                :class="{ 'expanded': isMenuExpanded('playlists') }"
                            >
                                <i class="fa-solid fa-list nav-icon"></i>
                                <span>{{ t('user_pages.layout.playlists') }}</span>
                                <i class="fa-solid fa-chevron-right toggle-icon"></i>
                            </button>
                            <ul class="submenu" v-show="isMenuExpanded('playlists')">
                                <li>
                                    <Link href="#" class="submenu-link">
                                        <i class="fa-regular fa-rectangle-list submenu-icon"></i>
                                        {{ t('user_pages.layout.user_playlists') }}
                                    </Link>
                                </li>
                                <li>
                                    <Link href="#" class="submenu-link">
                                        <i class="fa-regular fa-plus submenu-icon"></i>
                                        {{ t('user_pages.layout.create_new_pl') }}
                                    </Link>
                                </li>
                            </ul>
                        </li>

                        <!-- Rekomendācijas -->
                        <li class="nav-item has-submenu">
                            <button
                                @click="toggleMenu('recommendations')"
                                class="nav-link primary submenu-toggle"
                                :class="{ 'expanded': isMenuExpanded('recommendations') }"
                            >
                                <i class="fa-solid fa-lightbulb nav-icon"></i>
                                <span>{{ t('user_pages.layout.recommendations') }}</span>
                                <i class="fa-solid fa-chevron-right toggle-icon"></i>
                            </button>
                            <ul class="submenu" v-show="isMenuExpanded('recommendations')">
                                <li>
                                    <Link href="#" class="submenu-link">
                                        <i class="fa-regular fa-clock submenu-icon"></i>
                                        {{ t('user_pages.layout.history_recom') }}
                                    </Link>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>

                <div class="language-switch-container">
                    <div class="language-switch" @click.stop>
                        <button
                            @click="toggleLanguageDropdown"
                            class="language-selector"
                            :class="{ 'active': activeLanguageDropdown }"
                        >
                            <i class="fa-solid fa-globe"></i>
                            <span class="language-code">{{ locale.toUpperCase() }}</span>
                            <i class="fa fa-caret-down" :class="{ 'rotate': activeLanguageDropdown }"></i>
                        </button>
                        <div v-show="activeLanguageDropdown" class="language-dropdown">
                            <button
                                @click="changeLanguage('en')"
                                class="language-option"
                                :class="{ active: locale === 'en' }"
                            >
                                English
                            </button>
                            <button
                                @click="changeLanguage('lv')"
                                class="language-option"
                                :class="{ active: locale === 'lv' }"
                            >
                                Latviešu
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Atteikšanās poga -->
                <div class="sidebar-footer">
                    <Link :href="route('logout')" method="post" as="button" class="logout-button">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        <span>{{ t('user_pages.layout.logout') }}</span>
                    </Link>
                </div>
            </div>
        </aside>

        <!-- Mobilā režīma galvene -->
        <header class="mobile-header">
            <div class="mobile-header-content">
                <button @click="toggleMobileSidebar" class="mobile-menu-toggle">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="mobile-logo">
                    <Link :href="route('home')" class="logo-link">
                        <img src="/images/mini-logo.png" alt="Logo" class="logo-small">
                    </Link>
                </div>
            </div>
        </header>

        <!-- Mobilās sānjoslas pārklājums -->
        <div
            v-if="showingMobileSidebar"
            class="mobile-sidebar-overlay"
            @click="closeMobileSidebar"
        ></div>

        <!-- Mobilā režīma sānjosla -->
        <aside class="mobile-sidebar" :class="{ 'open': showingMobileSidebar }">
            <div class="mobile-sidebar-content">
                <!-- Mobilās sānjoslas galvene -->
                <div class="mobile-sidebar-header">
                    <div class="mobile-sidebar-user">
                        <div class="avatar-container small">
                            <img
                                v-if="user?.avatar_url"
                                :src="user.avatar_url"
                                :alt="user.name"
                                class="avatar"
                            >
                            <div v-else class="avatar-placeholder small">
                                {{ user?.name?.charAt(0) || 'U' }}
                            </div>
                        </div>
                        <div class="user-details">
                            <span class="user-name">{{ user?.name }}</span>
                        </div>
                    </div>
                    <button @click="closeMobileSidebar" class="close-sidebar">
                        <i class="fa-solid fa-times"></i>
                    </button>
                </div>

                <!-- Mobilā navigācijas izvēlne -->
                <nav class="mobile-sidebar-nav">
                    <ul class="nav-list">
                        <li class="nav-item">
                            <Link href="#" class="nav-link primary" @click="closeMobileSidebar">
                                <i class="fa-solid fa-gauge-high nav-icon"></i>
                                <span>{{ t('user_pages.layout.overview_label') }}</span>
                            </Link>
                        </li>

                        <li class="nav-item">
                            <Link href="#" class="nav-link primary" @click="closeMobileSidebar">
                                <i class="fa-solid fa-user-gear nav-icon"></i>
                                <span>{{ t('user_pages.layout.profile_settings') }}</span>
                            </Link>
                        </li>

                        <li class="nav-item has-submenu">
                            <button
                                @click="toggleMenu('favorites')"
                                class="nav-link primary submenu-toggle"
                                :class="{ 'expanded': isMenuExpanded('favorites') }"
                            >
                                <i class="fa-regular fa-heart nav-icon"></i>
                                <span>{{ t('user_pages.layout.favorites') }}</span>
                                <i class="fa-solid fa-chevron-right toggle-icon"></i>
                            </button>
                            <ul class="submenu" v-show="isMenuExpanded('favorites')">
                                <li>
                                    <Link href="#" class="submenu-link" @click="closeMobileSidebar">
                                        <i class="fa-solid fa-user-group submenu-icon"></i>
                                        {{ t('user_pages.layout.favorite_artists') }}
                                    </Link>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item has-submenu">
                            <button
                                @click="toggleMenu('playlists')"
                                class="nav-link primary submenu-toggle"
                                :class="{ 'expanded': isMenuExpanded('playlists') }"
                            >
                                <i class="fa-solid fa-list nav-icon"></i>
                                <span>{{ t('user_pages.layout.playlists') }}</span>
                                <i class="fa-solid fa-chevron-right toggle-icon"></i>
                            </button>
                            <ul class="submenu" v-show="isMenuExpanded('playlists')">
                                <li>
                                    <Link href="#" class="submenu-link" @click="closeMobileSidebar">
                                        <i class="fa-regular fa-rectangle-list submenu-icon"></i>
                                        {{ t('user_pages.layout.user_playlists') }}
                                    </Link>
                                </li>
                                <li>
                                    <Link href="#" class="submenu-link" @click="closeMobileSidebar">
                                        <i class="fa-regular fa-plus submenu-icon"></i>
                                        {{ t('user_pages.layout.create_new_pl') }}
                                    </Link>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item has-submenu">
                            <button
                                @click="toggleMenu('recommendations')"
                                class="nav-link primary submenu-toggle"
                                :class="{ 'expanded': isMenuExpanded('recommendations') }"
                            >
                                <i class="fa-solid fa-lightbulb nav-icon"></i>
                                <span>{{ t('user_pages.layout.recommendations') }}</span>
                                <i class="fa-solid fa-chevron-right toggle-icon"></i>
                            </button>
                            <ul class="submenu" v-show="isMenuExpanded('recommendations')">
                                <li>
                                    <Link href="#" class="submenu-link" @click="closeMobileSidebar">
                                        <i class="fa-regular fa-clock submenu-icon"></i>
                                        {{ t('user_pages.layout.history_recom') }}
                                    </Link>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>

                <div class="mobile-language-switch-container">
                    <div class="mobile-language-switch" @click.stop>
                        <button
                            @click="toggleLanguageDropdown"
                            class="mobile-language-selector"
                            :class="{ 'active': activeLanguageDropdown }"
                        >
                            <i class="fa-solid fa-globe"></i>
                            <span class="language-code">{{ locale.toUpperCase() }}</span>
                            <i class="fa fa-caret-down" :class="{ 'rotate': activeLanguageDropdown }"></i>
                        </button>
                        <div v-show="activeLanguageDropdown" class="mobile-language-dropdown">
                            <button
                                @click="changeLanguage('en')"
                                class="mobile-language-option"
                                :class="{ active: locale === 'en' }"
                            >
                                English
                            </button>
                            <button
                                @click="changeLanguage('lv')"
                                class="mobile-language-option"
                                :class="{ active: locale === 'lv' }"
                            >
                                Latviešu
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Atteikšanās mobilajā režīmā -->
                <div class="mobile-sidebar-footer">
                    <Link :href="route('logout')" method="post" as="button" class="logout-button">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        <span>{{ t('user_pages.layout.logout') }}</span>
                    </Link>
                </div>
            </div>
        </aside>

        <!-- Galvenā satura vieta -->
        <main class="main-content">
            <!-- Lapas galvene (ja ir) -->
            <header v-if="$slots.header" class="page-header">
                <div class="header-container">
                    <slot name="header" />
                </div>
            </header>

            <!-- Lapas saturs -->
            <div class="content-container">
                <slot />
            </div>
        </main>
    </div>
</template>

<style scoped>
.app-layout {
    display: flex;
    min-height: 100vh;
    background: linear-gradient(to right, #ffffff, #b3eaff);
}

.desktop-sidebar {
    width: 280px;
    background: white;
    border-right: 1px solid rgba(12, 75, 170, 0.1);
    box-shadow: 4px 0 12px rgba(12, 75, 170, 0.05);
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    z-index: 50;
    overflow-y: auto;
}

.sidebar-content {
    display: flex;
    flex-direction: column;
    height: 100%;
    padding: 1rem 1rem 1.5rem;
}

.logo-container {
    margin-bottom: 1rem;
    padding: 0 0.5rem;
}

.logo-link {
    display: inline-block;
    transition: transform 0.2s ease;
}

.logo-link:hover {
    transform: scale(1.05);
}

.logo {
    height: 3.5rem;
    width: auto;
    fill: #0c4baa;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 0.5rem;
    margin-bottom: 1rem;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
}

.avatar-container {
    flex-shrink: 0;
}

.avatar {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.2);
}

.avatar-placeholder {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    font-weight: 600;
    border: 2px solid white;
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.2);
}

.user-details {
    display: flex;
    flex-direction: column;
    min-width: 0;
}

.user-name {
    font-weight: 600;
    color: #333;
    font-size: 0.95rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.sidebar-nav {
    flex: 1;
    overflow-y: auto;
}

.nav-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.nav-item {
    margin-bottom: 0.25rem;
}

.nav-link {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    color: #4a5568;
    text-decoration: none;
    border-radius: 8px;
    transition: all 0.2s ease;
    font-size: 0.95rem;
}

.nav-link.primary {
    background: transparent;
}

.nav-link.primary:hover {
    background: rgba(12, 75, 170, 0.05);
    color: #0c4baa;
}

.nav-link .nav-icon {
    width: 1.5rem;
    font-size: 1.1rem;
    color: #0c4baa;
    margin-right: 0.75rem;
}

.submenu-toggle {
    width: 100%;
    text-align: left;
    background: none;
    border: none;
    cursor: pointer;
    position: relative;
}

.submenu-toggle .toggle-icon {
    margin-left: auto;
    font-size: 0.8rem;
    transition: transform 0.2s ease;
}

.submenu-toggle.expanded .toggle-icon {
    transform: rotate(90deg);
}

.submenu {
    list-style: none;
    padding-left: 2.5rem;
    margin: 0.25rem 0 0.5rem;
}

.submenu-link {
    display: flex;
    align-items: center;
    padding: 0.6rem 1rem;
    color: #4a5568;
    text-decoration: none;
    border-radius: 6px;
    font-size: 0.9rem;
    transition: all 0.2s ease;
}

.submenu-link:hover {
    background: rgba(12, 75, 170, 0.05);
    color: #0c4baa;
}

.submenu-icon {
    width: 1.25rem;
    font-size: 0.9rem;
    color: #666;
    margin-right: 0.5rem;
}

.submenu-link:hover .submenu-icon {
    color: #0c4baa;
}

.language-switch-container {
    padding: 0.75rem 1rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
    margin-top: 0.5rem;
}

.language-switch {
    position: relative;
}

.language-selector {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    padding: 0.6rem 0.75rem;
    background: rgba(12, 75, 170, 0.05);
    border: 1px solid rgba(12, 75, 170, 0.1);
    border-radius: 8px;
    color: #333;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.language-selector:hover {
    background: rgba(12, 75, 170, 0.1);
}

.language-selector.active {
    background: rgba(12, 75, 170, 0.15);
    border-color: #0c4baa;
}

.language-code {
    font-weight: 600;
    color: #0c4baa;
}

.language-selector i:first-child {
    color: #0c4baa;
}

.language-selector .fa-caret-down {
    transition: transform 0.2s ease;
}

.language-selector .fa-caret-down.rotate {
    transform: rotate(180deg);
}

.language-dropdown {
    position: absolute;
    bottom: 100%;
    left: 0;
    right: 0;
    margin-bottom: 0.5rem;
    background: white;
    border: 1px solid rgba(12, 75, 170, 0.2);
    border-radius: 8px;
    box-shadow: 0 -4px 12px rgba(12, 75, 170, 0.1);
    overflow: hidden;
    z-index: 60;
}

.language-option {
    display: block;
    width: 100%;
    padding: 0.75rem 1rem;
    text-align: left;
    background: none;
    border: none;
    color: #333;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.language-option:hover {
    background: rgba(12, 75, 170, 0.05);
    color: #0c4baa;
}

.language-option.active {
    background: rgba(12, 75, 170, 0.1);
    color: #0c4baa;
    font-weight: 500;
}

.sidebar-footer {
    margin-top: auto;
    padding-top: 1rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
}

.logout-button {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    color: #dc3545;
    text-decoration: none;
    border-radius: 8px;
    transition: all 0.2s ease;
    width: 100%;
    background: none;
    border: none;
    cursor: pointer;
    font-size: 0.95rem;
}

.logout-button:hover {
    background: rgba(220, 53, 69, 0.05);
}

.logout-button i {
    width: 1.5rem;
    margin-right: 0.75rem;
    font-size: 1.1rem;
}

.mobile-header {
    background: white;
    padding: 1rem;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 40;
    display: block;
}

.mobile-header-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 100%;
    margin: 0 auto;
}

.mobile-menu-toggle {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1.5rem;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 8px;
    transition: all 0.2s ease;
}

.mobile-menu-toggle:hover {
    background: rgba(12, 75, 170, 0.05);
}

.mobile-logo {
    display: flex;
    align-items: center;
}

.logo-small {
    height: 2rem;
    width: auto;
    fill: #0c4baa;
}

.mobile-sidebar-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 90;
    display: block;
}

.mobile-sidebar {
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    width: 85%;
    max-width: 320px;
    background: white;
    z-index: 100;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
    box-shadow: 2px 0 12px rgba(0, 0, 0, 0.15);
}

.mobile-sidebar.open {
    transform: translateX(0);
}

.mobile-sidebar-content {
    display: flex;
    flex-direction: column;
    height: 100%;
    padding: 1rem 0;
}

.mobile-sidebar-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 1rem 1rem;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
}

.mobile-sidebar-user {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.avatar-container.small .avatar,
.avatar-container.small .avatar-placeholder {
    width: 40px;
    height: 40px;
    font-size: 1rem;
}

.close-sidebar {
    background: none;
    border: none;
    color: #666;
    font-size: 1.25rem;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 8px;
    transition: all 0.2s ease;
}

.close-sidebar:hover {
    background: rgba(0, 0, 0, 0.05);
    color: #0c4baa;
}

.mobile-sidebar-nav {
    flex: 1;
    overflow-y: auto;
    padding: 1rem;
}

.mobile-language-switch-container {
    padding: 1rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
}

.mobile-language-switch {
    position: relative;
}

.mobile-language-selector {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    width: 100%;
    padding: 0.75rem;
    background: rgba(12, 75, 170, 0.05);
    border: 1px solid rgba(12, 75, 170, 0.1);
    border-radius: 8px;
    color: #333;
    font-size: 0.95rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.mobile-language-selector:hover {
    background: rgba(12, 75, 170, 0.1);
}

.mobile-language-selector.active {
    background: rgba(12, 75, 170, 0.15);
    border-color: #0c4baa;
}

.mobile-language-selector i:first-child {
    color: #0c4baa;
    font-size: 1rem;
}

.mobile-language-selector .fa-caret-down {
    margin-left: auto;
    transition: transform 0.2s ease;
}

.mobile-language-selector .fa-caret-down.rotate {
    transform: rotate(180deg);
}

.mobile-language-dropdown {
    position: absolute;
    bottom: 100%;
    left: 0;
    right: 0;
    margin-bottom: 0.5rem;
    background: white;
    border: 1px solid rgba(12, 75, 170, 0.2);
    border-radius: 8px;
    box-shadow: 0 -4px 12px rgba(12, 75, 170, 0.1);
    overflow: hidden;
    z-index: 60;
}

.mobile-language-option {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    width: 100%;
    padding: 0.75rem 1rem;
    text-align: left;
    background: none;
    border: none;
    color: #333;
    font-size: 0.95rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.mobile-language-option:hover {
    background: rgba(12, 75, 170, 0.05);
    color: #0c4baa;
}

.mobile-language-option.active {
    background: rgba(12, 75, 170, 0.1);
    color: #0c4baa;
    font-weight: 500;
}

.language-dropdown, .mobile-language-dropdown {
    z-index: 1000;
}

.mobile-sidebar-footer {
    padding: 1rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
}

.main-content {
    flex: 1;
    margin-left: 0;
    padding-top: 4rem;
    min-height: 100vh;
}

.page-header {
    background: white;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
    padding: 1.5rem 2rem;
}

.header-container {
    max-width: 1200px;
    margin: 0 auto;
}

.content-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

/* Responsivitāte */
@media (min-width: 1024px) {
    .desktop-sidebar {
        display: block;
    }

    .mobile-header {
        display: none;
    }

    .mobile-sidebar-overlay {
        display: none;
    }

    .mobile-sidebar {
        display: none;
    }

    .main-content {
        margin-left: 280px;
        padding-top: 0;
    }
}

/* Animācijas */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-10px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.nav-link, .submenu-link {
    animation: slideIn 0.2s ease-out;
}

</style>
