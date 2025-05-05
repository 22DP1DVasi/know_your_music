<template>
    <Head :title="release.title" />
    <link rel="preload" :href="release.cover_url" as="image">
    <Navbar />
    <main class="release-page flex-1">
        <div class="release-hero" :style="heroStyle">
            <div class="hero-gradient" v-if="!isLandscape"></div>
            <div class="hero-image-container">
                <img
                    :src="release.cover_url"
                    :alt="release.title"
                    class="hero-image"
                    ref="heroImage"
                    @load="handleImageLoad"
                    :style="imageStyle"
                    loading="eager"
                >
            </div>
            <h1 class="release-title">{{ release.title }}</h1>
            <div class="release-artists">
                <span v-for="(artist, index) in release.artists" :key="artist.id">
                    <a :href="`/artists/${artist.slug}`">{{ artist.name }}</a>
                    <span v-if="index < release.artists.length - 1">, </span>
                </span>
            </div>
        </div>

        <div class="release-content">
            <div class="main-content">
                <section class="release-info-section">
                    <div class="release-meta">
                        <div class="meta-item">
                            <span class="meta-label">Release Date:</span>
                            <span class="meta-value">{{ formatDate(release.release_date) }}</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Type:</span>
                            <span class="meta-value">{{ capitalize(release.release_type) }}</span>
                        </div>
                        <div class="meta-item" v-if="release.genres.length">
                            <span class="meta-label">Genres:</span>
                            <span class="meta-value">
                                <span v-for="(genre, index) in release.genres" :key="genre">
                                    {{ genre }}<span v-if="index < release.genres.length - 1">, </span>
                                </span>
                            </span>
                        </div>
                    </div>

                    <div class="release-description" v-if="release.description">
                        <h2 class="section-title">About This Release</h2>
                        <div class="description-text" v-html="release.description"></div>
                    </div>
                </section>

                <section class="release-tracks">
                    <div class="tracks-header">
                        <h2 class="section-title">Tracklist</h2>
                        <span class="tracks-count">{{ release.tracks.length }} {{ release.tracks.length === 1 ? 'track' : 'tracks' }}</span>
                    </div>
                    <div class="track-list">
                        <div v-for="track in sortedTracks" :key="track.id" class="track-card">
                            <span class="track-number">{{ track.pivot.track_position }}</span>
                            <div class="track-info">
                                <h3 class="track-title">{{ track.title }}</h3>
                                <p class="track-artists" v-if="track.artists.length > 1">
                                    <span v-for="(artist, index) in track.artists" :key="artist.id">
                                        <a :href="`/artists/${artist.slug}`">{{ artist.name }}</a>
                                        <span v-if="index < track.artists.length - 1">, </span>
                                    </span>
                                </p>
                            </div>
                            <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                        </div>
                    </div>
                </section>

                <section class="release-comments">
                    <h2 class="section-title">Comments</h2>
                    <div class="comments-section">
                        <!-- Comment components would go here -->
                    </div>
                </section>
            </div>

            <div class="sidebar-space">
                <div class="similar-releases" v-if="similarReleases.length">
                    <h3 class="sidebar-title">Similar Releases</h3>
                    <div class="similar-list">
                        <div v-for="similar in similarReleases" :key="similar.id" class="similar-item">
                            <a :href="`/releases/${similar.slug}`">
                                <img :src="similar.cover_url" :alt="similar.title">
                                <span>{{ similar.title }}</span>
                            </a>
                        </div>
                    </div>
                </div>
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
    release: {
        type: Object,
        required: true,
        default: () => ({
            id: Number,
            title: String,
            cover_url: String,
            release_date: String,
            description: String,
            release_type: String,
            artists: Array,
            genres: Array,
            tracks: Array,
            similar_releases: Array
        })
    }
});

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

const sortedTracks = computed(() => {
    return [...props.release.tracks].sort((a, b) => a.pivot.track_position - b.pivot.track_position);
});

const similarReleases = computed(() => {
    return props.release.similar_releases || [];
});

const handleImageLoad = () => {
    const img = heroImage.value;
    if (!img) return;

    imageStyle.value.opacity = 1;
    analyzeImage();
};

const analyzeImage = () => {
    const img = heroImage.value;
    if (!img) return;

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
                'height': '400px',
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

const capitalize = (value) => {
    if (!value) return '';
    return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
};

const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};
</script>

<style scoped>
.release-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto 0;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.release-hero {
    height: 400px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 1rem;
    margin-top: 1rem;
    border-radius: 8px;
    background-color: #f0f0f0;
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

.release-title {
    position: absolute;
    bottom: 60px;
    left: 0;
    padding: 0 1.5rem;
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    z-index: 3;
}

.release-artists {
    position: absolute;
    bottom: 30px;
    left: 0;
    padding: 0 1.5rem;
    color: white;
    font-size: 1.2rem;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    z-index: 3;
}

.release-artists a {
    color: white;
    text-decoration: none;
}

.release-artists a:hover {
    text-decoration: underline;
}

.release-content {
    display: flex;
    gap: 40px;
    margin-top: 0.5rem;
}

.main-content {
    flex: 1;
    max-width: 70%;
}

.sidebar-space {
    width: 300px;
    flex-shrink: 0;
}

.section-title {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: #0c4baa;
}

.release-info-section {
    display: flex;
    gap: 2rem;
    margin-bottom: 2rem;
}

.release-meta {
    flex: 0 0 250px;
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    height: fit-content;
}

.meta-item {
    margin-bottom: 1rem;
}

.meta-label {
    font-weight: 600;
    display: block;
    margin-bottom: 0.25rem;
    color: #333;
}

.meta-value {
    display: block;
    color: #666;
}

.release-description {
    flex: 1;
}

.description-text {
    font-size: 0.95rem;
    line-height: 1.6;
}

.tracks-header {
    display: flex;
    align-items: center;
    margin-bottom: 1rem;
    gap: 1rem;
}

.tracks-count {
    color: #666;
    font-size: 1rem;
}

.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.track-card {
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
    font-size: 0.9rem;
    flex-shrink: 0;
}

.track-info {
    flex: 1;
    min-width: 0;
}

.track-title {
    font-size: 0.95rem;
    margin: 0;
}

.track-artists {
    margin: 0.25rem 0 0;
    font-size: 0.85rem;
    color: #666;
}

.track-artists a {
    color: #0c4baa;
    text-decoration: none;
}

.track-artists a:hover {
    text-decoration: underline;
}

.track-duration {
    color: #666;
    font-size: 0.9rem;
    flex: 0 0 60px;
    text-align: right;
}

.similar-releases {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
}

.sidebar-title {
    font-size: 1.1rem;
    margin-bottom: 1rem;
    color: #333;
}

.similar-list {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.similar-item a {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    color: #333;
    text-decoration: none;
}

.similar-item img {
    width: 40px;
    height: 40px;
    border-radius: 4px;
    object-fit: cover;
}

.similar-item span {
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.similar-item:hover span {
    color: #0c4baa;
}

.comments-section {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 3rem;
}

@media (max-width: 1455px) {
    .release-page {
        width: 90%;
    }
}

@media (max-width: 1024px) {
    .release-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .release-content {
        flex-direction: column;
        gap: 10px;
    }

    .release-info-section {
        flex-direction: column;
    }

    .release-meta {
        flex: 1;
        max-width: 100%;
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
    .release-hero {
        height: 300px;
    }

    .release-title {
        font-size: 2rem;
        bottom: 50px;
    }

    .release-artists {
        font-size: 1rem;
        bottom: 25px;
    }

    .sidebar-space {
        display: none;
    }

    .track-card {
        padding: 0.75rem;
        gap: 0.75rem;
    }

    .track-info {
        padding: 0 0.25rem;
    }

    .track-duration {
        flex: 0 0 50px;
    }
}

@media (max-width: 480px) {
    .release-title {
        font-size: 1.5rem;
        bottom: 40px;
        padding: 0 1rem;
    }

    .release-artists {
        font-size: 0.9rem;
        bottom: 20px;
        padding: 0 1rem;
    }

    .track-card {
        padding: 0.5rem;
        gap: 0.5rem;
    }

    .track-number {
        width: 20px;
    }

    .track-title {
        font-size: 0.9rem;
    }

    .track-duration {
        font-size: 0.85rem;
        flex: 0 0 45px;
    }
}
</style>
