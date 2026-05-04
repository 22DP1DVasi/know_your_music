<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';
import { route } from "ziggy-js";
import { useI18n } from 'vue-i18n';
import CreatePlaylistModal from "@/Components/Playlists/CreatePlaylistModal.vue";

const showingMobileSidebar = ref(false);
const expandedMenus = ref([]); // izseko izvērstās sadaļas
const activeLanguageDropdown = ref(false);

const page = usePage()
const user = computed(() => page.props.auth?.user ?? null)

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

const showCreateForm = ref(false);
// kolekcijas izveidošanas forma
const newPlaylistForm = ref({
    name: '',
    description: '',
    is_private: false
});

const errors = ref({
    name: null
});

const openCreateForm = () => {
    showCreateForm.value = true;
};

const closeCreateForm = () => {
    showCreateForm.value = false;
    newPlaylistForm.value = { name: '', description: '', is_private: false };
    errors.value = { name: null };
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
        <!-- Datora darbvirsmas sānjosla, tikai autentificētiem lietotājiem -->
        <aside v-if="user" class="desktop-sidebar">
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
                            v-if="user.avatar_url"
                            :src="user.avatar_url"
                            :alt="user.name"
                            class="avatar"
                        >
                        <div
                            v-else
                            class="avatar-initial"
                            :style="{
                                background: `linear-gradient(135deg, ${user.avatar_color_1}, ${user.avatar_color_2})`
                            }"
                        >
                            {{ user.initial }}
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
                            <Link :href="route('dashboard')" class="nav-link primary">
                                <i class="fa-solid fa-gauge-high nav-icon"></i>
                                <span>{{ t('user_pages.layout.overview_label') }}</span>
                            </Link>
                        </li>

                        <!-- Profila iestatījumi -->
                        <li class="nav-item">
                            <Link :href="route('settings.edit')" class="nav-link primary">
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
                                    <Link :href="route('dashboard.favorites.artists')" class="submenu-link">
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
                                    <Link :href="route('dashboard.playlists')" class="submenu-link">
                                        <i class="fa-regular fa-rectangle-list submenu-icon"></i>
                                        {{ t('user_pages.layout.user_playlists') }}
                                    </Link>
                                </li>
                                <li>
                                    <button
                                        @click="openCreateForm"
                                        class="submenu-link"
                                    >
                                        <i class="fa-regular fa-plus submenu-icon"></i>
                                        {{ t('user_pages.layout.create_new_pl') }}
                                    </button>
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

        <!-- Datora darbvirsmas sānjosla, viesiem -->
        <aside v-else class="desktop-sidebar guest-sidebar">
            <div class="sidebar-content">
                <div class="logo-container">
                    <Link :href="route('home')" class="logo-link">
                        <img src="/images/mini-logo.png" alt="Logo" class="logo">
                    </Link>
                </div>

                <nav class="sidebar-nav">
                    <ul class="nav-list">
                        <li class="nav-item">
                            <Link :href="route('home')" class="nav-link primary">
                                <i class="fa-solid fa-house nav-icon"></i>
                                <span>{{ t('user_pages.layout.home') }}</span>
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link :href="route('explore.artists')" class="nav-link primary">
                                <i class="fa-solid fa-microphone nav-icon"></i>
                                <span>{{ t('user_pages.layout.explore_artists') }}</span>
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link :href="route('explore.releases')" class="nav-link primary">
                                <i class="fa-solid fa-compact-disc nav-icon"></i>
                                <span>{{ t('user_pages.layout.explore_releases') }}</span>
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link :href="route('explore.genres')" class="nav-link primary">
                                <i class="fa-solid fa-tag nav-icon"></i>
                                <span>{{ t('user_pages.layout.explore_genres') }}</span>
                            </Link>
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

                <div class="sidebar-footer">
                    <Link :href="route('login')" class="login-button">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        <span>{{ t('user_pages.layout.login') }}</span>
                    </Link>
                    <Link :href="route('signup')" class="signup-button">
                        <i class="fa-solid fa-user-plus"></i>
                        <span>{{ t('user_pages.layout.signup') }}</span>
                    </Link>
                </div>
            </div>
        </aside>

        <!-- Mobilā režīma galvene, viesiem un lietotājiem -->
        <header class="mobile-header">
            <div class="mobile-header-content">
                <div class="mobile-logo">
                    <Link :href="route('home')" class="logo-link">
                        <img src="/images/mini-logo.png" alt="Logo" class="logo">
                    </Link>
                </div>
                <div class="hamburger" @click="toggleMobileSidebar">
                    <span class="line"></span>
                    <span class="line"></span>
                    <span class="line"></span>
                </div>
            </div>
        </header>

        <!-- Mobilās sānjoslas pārklājums -->
        <transition name="fade">
            <div
                v-if="showingMobileSidebar"
                class="mobile-sidebar-overlay"
                @click="closeMobileSidebar"
            ></div>
        </transition>

        <!-- Mobilā režīma sānjosla, autentificētiem lietotājiem -->
        <transition name="slide-right">
            <aside v-if="showingMobileSidebar && user" class="mobile-sidebar">
                <div class="mobile-sidebar-content">
                    <!-- Mobilās sānjoslas galvene -->
                    <div class="mobile-sidebar-header">
                        <div class="mobile-sidebar-user">
                            <div class="avatar-container small">
                                <img
                                    v-if="user.avatar_url"
                                    :src="user.avatar_url"
                                    :alt="user.name"
                                    class="avatar"
                                >
                                <div
                                    v-else
                                    class="avatar-initial"
                                    :style="{
                                    background: `linear-gradient(135deg, ${user.avatar_color_1}, ${user.avatar_color_2})`
                                }"
                                >
                                    {{ user.initial }}
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
                                <Link :href="route('dashboard')" class="nav-link primary" @click="closeMobileSidebar">
                                    <i class="fa-solid fa-gauge-high nav-icon"></i>
                                    <span>{{ t('user_pages.layout.overview_label') }}</span>
                                </Link>
                            </li>

                            <li class="nav-item">
                                <Link :href="route('settings.edit')" class="nav-link primary" @click="closeMobileSidebar">
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
                                        <Link :href="route('dashboard.favorites.artists')" class="submenu-link" @click="closeMobileSidebar">
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
                                        <Link :href="route('dashboard.playlists')" class="submenu-link" @click="closeMobileSidebar">
                                            <i class="fa-regular fa-rectangle-list submenu-icon"></i>
                                            {{ t('user_pages.layout.user_playlists') }}
                                        </Link>
                                    </li>
                                    <li>
                                        <button @click="openCreateForm; closeMobileSidebar()" class="submenu-link">
                                            <i class="fa-regular fa-plus submenu-icon"></i>
                                            {{ t('user_pages.layout.create_new_pl') }}
                                        </button>
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
        </transition>

        <!-- Mobilā režīma sānjosla, viesiem -->
        <transition name="slide-right">
            <aside v-if="showingMobileSidebar && !user" class="mobile-sidebar guest-sidebar">
                <div class="mobile-sidebar-content">
                    <div class="mobile-sidebar-header">
                        <div class="mobile-sidebar-user">
                            <i class="fa-regular fa-circle-user guest-avatar"></i>
                            <div class="user-details">
                                <span class="user-name">{{ t('user_pages.layout.guest') }}</span>
                            </div>
                        </div>
                        <button @click="closeMobileSidebar" class="close-sidebar">
                            <i class="fa-solid fa-times"></i>
                        </button>
                    </div>

                    <nav class="mobile-sidebar-nav">
                        <ul class="nav-list">
                            <li class="nav-item">
                                <Link :href="route('home')" class="nav-link primary" @click="closeMobileSidebar">
                                    <i class="fa-solid fa-house nav-icon"></i>
                                    <span>{{ t('user_pages.layout.home') }}</span>
                                </Link>
                            </li>
                            <li class="nav-item">
                                <Link :href="route('explore.artists')" class="nav-link primary" @click="closeMobileSidebar">
                                    <i class="fa-solid fa-microphone nav-icon"></i>
                                    <span>{{ t('user_pages.layout.explore_artists') }}</span>
                                </Link>
                            </li>
                            <li class="nav-item">
                                <Link :href="route('explore.releases')" class="nav-link primary" @click="closeMobileSidebar">
                                    <i class="fa-solid fa-compact-disc nav-icon"></i>
                                    <span>{{ t('user_pages.layout.explore_releases') }}</span>
                                </Link>
                            </li>
                            <li class="nav-item">
                                <Link :href="route('explore.genres')" class="nav-link primary" @click="closeMobileSidebar">
                                    <i class="fa-solid fa-tag nav-icon"></i>
                                    <span>{{ t('user_pages.layout.explore_genres') }}</span>
                                </Link>
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

                    <div class="mobile-sidebar-footer">
                        <Link :href="route('login')" class="login-button">
                            <i class="fa-solid fa-right-to-bracket"></i>
                            <span>{{ t('user_pages.layout.login') }}</span>
                        </Link>
                        <Link :href="route('signup')" class="signup-button">
                            <i class="fa-solid fa-user-plus"></i>
                            <span>{{ t('user_pages.layout.signup') }}</span>
                        </Link>
                    </div>
                </div>
            </aside>
        </transition>

        <!-- Galvenā satura vieta, vienmēr redzama -->
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

    <!-- Jaunas kolekcijas izveides veidlapa, tikai lietotājiem -->
    <CreatePlaylistModal
        v-if="user"
        :show="showCreateForm"
        :show-description="true"
        :redirect-after-create="true"
        @close="closeCreateForm"
        @created="closeCreateForm"
    />
</template>

<style scoped>
.app-layout {
    display: flex;
    min-height: 100vh;
    background: linear-gradient(to right, #ffffff, #b3eaff);
    width: 100%;
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
    flex-shrink: 0;
}

.desktop-sidebar.guest-sidebar {
    display: none;
}

.guest-avatar {
    font-size: 2rem;
    color: #0c4baa;
}

.login-button,
.signup-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.6rem 1rem;
    border-radius: 8px;
    font-size: 0.9rem;
    font-weight: 500;
    transition: all 0.2s ease;
    width: 100%;
    margin-bottom: 0.5rem;
    text-decoration: none;
}

.login-button {
    background: white;
    border: 1px solid rgba(12, 75, 170, 0.2);
    color: #0c4baa;
}

.login-button:hover {
    background: rgba(12, 75, 170, 0.05);
    border-color: #0c4baa;
}

.signup-button {
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    color: white;
    border: none;
}

.signup-button:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.3);
}

.mobile-sidebar.guest-sidebar .guest-avatar {
    font-size: 2.5rem;
}

.mobile-sidebar.guest-sidebar .login-button,
.mobile-sidebar.guest-sidebar .signup-button {
    justify-content: center;
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
    transition: all 0.2s ease;
}

.hamburger:hover .line {
    background: #20c1f7;
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

.avatar-initial {
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

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}

.mobile-sidebar {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    width: 85%;
    max-width: 320px;
    background: white;
    z-index: 100;
    box-shadow: -4px 0 24px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
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

.slide-right-enter-active,
.slide-right-leave-active {
    transition: transform 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
}
.slide-right-enter-from,
.slide-right-leave-to {
    transform: translateX(100%);
}

.avatar-container.small .avatar,
.avatar-container.small .avatar-initial {
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
    min-width: 0;
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
    .desktop-sidebar,
    .desktop-sidebar.guest-sidebar {
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
