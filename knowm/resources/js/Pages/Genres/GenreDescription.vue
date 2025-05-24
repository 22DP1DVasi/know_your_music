<template>
    <Head :title="`${genre.name} Description`" />
    <Navbar />
    <main class="genre-page flex-1">
        <div class="genre-hero" :style="heroStyle">
            <div class="hero-gradient" v-if="!isLandscape"></div>
            <div class="hero-image-container">
                <img
                    :src="genre.profile_url"
                    :alt="genre.name"
                    class="hero-image"
                    ref="heroImage"
                    @load="handleImageLoad"
                    @error="handleImageError"
                    :style="imageStyle"
                    loading="eager"
                >
            </div>
            <h1 class="genre-name">{{ capitalizeFirstLetter(genre.name) }}</h1>
            <div class="back-button" @click="goBackToGenre">
                ← Back to genre
            </div>
        </div>

        <div class="genre-content">
            <div class="main-content">
                <h2 class="section-title">Description</h2>
                <div class="description-wrapper">
                    <div class="info-card wrapped">
                        <h3 class="info-title">Details</h3>
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="info-value"><b>Origin Year:</b> {{ genre.origin_year || 'Unknown' }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-value"><b>Origin Country:</b> {{ genre.origin_country || 'Unknown' }}</span>
                            </div>
                        </div>
                    </div>
                    <div v-if="genre.description" class="description-text" v-html="genre.description"></div>
                    <div v-else class="description-text">There is no description available for this genre.</div>
                </div>
            </div>

            <div class="sidebar-space">
                <!-- Future content like "Similar Genres" will go here -->
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
    genre: Object,
});

// hero image
const heroImage = ref(null);
const heroStyle = ref({
    height: '300px',
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

const handleImageLoad = () => {
    const img = heroImage.value;
    if (!img) return;

    imageStyle.value.opacity = 1;
    analyzeImage();
};

const handleImageError = () => {
    Object.assign(heroStyle.value, {
        'background': 'linear-gradient(135deg, #0c4baa 0%, #093a88 100%)',
        'height': '300px',
        'position': 'relative',
        'overflow': 'hidden',
        'display': 'flex',
        'justify-content': 'center',
        'align-items': 'center'
    });
    imageStyle.value.opacity = 0;
};

const analyzeImage = () => {
    const img = heroImage.value;
    if (!img) return;
    heroStyle.value = {
        'height': '180px',
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
            'height': '180px',
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
                'height': '180px',
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
                'height': '180px',
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

const goBackToGenre = () => {
    router.visit(`/genres/${props.genre.slug}`);
};

function capitalizeFirstLetter(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

</script>

<style scoped>
.genre-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto 0;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.genre-hero {
    height: 300px;
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

.genre-name {
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

.genre-content {
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

.description-wrapper {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    margin-bottom: 2rem;
    position: relative;
}

.info-card.wrapped {
    float: right;
    width: fit-content;
    max-width: 50%;
    margin: 0 0 1rem 1.5rem;
    background: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 1rem;
    box-shadow: none;
}

.description-text {
    flex: 3;
    font-size: 0.9rem;
    line-height: 1.6;
    white-space: pre-line;
    word-break: break-word;
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    margin-bottom: 1.5rem;
}

.sidebar-space {
    width: 300px;
    flex-shrink: 0;
}

.info-card {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.info-title {
    font-size: 1.1rem;
    margin-bottom: 1rem;
    color: #333;
}

.info-flex {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    flex-direction: column;
}

.info-item {
    flex: 1 0 calc(50% - 0.75rem);
    min-width: 120px;
    display: flex;
    flex-direction: row;
}

.info-value {
    font-weight: 500;
}

@media (max-width: 1455px) {
    .genre-page {
        width: 90%;
    }
}

@media (max-width: 1024px) {
    .genre-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .genre-content {
        flex-direction: column;
        gap: 10px;
    }

    .genre-hero {
        margin-bottom: 0.5rem;
    }

    .sidebar-space {
        width: 100%;
        order: -1;
        margin-bottom: 1rem;
    }

    .info-card.wrapped {
        font-size: 0.8rem;
    }
}

@media (max-width: 768px) {
    .genre-hero {
        height: 220px;
    }

    .genre-name {
        font-size: 2rem;
        padding: 1rem;
    }

    .main-content {
        max-width: 100%;
        width: 100%;
    }

    .description-wrapper {
        flex-direction: column;
    }

    .info-card.wrapped {
        float: none;
        width: 100%;
        max-width: 100%;
        margin: 0 0 1rem 0;
        line-height: 1.3;
    }

    .info-flex {
        gap: 0.5rem;
    }

    .sidebar-space {
        display: none;
    }
}

@media (max-width: 480px) {
    .genre-name {
        font-size: 1.8rem;
    }

    .back-button {
        font-size: 0.9rem;
        padding: 0.4rem 0.8rem;
    }
}

</style>
