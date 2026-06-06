<script setup>
import { Head, router } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';
import ReleaseCard from '@/Components/Releases/ReleaseCard.vue';
import Pagination from '@/Components/Pagination.vue';
import { ref } from 'vue';
import ColorThief from 'colorthief';
import { debounce } from 'lodash-es';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    artist: {
        type: Object,
        required: true
    },
    releases: {
        type: Array,
        required: true
    },
    totalReleases: {
        type: Number,
        required: true
    },
    paginationLinks: {
        type: Array,
        required: true
    },
    currentPage: {
        type: Number,
        required: true
    },
    totalPages: {
        type: Number,
        required: true
    },
    perPage: {
        type: Number,
        default: 50
    },
    filters: {
        type: Object,
        default: () => ({})
    }
});

const { t } = useI18n();

// hero image
const heroImage = ref(null);
const heroStyle = ref({
    height: '400px',
    position: 'relative',
    overflow: 'hidden',
    backgroundColor: '#f0f0f0'
});
const imageStyle = ref({
    opacity: 0,
    transition: 'opacity 0.3s ease',
    width: '100%',
    height: '100%',
    objectFit: 'cover'
});
const isLandscape = ref(false);
const colorThief = new ColorThief();

const localSearchQuery = ref(props.filters.search || '');

const handleImageLoad = () => {
    const img = heroImage.value;
    if (!img) return;

    imageStyle.value.opacity = 1;
    analyzeImage();
};

const analyzeImage = () => {
    const img = heroImage.value;
    if (!img) return;
    heroStyle.value = {
        'height': '400px',
        'position': 'relative',
        'overflow': 'hidden',
        'background-color': '#f0f0f0' // fallback
    };
    imageStyle.value = {
        'opacity': '0',
        'transition': 'opacity 0.3s ease'
    };
    isLandscape.value = img.naturalWidth > img.naturalHeight;
    if (isLandscape.value) {
        Object.assign(heroStyle.value, {
            'height': '400px',
            'position': 'relative',
            'overflow': 'hidden'
        });
        Object.assign(imageStyle.value, {
            'width': '100%',
            'height': '100%',
            'object-fit': 'cover',
            'object-position': 'center 13%',
        });
    } else {
        try {
            const dominantColor = colorThief.getColor(img);
            const bgColor = `rgb(${dominantColor.join(',')})`;
            const darkerColor = dominantColor.map(c => Math.max(0, c - 30)).join(',');
            Object.assign(heroStyle.value, {
                '--gradient-color-left': `rgba(${darkerColor},0.8)`,
                '--gradient-color-right': `rgba(${darkerColor},0.8)`,
                'background-color': bgColor,
                'height': '400px',
                'position': 'relative',
                'display': 'flex',
                'justify-content': 'center',
                'align-items': 'center'
            });
            Object.assign(imageStyle.value, {
                'max-height': '100%',
                'max-width': '100%',
                'object-fit': 'contain',
                'position': 'relative',
                'z-index': '2'
            });
        } catch (e) {
            console.error('Error extracting color:', e);
            Object.assign(heroStyle.value, {
                '--gradient-color-left': 'rgba(0,0,0,0.3)',
                '--gradient-color-right': 'rgba(0,0,0,0.3)',
                'background-color': '#f0f0f0',
                'height': '400px',
                'position': 'relative'
            });
            Object.assign(imageStyle.value, {
                'max-height': '100%',
                'max-width': '100%',
                'object-fit': 'contain'
            });
        }
    }

    imageStyle.value.opacity = '1';
};

const getArtistImage = (artist, type = 'profile') => {
    if (artist.profile_url) {
        return artist.profile_url;
    }
    return '/images/default-artist-profile.webp';
};

const goBackToArtist = () => {
    router.visit(`/artists/${props.artist.slug}`);
};

const redirectToRelease = (slug) => {
    router.get(`/releases/${slug}`);
};

const performSearch = debounce(() => {
    router.get(`/artists/${props.artist.slug}/releases`, {
        search: localSearchQuery.value
    }, {
        preserveState: true,
        replace: true
    });
}, 300);

</script>

<template>
    <Head :title="`${artist.name} - All Releases`" />
    <Navbar />
    <main class="artist-page flex-1">
        <div class="artist-hero" :style="heroStyle">
            <div class="hero-gradient" v-if="!isLandscape"></div>
            <div class="hero-image-container">
                <img
                    :src="getArtistImage(artist)"
                    :alt="artist.name"
                    class="hero-image"
                    ref="heroImage"
                    @load="handleImageLoad"
                    :style="imageStyle"
                    loading="eager"
                >
            </div>
            <div class="artist-title-container">
                <h1 class="artist-name">{{ artist.name }}</h1>
            </div>
            <div class="back-button" @click="goBackToArtist">
                {{ t('artists.global.back_to_artist') }}
            </div>
        </div>

        <div class="artist-content">
            <div class="main-content">
                <div class="search-container">
                    <input
                        type="text"
                        class="searchTerm"
                        :placeholder="t('artists.global.search_releases')"
                        v-model="localSearchQuery"
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
                <h2 class="section-title">{{ totalReleases }} {{ totalReleases === 1 ? t('artists.global.release_title') : t('artists.global.releases_title') }}</h2>

                <section v-if="releases.length > 0" class="results-section">
                    <div class="release-results-wrapper">
                        <div class="release-results">
                            <ReleaseCard
                                v-for="release in releases"
                                :key="release.id"
                                :release="release"
                                :max-artists="3"
                                @release-click="(release) => redirectToRelease(release.slug)"
                            />
                        </div>
                    </div>
                    <Pagination
                        v-if="totalPages > 1"
                        :links="paginationLinks"
                        :current-page="currentPage"
                        :total-pages="totalPages"
                        class="pagination"
                    />
                </section>
            </div>

            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.artist-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto 0;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.artist-hero {
    height: 400px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 1rem;
    margin-top: 1rem;
    border-radius: 8px;
    background-color: #f0f0f0; /* fallback color */
    --gradient-color-left: rgba(0,0,0,0.3);
    --gradient-color-right: rgba(0,0,0,0.3);
}

.hero-image-container {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: inherit;
}

.hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}

.hero-gradient {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
        90deg,
        var(--gradient-color-left) 0%,
        transparent 20%,
        transparent 80%,
        var(--gradient-color-right) 100%
    );
    z-index: 1;
}

.artist-title-container {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 1.5rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    z-index: 3;
}

.artist-title-container::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        to top right,
        rgba(0, 0, 0, 0.7) 0%,
        rgba(0, 0, 0, 0.4) 30%,
        transparent 70%
    );
    pointer-events: none;
    z-index: -1;
    border-radius: 0 0 0 8px;
}

.artist-name {
    position: relative;
    color: white;
    font-size: clamp(1.4rem, 4vw, 2.5rem);
    font-weight: 700;
    line-height: 1.15;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    overflow-wrap: anywhere;
    margin: 0;
    text-shadow:
        0 2px 4px rgba(0, 0, 0, 0.7),
        0 4px 12px rgba(0, 0, 0, 0.4);
    z-index: 2;
}

.back-button {
    position: absolute;
    top: 1rem;
    right: 1rem;
    cursor: pointer;
    color: white;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 4;
    transition: background-color 0.2s;
}

.back-button:hover {
    background-color: rgba(0, 0, 0, 0.7);
}

.artist-content {
    display: flex;
    gap: 40px;
    margin-top: 0.5rem;
}

.main-content {
    flex: 1;
    max-width: 70%;
}

.section-title {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: #0c4baa;
}

.search-container {
    display: flex;
    width: 70%;
    max-width: 500px;
    margin: 20px auto;
    position: relative;
}

.searchTerm {
    height: 46px;
    width: 340px;
    flex: 1;
    padding: 12px;
    font-size: 17px;
    border: 3px solid #54b3ebed;
    border-right: none;
    border-radius: 7px 0 0 7px;
    outline: none;
}

.searchTerm:focus {
    outline: none !important;
    box-shadow: none !important;
}

.searchButton {
    width: 40px;
    height: 46px;
    border: 1px solid #54b3ebed;
    background: #54b3ebed;
    text-align: center;
    color: #fff;
    border-radius: 0 7px 7px 0;
    cursor: pointer;
    font-size: 20px;
    overflow: hidden;
    position: relative;
}

.searchButton i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

.searchButton:hover i {
    opacity: 0;
    transform: scale(0.5);
}

.searchButton:hover::after {
    content: "\f001";   /* FontAwesome music note */
    font-family: "FontAwesome";
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

.sidebar-space {
    width: 300px;
    flex-shrink: 0;
}

.results-section {
    margin: 0 auto;
    margin-bottom: 2.5rem;
    max-width: 1000px;
}

.release-results-wrapper {
    padding: 0 2rem;
    margin: 0 auto;
    max-width: 1200px;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.pagination {
    margin-top: 30px;
    justify-content: center;
}

@media (max-width: 1455px) {
    .artist-page {
        width: 90%;
    }
}

@media (max-width: 1325px) {
    .main-content {
        max-width: 80%;
        width: 80%;
    }

    .sidebar-space {
        width: 20%;
    }
}

@media (max-width: 1200px) {
    .search-container {
        max-width: 100%;
    }
}

@media (max-width: 1024px) {
    .artist-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .artist-hero {
        margin-bottom: 0.5rem;
    }

    .artist-content {
        flex-direction: column;
        gap: 10px;
    }

    .main-content {
        max-width: 100%;
        width: 100%;
    }

    .sidebar-space {
        display: none;
    }
}

@media (max-width: 768px) {
    .artist-hero {
        height: 220px;
    }

    .artist-title-container {
        padding: 1rem;
        flex-wrap: wrap;
    }

    .artist-name {
        font-size: 2rem;
    }

    .search-container {
        padding: 0 2rem;
        max-width: 100%;
    }

    .searchTerm {
        font-size: 16px;
        height: 46px;
    }

    .release-results-wrapper {
        padding: 0 1rem;
    }
}

@media (max-width: 540px) {
    .searchTerm {
        font-size: 14px;
        padding: 10px;
        height: 42px;
        max-width: 500px;
        width: 250px;
    }

    .searchButton {
        height: 42px;
    }
}

@media (max-width: 480px) {
    .artist-title-container {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.5rem;
    }

    .artist-name {
        font-size: 1.8rem;
    }

    .search-container {
        padding: 0 1rem;
        justify-content: center;
        align-items: center;
        margin-bottom: 0.5rem;
    }

    .searchTerm {
        font-size: 15px;
        padding: 10px;
        width: 100%;
        max-width: 280px;
    }

    .release-results {
        justify-content: center;
    }
}
</style>
