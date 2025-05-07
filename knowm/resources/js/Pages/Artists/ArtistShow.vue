<template>
    <Head :title="artist.artist.name" />
    <link rel="preload" :href="artist.artist.profile_url" as="image">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <Navbar />
    <main class="artist-page flex-1">
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
                    loading="eager"
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
                        @click="redirectToFullBio(props.artist.artist.slug)"
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
                                <span class="info-value">
                                  <b>{{ capitalize(artist.artist.solo_or_band) || 'Unknown' }}</b>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-value"><b>Years Active:</b> {{ artist.artist.formed_year || 'Unknown' }} - {{ artist.artist.disbanded_year || (artist.artist.is_active ? 'present' : 'unknown') }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="info-card genres-card">
                        <div class="genres-header">
                            <h3 class="info-title">Genres</h3>
<!--                            <button-->
<!--                                v-if="artist.genres.length > 5"-->
<!--                                class="see-all-genres"-->
<!--                                @click="redirectToAllGenres"-->
<!--                            >-->
<!--                                See all genres-->
<!--                            </button>-->
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
                    <div class="tracks-header">
                        <h2 class="section-title">Tracks</h2>
                        <button
                            v-if="artist.total_tracks > artist.tracks.length"
                            class="see-all-tracks"
                            @click="redirectToAllTracks(props.artist.artist.slug)"
                        >
                            See all {{ artist.total_tracks }} tracks
                        </button>
                    </div>
                    <div class="track-list">
                        <div v-for="(track, index) in artist.tracks" :key="track.id" class="track-card">
                            <span class="track-number">{{ index + 1 }}</span>
                            <img :src="track.cover_url" class="track-image" :alt="track.title">
                            <div class="track-info">
                                <h3>
                                    <a @click="redirectToTrack(track.slug)" class="track-title">
                                        {{ track.title }}
                                    </a>
                                </h3>
                            </div>
                            <button
                                v-if="track.audio_source"
                                @click="playTrack(track.audio_source)"
                                class="play-button"
                            >
                                <i class="fa-regular fa-circle-play"></i>
                            </button>
                            <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                        </div>
                    </div>
                </section>

                <section class="artist-releases">
                    <div class="releases-header">
                        <h2 class="section-title">Releases</h2>
                        <button
                            v-if="artist.total_releases > artist.releases.length"
                            class="see-all-releases"
                            @click="redirectToAllReleases(props.artist.artist.slug)"
                        >
                            See all {{ artist.total_releases }} releases
                        </button>
                    </div>
                    <div class="release-results">
                        <div
                            v-for="release in props.artist.releases"
                            :key="release.id"
                            class="release-card"
                            @click="redirectToRelease(release.slug)"
                        >
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

            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
        <div v-if="showPlayer" class="audio-player">
            <button @click="closePlayer" class="close-player">
                <i class="fa-solid fa-times"></i>
            </button>
            <iframe
                :src="currentAudioSource"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen
            ></iframe>
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
    artist: {
        type: Object,
        required: true,
        default: () => ({
            artist: Object,
            tracks: Array,
            total_tracks: Number,
            genres: Array,
            releases: Array,
            total_releases: Number,
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
const bioMaxLength = 500;
const showPlayer = ref(false);
const currentAudioSource = ref('');

// image handling
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

const truncatedBio = computed(() => {
    if (!props.artist.artist.biography) return 'There is no background for this artist.';
    if (props.artist.artist.biography.length <= bioMaxLength) return props.artist.artist.biography;
    return props.artist.artist.biography.substring(0, bioMaxLength) + '...';
});

const showReadMore = computed(() => {
    return props.artist.artist.biography && props.artist.artist.biography.length > bioMaxLength;
});

const playTrack = (source) => {
    currentAudioSource.value = source;
    showPlayer.value = true;
    setTimeout(() => {
        document.querySelector('.audio-player')?.scrollIntoView({ behavior: 'smooth' });
    }, 100);
};

const closePlayer = () => {
    showPlayer.value = false;
    currentAudioSource.value = '';
};

const redirectToFullBio = (slug) => {
    //const url = `/artists/${props.artist.artist.slug}/bio`;
    window.location.href = `/artists/${slug}/bio`;
};

const redirectToAllGenres = () => {
    window.location.href = '#';
};

const redirectToAllTracks = (slug) => {
    window.location.href = `/artists/${slug}/tracks`;
};

const redirectToTrack = (slug) => {
    window.location.href = `/tracks/${slug}`;
};

const redirectToRelease = (slug) => {
    window.location.href = `/releases/${slug}`;
};

const redirectToAllReleases = (slug) => {
    window.location.href = `/artists/${slug}/releases`;
};
const capitalize = (value) => {
    if (!value) return 'Unknown';
    return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

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
    max-width: 300px;
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

.tracks-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.see-all-tracks {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1rem;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    margin-bottom: 1rem;
    border-radius: 4px;
    transition: background 0.2s;
    white-space: nowrap;
    flex-shrink: 0;
}

.see-all-tracks:hover {
    background: rgba(12, 75, 170, 0.1);
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
    gap: 0.75rem;
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
}

.track-info h3 {
    text-decoration: none;
    transition: color 0.2s;
    font-size: 0.95rem;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-title {
    cursor: pointer;
}

.track-title:hover {
    color: #0c4baa;
    text-decoration: underline;
}

.play-button {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1.2rem;
    cursor: pointer;
    padding: 0 0.5rem;
    transition: transform 0.2s, color 0.2s;
    flex-shrink: 0;
}

.play-button:hover {
    color: #1a5fc9;
    transform: scale(1.1);
}

.track-duration {
    color: #666;
    font-size: 0.9rem;
    flex: 0 0 50px;
    text-align: right;
}

.artist-releases {
    margin-bottom: 3rem;
}

.releases-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.see-all-releases {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1rem;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    margin-bottom: 1rem;
    border-radius: 4px;
    transition: background 0.2s;
    white-space: nowrap;
    flex-shrink: 0;
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
    cursor: pointer;
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
    font-size: 1rem;
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

.audio-player {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 360px;
    height: 200px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 1000;
    overflow: hidden;
    transition: all 0.3s ease;
}

.audio-player iframe {
    width: 100%;
    height: 100%;
}

.close-player {
    position: absolute;
    top: 8px;
    right: 8px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    border: none;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    z-index: 1001;
}

.close-player:hover {
    background: rgba(0, 0, 0, 0.9);
}

@media (max-width: 1455px) {
    .artist-page {
        width: 90%;
    }
}

@media (max-width: 1230px) {
    .release-info h3 {
        font-size: 0.8rem;
    }
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

    .release-results {
        display: block;
        overflow-x: auto;
        white-space: nowrap;
        padding: 10px;
        margin: 0 -10px;
        scrollbar-width: thin;
        scrollbar-color: #0c4baa #f0f0f0;
    }

    .release-results::-webkit-scrollbar {
        height: 6px;
    }

    .release-results::-webkit-scrollbar-track {
        background: #f0f0f0;
    }

    .release-results::-webkit-scrollbar-thumb {
        background-color: #0c4baa;
        border-radius: 6px;
    }

    .release-card {
        display: inline-block;
        vertical-align: top;
        width: 250px;
        margin-right: 15px;
        flex: none;
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
