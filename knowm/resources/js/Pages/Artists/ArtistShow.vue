<template>
    <Head :title="artist.artist.name" />
    <Navbar />
    <main class="artist-page">
        <div class="artist-hero" :style="heroStyle">
            <div class="hero-gradient" v-if="!isLandscape"></div>
            <div class="hero-image-container">
                <img
                    :src="artist.artist.profile_url"
                    :alt="artist.artist.name"
                    class="hero-image"
                    ref="heroImage"
                    @load="handleImageLoad"
                    :style="imageStyle"
                >
            </div>
            <h1 class="artist-name">{{ artist.artist.name }}</h1>
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
                                <span class="info-value"><b>Years Active:</b> {{ artist.artist.formed_year || 'Unknown' }} - {{ artist.artist.disbanded_year || 'present' }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-value"><b>Type:</b> {{ artist.artist.solo_or_band || 'Unknown' }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="info-card genres-card">
                        <div class="genres-header">
                            <h3 class="info-title">Genres</h3>
                            <button
                                v-if="artist.genres.length > 5"
                                class="see-all-genres"
                                @click="redirectToAllGenres"
                            >
                                See all genres
                            </button>
                        </div>
                        <div class="genre-tags">
                            <span
                                v-for="(genre, index) in artist.genres.slice(0, 5)"
                                :key="genre"
                                class="genre-tag"
                                :title="genre.length > 16 ? genre : ''"
                            >
                                {{ genre }}
                            </span>
                        </div>
                    </div>
                </div>

                <section class="artist-tracks">
                    <h2 class="section-title">Tracks</h2>
                    <div class="track-list">
                        <div v-for="(track, index) in artist.tracks" :key="track.id" class="track-card">
                            <span class="track-number">{{ index + 1 }}</span>
                            <img :src="track.cover_url" class="track-image" :alt="track.title">
                            <div class="track-info">
                                <h3 class="track-title">{{ track.title }}</h3>
                            </div>
                            <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                        </div>
                    </div>
                </section>

                <section class="artist-releases">
                    <h2 class="section-title">Releases</h2>
                    <div class="release-results">
                        <div v-for="release in artist.releases" :key="release.id" class="release-card"> <!-- Path stays same -->
                            <div class="image-wrapper">
                                <img :src="release.cover_url" :alt="release.title">
                            </div>
                            <div class="release-info">
                                <h3>{{ release.title }}</h3>
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

const truncatedBio = computed(() => {
    if (!props.artist.artist.biography) return '';
    if (props.artist.artist.biography.length <= bioMaxLength) return props.artist.artist.biography;
    return props.artist.artist.biography.substring(0, bioMaxLength) + '...';
});

const showReadMore = computed(() => {
    return props.artist.artist.biography && props.artist.artist.biography.length > bioMaxLength;
});

const redirectToFullBio = () => {
    const url = `/artists/${props.artist.artist.slug}/bio`;
    router.visit(url);
};

const redirectToAllGenres = () => {
    window.location.href = '#';
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

</script>

<style scoped>
.artist-page {
    max-width: 85%;
    width: 85%;
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

.artist-description {
    margin-bottom: 1.7rem;
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
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    flex: 1;
    min-width: 200px;
    max-width: 285px;
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

.genres-card {
    min-width: 300px;
    max-width: 350px;
}

.genres-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.genres-header .info-title {
    margin: 0;
    font-size: 1.1rem;
    flex-shrink: 1;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.see-all-genres {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 0.8rem;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    transition: background 0.2s;
    white-space: nowrap;
    flex-shrink: 0;
}

.see-all-genres:hover {
    background: rgba(12, 75, 170, 0.1);
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
    max-width: 120px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    display: inline-block;
    vertical-align: middle;
}

.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
    max-width: 100%;
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
}

.track-image {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    object-fit: cover;
    flex-shrink: 0;
}

.track-info {
    flex: 1;
    min-width: 0;
    padding: 0 0.5rem;
    overflow: hidden;
}

.track-title {
    font-size: 0.95rem;
    margin-bottom: 0.25rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-duration {
    color: #666;
    font-size: 0.9rem;
    flex: 0 0 60px;
    text-align: right;
}

.artist-releases {
    margin-bottom: 3rem;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.125rem);
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
}

.release-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
}

.release-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 0.9rem;
    font-weight: bold;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}

.release-year, .release-type {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.comments-section {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 3rem;
}

@media (max-width: 1024px) {
    .artist-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .artist-content {
        flex-direction: column;
        gap: 10px;
    }

    .artist-hero {
        margin-bottom: 0.5rem;
    }

    .artist-description {
        margin-bottom: 1rem;
    }

    .release-card {
        flex: 0 0 calc(33.333% - 1.125rem);
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

    .main-content {
        max-width: 100%;
        width: 100%;
    }

    .sidebar-space {
        display: none;
    }

    .artist-side-info {
        flex-direction: column;
    }

    .info-card {
        width: 100%;
    }

    .track-card {
        padding: 0.75rem;
        gap: 0.75rem;
    }

    .track-image {
        width: 45px;
        height: 45px;
    }

    .track-info {
        padding: 0 0.25rem;
    }

    .track-duration {
        flex: 0 0 50px;
    }

    .release-card {
        flex: 0 0 calc(50% - 0.75rem);
    }
}

@media (max-width: 480px) {
    .info-item {
        flex: 1 0 100%;
    }

    .track-card {
        padding: 0.5rem;
        gap: 0.5rem;
    }

    .track-image {
        width: 40px;
        height: 40px;
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

    .release-results {
        justify-content: center;
    }

    .release-card {
        flex: 0 0 80%;
    }

    .release-info h3 {
        font-size: 0.95rem;
    }

    .release-year, .release-type {
        font-size: 0.85rem;
    }
}
</style>
