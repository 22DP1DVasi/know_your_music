<script setup>
import {ref, onMounted, watch, computed} from "vue";
import { usePage, router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n'

const page = usePage();

const isDarkMode = ref(localStorage.getItem("darkMode") === "true");
const isMenuActive = ref(false);
const isMobileSearchActive = ref(false);
const activeDropdown = ref(null);
const closeAllDropdowns = () => {
    activeDropdown.value = null;
};
// reaktīvas vērtības
const user = computed(() => page.props.auth?.user ?? null);
const isLoggedIn = computed(() => !!user.value);

const toggleDarkMode = () => {
    isDarkMode.value = !isDarkMode.value;
    // document.documentElement.classList.toggle("dark-mode", isDarkMode.value);
    localStorage.setItem("darkMode", isDarkMode.value);
};

watch(isDarkMode, (val) => {
    document.documentElement.classList.toggle("dark-mode", val);
    localStorage.setItem("darkMode", val);
});

const toggleNav = () => {
    isMenuActive.value = !isMenuActive.value;
};

const toggleDropdown = (name) => {
    activeDropdown.value =
        activeDropdown.value === name ? null : name;
};

const redirectToExplore = (type) => {
    router.visit(`/explore/${type}`);
};

const logout = () => {
    router.post('/logout');
};

const toggleMobileSearch = () => {
    isMobileSearchActive.value = !isMobileSearchActive.value;
};
onMounted(() => {
    window.addEventListener('click', closeAllDropdowns)
});

const searchQuery = ref('');

const performSearch = () => {
    if (searchQuery.value.trim()) {
        router.get('/search', {
            q: searchQuery.value.trim()
        });
    }
};

const { locale, t } = useI18n()

const changeLanguage = (lang) => {
    locale.value = lang;
    localStorage.setItem('locale', lang);
}

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

</script>

<template>
    <!-- Navigācijas joslas elementu nodrošina https://github.com/daniilsonufrijuks un modificēts, lai atbilstu tīmekļa vietnes mērķim -->
    <nav>
        <div class="nav-left">
            <ul>
                <li>
                    <a href="/" class="logo-container">
                        <img src="../../../public/images/mini-logo.png" alt="Logo" class="logo">
                        <p>Know Your Music</p>
                    </a>
                </li>
            </ul>
        </div>
        <div class="nav-center">
            <div class="search-container-pc">
                <div class="search">
                    <input
                        type="search"
                        autocomplete="off"
                        class="searchTerm"
                        placeholder="Search..."
                        v-model="searchQuery"
                        @keyup.enter="performSearch"
                    >
                    <button
                        type="submit"
                        class="searchButton"
                        @click="performSearch"
                    >
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="nav-right">
            <ul class="buttons-list">
                <!--            <li><a href="/">{{ t('navbar.home') }}</a></li>-->
                <li class="explore-menu">
                    <div
                        class="explore-link"
                        role="button"
                        tabindex="0"
                        @click="toggleDropdown('explore')"
                        @click.stop
                        @keydown.enter="toggleDropdown('explore')"
                    >
                        {{ t('navbar.explore') }} <i class="fa fa-caret-down"></i>
                    </div>
                    <div v-show="activeDropdown === 'explore'" class="explore-dropdown">
                        <a href="#" @click.prevent="redirectToExplore('artists')">{{ t('navbar.explore_artists') }}</a>
                        <a href="#" @click.prevent="redirectToExplore('releases')">{{ t('navbar.explore_releases') }}</a>
                        <!--                    <a href="#" @click.prevent="redirectToExplore('tracks')">{{ t('navbar.explore_tracks') }}</a>-->
                        <a href="#" @click.prevent="redirectToExplore('genres')">{{ t('navbar.explore_genres') }}</a>
                    </div>
                </li>
                <li><a href="/about">{{ t('navbar.about') }}</a></li>

                <!-- Valodas slēdzis -->
                <li class="language-switch">
                    <div
                        class="language-selector"
                        role="button"
                        tabindex="0"
                        @click="toggleDropdown('language')"
                        @click.stop
                        @keydown.enter="toggleDropdown('language')"
                    >
                        <span class="language-code">{{ locale.toUpperCase() }}</span>
                        <i class="fa fa-caret-down"></i>
                    </div>
                    <div v-show="activeDropdown === 'language'" class="language-dropdown">
                        <a
                            href="#"
                            @click.prevent="changeLanguage('en')"
                            :class="{ active: locale === 'en' }"
                        >
                            English
                        </a>
                        <a
                            href="#"
                            @click.prevent="changeLanguage('lv')"
                            :class="{ active: locale === 'lv' }"
                        >
                            Latviešu
                        </a>
                    </div>
                </li>

                <li v-if="!isLoggedIn"><a href="/login">{{ t('navbar.login') }}</a></li>
                <li v-if="!isLoggedIn"><a href="/signup">{{ t('navbar.signup') }}</a></li>
                <li v-if="isLoggedIn" class="user-menu">
                    <div
                        class="user-avatar"
                        role="button"
                        tabindex="0"
                        @click="toggleDropdown('user')"
                        @click.stop
                        @keydown.enter="toggleDropdown('user')"
                    >
                        <i class="fa fa-user-circle"></i>
                        <span class="username">{{ user.name }}</span>
                        <div v-show="activeDropdown === 'user'" class="user-dropdown">
                            <a href="/profile">{{ t('navbar.account') }}</a>
                            <a href="/settings">{{ t('navbar.profile_settings') }}</a>
                            <a href="#" @click.prevent="logout">{{ t('navbar.logout') }}</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <!-- meklēšanas poga mobilajās ierīcēs -->
        <button class="mobile-search-button" @click="toggleMobileSearch">
            <i class="fa fa-search"></i>
        </button>
        <!-- hamburger izvēlne -->
<!--        <div class="hamburger" @click="toggleNav">-->
        <div
            class="hamburger"
            role="button"
            aria-label="Toggle menu"
            @click="toggleNav"
        >
            <span class="line"></span>
            <span class="line"></span>
            <span class="line"></span>
        </div>
    </nav>
    <!-- izvēlne mobilajās ierīcēs -->
    <div
        class="overlay"
        :class="{ active: isMenuActive }"
        @click="toggleNav"
    ></div>
    <div class="menubar" :class="{ active: isMenuActive }">
        <div class="menubar-header">
            <span>{{ t('navbar.menu') }}</span>
        </div>
        <ul>
            <!-- Valodas slēdzis mobilajās ierīcēs -->
            <li class="mobile-language-switch">
                <div class="mobile-language-label">{{ t('navbar.language') }}:</div>
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
            </li>

            <!-- nosacījuma atveidošana mobilajai izvēlnei -->
<!--            <li><a href="/">{{ t('navbar.home') }}</a></li>-->
            <li class="mobile-explore-item">
                <a
                    href="#"
                    @click="toggleDropdown('mobile_explore')"
                    @click.stop
                >
                    {{ t('navbar.explore') }} <i class="fa fa-caret-down"></i>
                </a>
                <div v-show="activeDropdown === 'mobile_explore'" class="mobile-explore-dropdown">
                    <a href="/explore/artists">{{ t('navbar.explore_artists') }}</a>
                    <a href="/explore/releases">{{ t('navbar.explore_releases') }}</a>
<!--                    <a href="/explore/tracks">{{ t('navbar.explore_tracks') }}</a>-->
                    <a href="/explore/genres">{{ t('navbar.explore_genres') }}</a>
                </div>
            </li>
            <li><a href="/about">{{ t('navbar.about') }}</a></li>
            <li v-if="!isLoggedIn"><a href="/login">{{ t('navbar.login') }}</a></li>
            <li v-if="!isLoggedIn"><a href="/signup">{{ t('navbar.signup') }}</a></li>
            <li v-if="isLoggedIn"><a href="/profile">{{ t('navbar.account') }}</a></li>
            <li v-if="isLoggedIn"><a href="/settings">{{ t('navbar.profile_settings') }}</a></li>
            <li v-if="isLoggedIn"><a href="#" @click.prevent="logout">{{ t('navbar.logout') }}</a></li>
        </ul>
    </div>
    <!-- meklēšanas josla mobilajām ierīcēm -->
    <div v-show="isMobileSearchActive" class="mobile-search-container">
        <div class="search">
            <input
                type="search"
                autocomplete="off"
                class="searchTerm"
                placeholder="Search..."
                v-model="searchQuery"
                @keyup.enter="performSearch"
            />
            <button
                type="submit"
                class="searchButton"
                @click="performSearch"
            >
                <i class="fa fa-search"></i>
            </button>
        </div>
    </div>
</template>

<style scoped>
nav {
    background-color: rgb(185, 225, 255);
    padding: 5px 2%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    z-index: 1;
    height: 55px;
    min-height: 55px;
    position: relative;
}

.nav-left {
    align-items: center;
}

.nav-center {
    flex: 1;
    display: flex;
    justify-content: center;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    width: min(500px, 40%);
}

.nav-right {
    align-items: center;
    margin-left: auto;
}

.nav-right ul {
    display: flex;
    align-items: center;
    margin: 0;
    padding: 0;
}

nav ul {
    list-style: none;
    display: flex;
}

.buttons-list li {
    margin-left: 1rem;
    display: flex;
    align-items: center;
    /**height: 100%;
    min-height: 55px;**/
}

.buttons-list li a {
    text-decoration: none;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    font-weight: 400;
    padding: 12px 6px;
    border-radius: 5px;
    display: block; /* aizņem visu li platumu */
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.buttons-list li a:hover {
    background-color: #20c1f7;
}

.logo-container {
    height: 55px;
    display: flex;
    align-items: center;
    text-decoration: none; /* noņemt pasvītrojumu no saites */
    cursor: pointer;
    margin: 0;
    padding: 0;
}

.logo {
    width: 100px;
    height: 56px;
    object-fit: contain;
    margin-right: 10px;
    margin-bottom: 4px;
}

.logo-container p {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 1.2rem;
    font-weight: bold;
}

.search-container-pc {
    width: 80%;
}

.search {
    margin: 0 auto;
    width: 100%;
    position: relative;
    display: flex;
    z-index: 1;
}

.searchTerm {
    width: 100%;
    border: 3px solid #54b3ebed;
    border-right: none;
    padding: 10px;
    height: 40px;
    border-radius: 7px 0 0 7px;
    outline: none;
    color: #000000;
    font-size: 16px;
}

.searchTerm:focus {
    outline: none !important;
    box-shadow: none !important;
}

.searchButton {
    position: relative;
    width: 40px;
    height: 40px;
    border: 1px solid #54b3ebed;
    background: #54b3ebed;
    text-align: center;
    color: #fff;
    border-radius: 0 7px 7px 0;
    cursor: pointer;
    font-size: 20px;
    overflow: hidden;
}

.searchButton i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

/* mainīt uz mūzikas ikonu, novietojot kursoru */
.searchButton:hover i {
    opacity: 0;
    transform: scale(0.5);
}

/* mūzikas ikonas pievienošana pēc kursora novietošanas */
.searchButton:hover::after {
    content: "\f001";
    font-family: "FontAwesome";
    font-size: 20px;
    color: #fff;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.searchButton::after {
    content: "";
    opacity: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.5);
}

.explore-menu {
    position: relative;
    padding: 12px 6px;
    display: block;
    height: 100%;
    min-height: 55px;
}

.explore-link {
    cursor: pointer;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    font-weight: 400;
    border-radius: 5px;
    display: flex;
    align-items: center;
    padding: 12px 6px;
    transition: background-color 0.3s ease;
}

.explore-link:hover {
    background-color: #20c1f7;
}

.explore-link i {
    margin-left: 5px;
    font-size: 14px;
}

.explore-dropdown {
    position: absolute;
    top: 90%;
    left: 0;
    background-color: white;
    border-radius: 4px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    min-width: 160px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.explore-dropdown a {
    padding: 10px 16px;
    text-decoration: none;
    color: #333;
    font-family: Arial, Helvetica, sans-serif;
    transition: background-color 0.2s;
}

.explore-dropdown a:hover {
    background-color: #f5f5f5;
}

.language-switch {
    position: relative;
    padding: 12px 6px;
    display: block;
    height: 100%;
    min-height: 55px;
}

.language-selector {
    cursor: pointer;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    font-weight: 400;
    border-radius: 5px;
    display: flex;
    align-items: center;
    transition: background-color 0.3s ease;
    box-sizing: border-box;
    padding: 12px 6px;
}

.language-selector:hover {
    background-color: #20c1f7;
}

.language-code {
    font-size: 16px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.language-selector i {
    margin-left: 6px;
    font-size: 14px;
}

.language-dropdown {
    position: absolute;
    top: 90%;
    right: 0;
    background-color: white;
    border-radius: 4px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    min-width: 140px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.language-dropdown a {
    padding: 10px 16px;
    text-decoration: none;
    color: #333;
    font-family: Arial, Helvetica, sans-serif;
    transition: background-color 0.2s;
    font-size: 15px;
    white-space: nowrap;
}

.language-dropdown a:hover {
    background-color: #f5f5f5;
}

.language-dropdown a.active {
    background-color: #e8f4fc;
    color: #007bff;
    font-weight: 500;
}

.mobile-language-switch {
    display: flex;
    flex-direction: column;
    padding: 15px 10px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    margin-bottom: 10px;
}

.mobile-language-label {
    font-size: 14px;
    color: #666;
    margin-bottom: 8px;
    font-family: Arial, Helvetica, sans-serif;
}

.mobile-language-options {
    display: flex;
    gap: 10px;
}

.mobile-language-options button {
    background: none;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 8px 12px;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
    font-family: Arial, Helvetica, sans-serif;
    color: #333;
    flex: 1;
}

.mobile-language-options button:hover {
    background-color: #f5f5f5;
    border-color: #ccc;
}

.mobile-language-options button.active {
    background-color: #20c1f7;
    color: white;
    border-color: #20c1f7;
}

.mobile-explore-dropdown {
    padding-left: 20px;
    display: flex;
    flex-direction: column;
}

.mobile-explore-dropdown a {
    padding: 8px 0;
    color: #000;
    text-decoration: none;
}

.mobile-explore-item {
    position: relative;
}

.mobile-explore-item > a {
    display: flex;
    align-items: center;
}

.mobile-explore-item i {
    margin-left: 5px;
    font-size: 14px;
}

.language-switch select {
    background: transparent;
    border: none;
    font-size: 14px;
    cursor: pointer;
    padding: 6px;
}

.user-avatar {
    display: flex;
    align-items: center;
    cursor: pointer;
    position: relative;
    padding: 12px 16px;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    height: 100%;
    box-sizing: border-box;
    min-width: 0;
}

.user-avatar:hover {
    background-color: #20c1f7;
}

.user-avatar i {
    font-size: 24px;
    margin-right: 8px;
    flex-shrink: 0;
}

.username {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 16px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    flex-shrink: 1;
    min-width: 0;
    max-width: 150px;
    display: inline-block;
    vertical-align: middle;
}

.user-dropdown {
    position: absolute;
    top: 100%;
    right: 0;
    background-color: white;
    border-radius: 4px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    min-width: 160px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.user-dropdown a {
    padding: 10px 16px;
    text-decoration: none;
    color: #333;
    font-family: Arial, Helvetica, sans-serif;
    transition: background-color 0.2s;
}

.user-dropdown a:hover {
    background-color: #f5f5f5;
}

.user-menu {
    position: relative;
    margin-left: 1.5rem;
    max-width: 200px;
    min-width: fit-content;
}

.mobile-search-container {
    background-color: rgb(185, 225, 255);
    padding: 10px;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 8px;
}

.mobile-search-button {
    display: none;
    background: none;
    border: none;
    font-size: 23px;
    cursor: pointer;
    color: #000;
    margin-right: 40px;
}

.menubar {
    position: absolute;
    top: 0;
    transform: translateX(-100%);
    display: flex;
    font-family: Arial, Helvetica, sans-serif;
    justify-content: center;
    align-items: flex-start;
    width: 60%;
    height: 100vh;
    padding: 20% 0;
    background-color: rgb(201, 229, 250);
    transition: all 0.5s ease-in;
    z-index: 500;
}

.menubar.active {
    transform: translateX(0);
    left: 0;
    width: 40%;
    box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
}

.menubar ul {
    padding: 0;
    list-style: none;
    margin-top: 20%;
}

.menubar ul li {
    margin-bottom: 20px;
    font-size: 1.3em;
}

.menubar ul li a {
    text-decoration: none;
    color: #000;
    font-size: 95%;
    font-weight: 400;
    padding: 5px 10px;
}

.menubar-header {
    position: absolute; /* fiksēts izvēlnes augšdaļā */
    top: 0;
    left: 0;
    width: 100%;
    height: 50px;
    background-color: rgb(185, 225, 255);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 10px;
    box-sizing: border-box;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    z-index: 2;
    font-size: 1.3rem;
}

/* pārklājums, lai nosegtu ekrānu, kad izvēlne ir aktīva */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1;
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.3s ease, visibility 0.3s ease;
}

.overlay.active {
    opacity: 1;
    visibility: visible;
}

.hamburger {
    display: none;
    cursor: pointer;
}

.hamburger .line {
    width: 25px;
    height: 2px;
    background-color: #ffffff;
    display: block;
    margin: 7px auto;
    transition: all 0.3s ease-in-out;
}

/** Responsivitāte **/
@media (max-width: 1370px){
    .search {
        width: 90%;
    }
}

@media (max-width: 1270px) {
    .search-container-pc {
        margin-right: 30px;
    }
}

@media (max-width: 1220px) {
    .hamburger {
        display: block;
    }

    .buttons-list {
        display: none !important;
    }

    /**.search-container-pc {
        display: none;
    }**/

    .nav-center {
        display: none;
    }

    .language-switch {
        margin-left: 0;
    }

    .mobile-search-button {
        display: block;
    }
}

@media (max-width: 600px){
    .menubar.active {
        width: 60%;
    }
}

@media (max-width: 430px){
    .menubar.active {
        width: 85%;
    }

    .mobile-search-button {
        margin-right: 20px;
    }
}

@media (max-width: 370px) {
    .logo-container p {
        display: none;
    }

    .mobile-language-options {
        flex-direction: column;
    }
}

</style>
