<template>
    <Head :title="title" />
    <Navbar />
    <main class="artist-bio-page">
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

        <div class="bio-content">
            <section class="full-bio">
                <h2>Biography</h2>
                <div class="bio-text" v-html="artist.biography"></div>
            </section>

            <div class="bio-sidebar">
                <div class="info-card">
                    <h3>Active Years</h3>
                    <div class="info-item">
                        <span class="info-label">Formed:</span>
                        <span class="info-value">{{ artist.formed_year || 'Unknown' }}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Disbanded:</span>
                        <span class="info-value">{{ artist.disbanded_year || 'Still active' }}</span>
                    </div>
                </div>

                <div class="info-card">
                    <h3>Genres</h3>
                    <div class="genre-tags">
                        <span v-for="genre in artist.genres" :key="genre" class="genre-tag">
                            {{ genre }}
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';
import { ref } from 'vue';
import ColorThief from 'colorthief';

const props = defineProps({
    artist: Object,
    title: String
});

// Hero image functionality
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
</script>

<style scoped>
.artist-bio-page {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 20px;
}

.artist-hero {
    width: 100%;
    margin-bottom: 2rem;
    margin-top: 1rem;
    border-radius: 8px;
    overflow: hidden;
    --gradient-color-left: rgba(0,0,0,0.3);
    --gradient-color-right: rgba(0,0,0,0.3);
    position: relative;
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

.bio-content {
    display: flex;
    gap: 40px;
}

.full-bio {
    flex: 1;
}

.full-bio h2 {
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
    color: #0c4baa;
}

.bio-text {
    font-size: 1rem;
    line-height: 1.6;
    white-space: pre-line;
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 1.5rem;
}

.bio-sidebar {
    width: 300px;
    flex-shrink: 0;
}

.info-card {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 1.5rem;
}

.info-item {
    margin-bottom: 0.75rem;
    display: flex;
}

.info-label {
    font-weight: 500;
    margin-right: 0.5rem;
    min-width: 80px;
}

.genre-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.genre-tag {
    background: #f0f4ff;
    color: #0c4baa;
    padding: 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.85rem;
}

@media (max-width: 768px) {
    .bio-content {
        flex-direction: column;
    }

    .bio-sidebar {
        width: 100%;
    }

    .artist-name {
        font-size: 2rem;
        padding: 1rem;
    }

    .artist-hero {
        height: 300px;
    }
}

@media (max-width: 480px) {
    .artist-name {
        font-size: 1.8rem;
    }

    .back-button {
        font-size: 0.9rem;
        padding: 0.4rem 0.8rem;
    }
}
</style>
