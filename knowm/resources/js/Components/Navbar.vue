<template>
    <nav>
        <p style="font-family: Arial, Helvetica, sans-serif;">Know Your Music</p>
        <ul>
            <li>
                <div class="wrap">
                    <div class="search">
                        <input type="text" class="searchTerm" placeholder="Search...">
                        <button type="submit" class="searchButton">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </li>
            <li><a href="/">Home</a></li>
            <li><a href="/explore">Explore</a></li>
            <li><a href="/about">About</a></li>
            <li><a href="/login">Log In</a></li>
            <li><a href="/signup">Sign Up</a></li>
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
            <li><a href="/login">Log In</a></li>
            <li><a href="/signup">Sign Up</a></li>
        </ul>
    </div>
    <!-- search bar for mobile -->
    <div v-show="isMobileSearchActive" class="mobile-search-container">
        <div class="search">
            <input type="text" class="searchTerm" placeholder="Search..." />
            <button type="submit" class="searchButton">
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
    position: relative; /* ensure the navbar acts as the containing block for absolute positioning */
}

nav ul {
    list-style: none;
    display: flex;
}

nav ul li {
    margin-left: 2rem;
}

nav ul li a {
    text-decoration: none;
    background-color: rgb(185, 225, 255);
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    font-weight: 400;
    padding: 4px 8px;
    border-radius: 5px;
}

nav ul li a:hover {
    background-color: #91e3f8ed;
}

.wrap {
    width: 25%;
    position: absolute; /* position relative to the Navbar */
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
    padding: 10px; /* Increase padding */
    height: 40px; /* Increase height */
    border-radius: 7px 0 0 7px;
    outline: none;
    color: #000000;
    font-size: 16px; /* Ensure text is readable */
}

.searchTerm:focus {
    outline: none !important;
    box-shadow: none !important;
}

.searchButton {
    position: relative; /* Ensure a positioned ancestor for the ::after pseudo-element */
    width: 40px;
    height: 40px;
    border: 1px solid #54b3ebed;
    background: #54b3ebed;
    text-align: center;
    color: #fff;
    border-radius: 0 7px 7px 0;
    cursor: pointer;
    font-size: 20px;
    overflow: hidden; /* Prevent visual overflow */
}

/* Transition the icon */
.searchButton i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

/* change to music icon on hover */
.searchButton:hover i {
    opacity: 0; /* fade out the search icon */
    transform: scale(0.5); /* shrink the search icon */
}

/* add the music icon after hover */
.searchButton:hover::after {
    content: "\f001"; /* Unicode for FontAwesome fa-music */
    font-family: "FontAwesome";
    font-size: 20px;
    color: #fff;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(1); /* Center the icon and scale it up */
    opacity: 1;
    transition: opacity 0.3s ease, transform 0.3s ease; /* Smooth appearance */
}

/* Initially, the music icon is hidden */
.searchButton::after {
    content: "";
    opacity: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.5); /* Start small */
}

/* Mobile search container */
.mobile-search-container {
    background-color: rgb(185, 225, 255);
    padding: 10px;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 8px;
}

/* Mobile search button */
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
    margin-bottom: 32px;
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

/* vverlay to cover the screen when the menu is active */
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

.icon {
    font-size: 1.2rem;
}

/* Media Query for Mobile */
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

    /* nav ul li a {
      padding: 0px 0px;
    } */

    .wrap {
        top: 50%;
        left: 50%;
        transform: translate(-70%, -50%); /* adjust for true center */
    }

}

@media screen and (max-width: 910px) {
    .hamburger {
        display: block;
    }

    nav ul {
        display: none; /* Completely remove the nav elements from the layout */
    }

    .mobile-search-button {
        position: absolute;
        right: 55px; /* move it closer to the hamburger menu */
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

</style>

<script>
import { ref, onMounted } from "vue";

export default {
    setup() {
        // Dark mode state
        const isDarkMode = ref(localStorage.getItem("darkMode") === "true");

        // Menu state
        const isMenuActive = ref(false);

        // Mobile state
        const isMobile = ref(false);
        const isMobileSearchActive = ref(false);

        // Toggle dark mode function
        const toggleDarkMode = () => {
            isDarkMode.value = !isDarkMode.value;
            document.documentElement.classList.toggle("dark-mode", isDarkMode.value);
            localStorage.setItem("darkMode", isDarkMode.value);
        };

        // Toggle navigation menu function
        const toggleNav = () => {
            isMenuActive.value = !isMenuActive.value;
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

        // Add resize event listener on mount
        onMounted(() => {
            window.addEventListener("resize", handleResize);
            handleResize(); // Check screen size on initial load
        });

        return {
            isDarkMode,
            toggleDarkMode,
            isMenuActive,
            toggleNav,
            isMobile,
            isMobileSearchActive,
            toggleMobileSearch,
        };
    },
};
</script>
