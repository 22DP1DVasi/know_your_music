<template>
    <Head :title="artist.name" />
    <Navbar />
    <main class="artist-page">
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
        </div>

        <div class="artist-content">
            <div class="main-content">
                <section class="artist-description">
                    <h2 class="section-title">About</h2>
                    <div class="bio-text" v-html="truncatedBio"></div>
                    <button
                        v-if="showReadMore"
                        @click="redirectToFullBio"
                        class="read-more-button"
                    >
                        Read more
                    </button>
                </section>

                <div class="artist-side-info">
                    <div class="info-card">
                        <h3 class="info-title">Details</h3>
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="info-value">{{ artist.formed_year || 'Unknown' }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-value">{{ artist.disbanded_year || 'present' }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-value">{{ artist.solo_or_band || 'Unknown' }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="info-card genres-card">
                        <h3 class="info-title">Genres</h3>
                        <div class="genre-tags">
                          <span v-for="genre in artist.genres" :key="genre" class="genre-tag">
                            {{ genre }}
                          </span>
                        </div>
                    </div>
                </div>

                <section class="artist-tracks">
                    <h2 class="section-title">Tracks</h2>
                    <div class="track-list">
                        <div v-for="(track, index) in artist.top_tracks" :key="track.id" class="track-item">
                            <span class="track-number">{{ index + 1 }}</span>
                            <img :src="track.cover_url" :alt="track.title" class="track-image">
                            <div class="track-info">
                                <h3 class="track-title">{{ track.title }}</h3>
                                <p class="track-album">{{ track.release_title }}</p>
                            </div>
                            <span class="track-duration">{{ formatDuration(track.duration) }}</span>
                        </div>
                    </div>
                </section>

                <section class="artist-releases">
                    <h2 class="section-title">Releases</h2>
                    <div class="release-flex">
                        <div v-for="release in artist.releases" :key="release.id" class="release-card">
                            <img :src="release.cover_url" :alt="release.title" class="release-cover">
                            <div class="release-info">
                                <h3 class="release-title">{{ release.title }}</h3>
                                <p class="release-year">{{ release.year }}</p>
                                <p class="release-type">{{ release.type }}</p>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="artist-comments">
                    <h2 class="section-title">Comments</h2>
                    <div class="comments-section">
                        <!-- Comment components would go here -->
                    </div>
                </section>
            </div>

            <!-- Right sidebar space reserved for future content -->
            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import { ref, computed } from 'vue'
import ColorThief from 'colorthief'

const props = defineProps({
    artist: Object
})

const heroImage = ref(null);
const heroStyle = ref({});
const imageStyle = ref({});
const isLandscape = ref(false);
const colorThief = new ColorThief();
const bioMaxLength = 500;

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

const truncatedBio = computed(() => {
    if (!props.artist.biography) return '';
    if (props.artist.biography.length <= bioMaxLength) return props.artist.biography;
    return props.artist.biography.substring(0, bioMaxLength) + '...';
});

const showReadMore = computed(() => {
    return props.artist.biography && props.artist.biography.length > bioMaxLength;
});

const redirectToFullBio = () => {
    const url = `/artists/${props.artist.slug}/bio`;
    router.visit(url);
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

</script>

<style scoped>
.artist-page {
    max-width: 80%;
    width: 80%;
    margin: 2rem auto;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-radius: 12px;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
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

/* For portrait images (existing styles) */
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

.artist-content {
    display: flex;
    gap: 40px;
}

.main-content {
    flex: 1;
    max-width: 60%;
}

.sidebar-space {
    width: 300px;
    flex-shrink: 0;
}

.section-title {
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
    color: #0c4baa;
}

.artist-description {
    margin-bottom: 2.5rem;
}

.read-more-button {
    background: #0c4baa;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    margin-top: 1rem;
    cursor: pointer;
    transition: background 0.2s;
}

.read-more-button:hover {
    background: #1a5fc9;
}

.bio-text {
    font-size: 0.9rem;
    line-height: 1.6;
    white-space: pre-line;
    word-wrap: break-word;
}

.artist-side-info {
    display: flex;
    gap: 1.5rem;
    margin-bottom: 2.5rem;
    flex-wrap: wrap;
}

.info-card {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    flex: 1;
    min-width: 250px;
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
}

.info-item {
    flex: 1 0 calc(50% - 0.75rem);
    min-width: 120px;
    display: flex;
    flex-direction: column;
}

.info-value {
    font-weight: 500;
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

.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 3rem;
}

.track-item {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
    gap: 1rem;
}

.track-number {
    color: #666;
    width: 24px;
    text-align: center;
}

.track-image {
    width: 40px;
    height: 40px;
    border-radius: 4px;
    object-fit: cover;
}

.track-info {
    flex: 1;
    min-width: 0;
}

.track-title {
    font-size: 0.95rem;
    margin-bottom: 0.25rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-album {
    font-size: 0.85rem;
    color: #666;
}

.track-duration {
    color: #666;
    font-size: 0.9rem;
}

.release-flex {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    margin-bottom: 3rem;
}

.release-card {
    flex: 1 0 calc(20% - 1.5rem);
    min-width: 180px;
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s;
}

.release-card:hover {
    transform: translateY(-5px);
}

.release-cover {
    width: 100%;
    aspect-ratio: 1;
    object-fit: cover;
}

.release-info {
    padding: 0.75rem;
}

.release-title {
    font-size: 0.95rem;
    margin-bottom: 0.25rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.release-year, .release-type {
    font-size: 0.85rem;
    color: #666;
}

.comments-section {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 3rem;
}

@media (max-width: 1024px) {
    .artist-content {
        flex-direction: column;
    }

    .sidebar-space {
        width: 100%;
        order: -1;
        margin-bottom: 2rem;
    }
}

@media (max-width: 768px) {
    .artist-hero {
        height: 220px;
    }

    .hero-parallax {
        background-attachment: scroll;
        height: 100%;
    }

    .artist-name {
        font-size: 2rem;
        padding: 1rem;
    }

    .artist-side-info {
        flex-direction: column;
    }

    .info-card {
        min-width: 100%;
    }

    .release-card {
        flex: 1 0 calc(33.333% - 1.5rem);
    }
}

@media (max-width: 480px) {
    .release-card {
        flex: 1 0 calc(50% - 1.5rem);
    }

    .info-item {
        flex: 1 0 100%;
    }
}
</style>
