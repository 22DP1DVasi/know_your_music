<template>
    <!-- Navbar element provided by https://github.com/daniilsonufrijuks and modified to fit into website purpose -->
    <nav>
        <a href="/" class="logo-container">
            <img src="../../../public/images/mini-logo.png" alt="Logo" class="logo">
            <p>Know Your Music</p>
        </a>
        <ul>
            <li>
                <div class="wrap">
                    <div class="search">
                        <input
                            type="text"
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
            </li>
            <li><a href="/">Home</a></li>
            <li><a href="/explore">Explore</a></li>
            <li><a href="/about">About</a></li>
            <li v-if="!isLoggedIn"><a href="/login">Log In</a></li>
            <li v-if="!isLoggedIn"><a href="/signup">Sign Up</a></li>
            <li v-if="isLoggedIn" class="user-menu">
                <div class="user-avatar" @click="toggleUserDropdown">
                    <i class="fa fa-user-circle"></i>
                    <span class="username">{{ user.name }}</span>
                    <div v-show="showUserDropdown" class="user-dropdown">
                        <a href="/profile">Profile</a>
                        <a href="/settings">Settings</a>
                        <a href="#" @click.prevent="logout">Log Out</a>
                    </div>
                </div>
            </li>
        </ul>
        <!-- search button for mobile -->
        <button class="mobile-search-button" @click="toggleMobileSearch" v-show="isMobile">
            <i class="fa fa-search"></i>
        </button>
        <!-- hamburger menu -->
        <div class="hamburger" @click="toggleNav">
            <span class="line"></span>
            <span class="line"></span>
            <span class="line"></span>
        </div>
    </nav>
    <!-- menubar for mobiles -->
    <div
        class="overlay"
        :class="{ active: isMenuActive }"
        @click="toggleNav"
    ></div>
    <div class="menubar" :class="{ active: isMenuActive }">
        <div class="menubar-header">
            <span>MENU</span>
        </div>
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/explore">Explore</a></li>
            <li><a href="/about">About</a></li>
            <!-- Conditional rendering for mobile menu -->
            <li v-if="!isLoggedIn"><a href="/login">Log In</a></li>
            <li v-if="!isLoggedIn"><a href="/signup">Sign Up</a></li>
            <li v-if="isLoggedIn"><a href="/profile">Profile</a></li>
            <li v-if="isLoggedIn"><a href="/settings">Settings</a></li>
            <li v-if="isLoggedIn"><a href="#" @click.prevent="logout">Log Out</a></li>
        </ul>
    </div>
    <!-- search bar for mobile -->
    <div v-show="isMobileSearchActive" class="mobile-search-container">
        <div class="search">
            <input
                type="text"
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

<script>
import { ref, onMounted, onUnmounted, watch } from "vue";
import { usePage, router } from '@inertiajs/vue3';

export default {
    setup() {
        const page = usePage();

        // Dark mode state
        const isDarkMode = ref(localStorage.getItem("darkMode") === "true");

        // Menu state
        const isMenuActive = ref(false);

        // Mobile state
        const isMobile = ref(false);
        const isMobileSearchActive = ref(false);

        // User dropdown state
        const showUserDropdown = ref(false);

        // Authentication state
        const isLoggedIn = ref(page.props.auth.user !== null);
        const user = ref(page.props.auth.user || { name: 'User' });

        // Toggle dark mode function
        const toggleDarkMode = () => {
            isDarkMode.value = !isDarkMode.value;
            document.documentElement.classList.toggle("dark-mode", isDarkMode.value);
            localStorage.setItem("darkMode", isDarkMode.value);
        };

        // Toggle navigation menu function
        const toggleNav = () => {
            isMenuActive.value = !isMenuActive.value;
            // Close user dropdown when opening mobile menu
            if (isMenuActive.value) {
                showUserDropdown.value = false;
            }
        };

        // Toggle user dropdown
        const toggleUserDropdown = () => {
            showUserDropdown.value = !showUserDropdown.value;
        };

        // Close dropdown when clicking outside
        const closeDropdownOnClickOutside = (event) => {
            if (!event.target.closest('.user-menu')) {
                showUserDropdown.value = false;
            }
        };

        // Logout function - corrected version
        const logout = () => {
            router.post('/logout', {}, {
                onFinish: () => {
                    // Reset user state after logout
                    isLoggedIn.value = false;
                    user.value = { name: 'User' };
                    showUserDropdown.value = false;
                }
            });
        };

        // Toggle mobile search bar visibility
        const toggleMobileSearch = () => {
            isMobileSearchActive.value = !isMobileSearchActive.value;
        };

        // Handle screen size changes to detect mobile view
        const handleResize = () => {
            isMobile.value = window.innerWidth <= 910;
        };

        // Apply dark mode on mount if it's active
        if (isDarkMode.value) {
            document.documentElement.classList.add("dark-mode");
        }

        // Add event listeners on mount
        onMounted(() => {
            window.addEventListener("resize", handleResize);
            window.addEventListener('click', closeDropdownOnClickOutside);
            handleResize(); // Check screen size on initial load
        });

        // Cleanup event listeners
        onUnmounted(() => {
            window.removeEventListener("resize", handleResize);
            window.removeEventListener('click', closeDropdownOnClickOutside);
        });

        // search query state
        const searchQuery = ref('');

        const performSearch = () => {
            if (searchQuery.value.trim()) {
                router.get('/search', {
                    q: searchQuery.value.trim()
                });
            }
        };

        return {
            isDarkMode,
            toggleDarkMode,
            isMenuActive,
            toggleNav,
            isMobile,
            isMobileSearchActive,
            toggleMobileSearch,
            isLoggedIn,
            user,
            showUserDropdown,
            toggleUserDropdown,
            logout,
            searchQuery,
            performSearch
        };
    },
};
</script>

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

nav ul {
    list-style: none;
    display: flex;
}

nav ul li {
    margin-left: 1rem;
    display: flex;
    align-items: center;
    height: 100%;
    min-height: 55px;
}

nav ul li a {
    text-decoration: none;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    font-weight: 400;
    padding: 12px 16px;
    border-radius: 5px;
    display: block; /* takes up the full width of the li */
    font-size: 16px;
    transition: background-color 0.3s ease;
}

nav ul li a:hover {
    background-color: #20c1f7;
}

.logo-container {
    height: 55px;
    display: flex;
    align-items: center;
    text-decoration: none; /* remove underline from the link */
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

.wrap {
    width: 25%;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* adjust for true center */
    z-index: 2;
}

.search {
    margin: 0 auto;
    width: 100%;
    position: relative; /* ensure children are positioned relative to this */
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

/* change to music icon on hover */
.searchButton:hover i {
    opacity: 0;
    transform: scale(0.5);
}

/* add the music icon after hover */
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

/* mobile search container */
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
    background: none;
    border: none;
    font-size: 23px;
    cursor: pointer;
    color: #000;
    margin-left: 10px;
}

.menubar {
    position: absolute;
    top: 0;
    left: -60%;
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
    position: absolute; /* fixed at the top of the menubar */
    top: 0;
    left: 0;
    width: 100%;
    height: 50px;
    background-color: rgb(185, 225, 255);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 10px;
    box-sizing: border-box; /* include padding in the element's width */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    z-index: 2;
    font-size: 1.3rem;
}

/* overlay to cover the screen when the menu is active */
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

@media screen and (max-width: 1370px){
    .search {
        width: 90%;
    }

    nav ul li a {
        padding: 0px 0px;
    }
}

@media screen and (max-width: 1000px){
    .search {
        width: 80%;
    }

    .wrap {
        top: 50%;
        left: 50%;
        transform: translate(-70%, -50%);
    }

}

@media screen and (max-width: 768px) {
    .username {
        max-width: 100px;
    }
}

@media screen and (max-width: 910px) {
    .hamburger {
        display: block;
    }

    nav ul {
        display: none;
    }

    .mobile-search-button {
        position: absolute;
        right: 55px;
        width: auto;
    }
}

@media screen and (max-width: 600px){
    .menubar.active {
        width: 60%;
    }
}

@media screen and (max-width: 430px){
    .menubar.active {
        width: 85%;
    }
}

@media screen and (max-width: 370px) {
    .logo-container p {
        display: none;
    }
}

</style>
