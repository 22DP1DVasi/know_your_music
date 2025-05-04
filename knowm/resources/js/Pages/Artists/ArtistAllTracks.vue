<template>
    <Head :title="`${artist.name} - All Tracks`" />
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
                >
            </div>
            <h1 class="artist-name">{{ artist.name }}</h1>
            <div class="back-button" @click="goBackToArtist">
                ← Back to artist
            </div>
        </div>

        <div class="artist-content">
            <div class="main-content">
                <h2 class="section-title">{{ totalTracks }} tracks</h2>
                <div class="track-list-container">
                    <div class="track-list">
                        <div v-for="(track, index) in tracks" :key="track.id" class="track-row">
                            <div class="track-cell index">{{ (currentPage - 1) * perPage + index + 1 }}</div>
                            <div class="track-cell title">
                                <img :src="track.cover_url" class="track-image" :alt="track.title">
                                <div class="track-info">
                                    <h3>{{ track.title }}</h3>
                                    <p v-if="track.artist_names" class="artist-names">{{ track.artist_names }}</p>
                                </div>
                            </div>
                            <div class="track-cell duration">{{ formatDuration(track.duration) }}</div>
                        </div>
                    </div>
                </div>
            </div>

            <Pagination
                :links="paginationLinks"
                :current-page="currentPage"
                :total-pages="totalPages"
                class="pagination"
            />

            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import Pagination from '@/Components/Pagination.vue'
import { ref } from 'vue';
import ColorThief from 'colorthief';

const props = defineProps({
    artist: {
        type: Object,
        required: true
    },
    tracks: {
        type: Array,
        required: true
    },
    totalTracks: {
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
    }
})

// hero image
const heroImage = ref(null);
const heroStyle = ref({});
const imageStyle = ref({});
const isLandscape = ref(false);
const colorThief = new ColorThief();

const handleImageLoad = () => {
    if (heroImage.value.complete) {
        analyzeImage();
    } else {
        heroImage.value.addEventListener('load', analyzeImage);
    }
};

const analyzeImage = () => {
    const img = heroImage.value;
    isLandscape.value = img.naturalWidth > img.naturalHeight;

    if (isLandscape.value) {
        heroStyle.value = {
            'height': '400px',
            'position': 'relative',
            'overflow': 'hidden'
        };
        imageStyle.value = {
            'width': '100%',
            'height': '100%',
            'object-fit': 'cover',
            'object-position': 'center 13%',
        };
    } else {
        try {
            const dominantColor = colorThief.getColor(img);
            const bgColor = `rgb(${dominantColor.join(',')})`;
            const darkerColor = dominantColor.map(c => Math.max(0, c - 30)).join(',');

            heroStyle.value = {
                '--gradient-color-left': `rgba(${darkerColor},0.8)`,
                '--gradient-color-right': `rgba(${darkerColor},0.8)`,
                'background-color': bgColor,
                'height': '400px',
                'position': 'relative',
                'display': 'flex',
                'justify-content': 'center',
                'align-items': 'center'
            };

            imageStyle.value = {
                'max-height': '100%',
                'max-width': '100%',
                'object-fit': 'contain',
                'position': 'relative',
                'z-index': '2'
            };
        } catch (e) {
            console.error('Error extracting color:', e);
            heroStyle.value = {
                '--gradient-color-left': 'rgba(0,0,0,0.3)',
                '--gradient-color-right': 'rgba(0,0,0,0.3)',
                'background-color': '#f0f0f0',
                'height': '300px',
                'position': 'relative'
            };
            imageStyle.value = {
                'max-height': '100%',
                'max-width': '100%',
                'object-fit': 'contain'
            };
        }
    }
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

const formatDuration = (timeString) => {
    if (!timeString) return '--:--'
    const [hours, minutes, seconds] = timeString.split(':')
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0')
}
</script>

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
    width: 100%;
    margin-bottom: 1rem;
    margin-top: 1rem;
    border-radius: 8px;
    overflow: hidden;
    --gradient-color-left: rgba(0,0,0,0.3);
    --gradient-color-right: rgba(0,0,0,0.3);
    position: relative;
}

.hero-image-container {
    width: 100%;
    height: 100%;
    position: relative;
    overflow: hidden;
}

.hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    filter: brightness(0.9);
    transition: all 0.3s ease;
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

.artist-name {
    position: absolute;
    bottom: 0;
    left: 0;
    padding: 1.5rem;
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    z-index: 3;
}

.back-button {
    position: absolute;
    top: 1rem;
    left: 1rem;
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

.track-count {
    color: #666;
    margin: 5px 0 0;
    font-size: 0.9rem;
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

.sidebar-space {
    width: 300px;
    flex-shrink: 0;
}

.track-list-container {
    margin-bottom: 40px;
}

.track-list {
    border-radius: 5px;
    overflow: hidden;
}

.track-row {
    display: flex;
    align-items: center;
    padding: 10px 15px;
    border-bottom: 1px solid #eee;
    transition: background 0.2s;
}

.track-row:hover {
    background: #f9f9f9;
}

.track-cell {
    padding: 0 10px;
    flex-shrink: 0;
}

.track-cell.index {
    width: 50px;
    text-align: center;
}

.track-cell.title {
    flex: 3;
    display: flex;
    align-items: center;
    gap: 15px;
    min-width: 0;
}

.track-image {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    object-fit: cover;
    flex-shrink: 0;
}

.track-info {
    min-width: 0;
}

.track-info h3 {
    margin: 0;
    font-size: 1rem;
    font-weight: 500;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.artist-names {
    margin: 3px 0 0;
    color: #666;
    font-size: 0.85rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-cell.duration {
    width: 80px;
    text-align: right;
    color: #666;
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
        width: 100%;
        order: -1;
        margin-bottom: 1rem;
    }
}

@media (max-width: 768px) {
    .artist-hero {
        height: 220px;
    }

    .artist-name {
        font-size: 2rem;
        padding: 1rem;
    }

    .sidebar-space {
        display: none;
    }
}

@media (max-width: 480px) {
    .track-image {
        width: 40px;
        height: 40px;
    }

    .release-info h3 {
        font-size: 0.95rem;
    }
}
</style>
