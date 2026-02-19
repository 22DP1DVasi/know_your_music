<script setup>
import { Head } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import AudioPlayer from '@/Components/MiniAudioPlayer.vue';
import Footer from '@/Components/Footer.vue';
import Comments from '@/Components/Comments/Comments.vue';
import { ref, computed } from 'vue';
import ColorThief from 'colorthief';

// plakana struktūra - skaidrāks skats uz atribūtiem
const props = defineProps({
    genre: {
        type: Object,
        required: true,
        default: () => ({
            id: null,
            name: '',
            slug: '',
            description: '',
            origin_year: '',
            origin_country: '',
            profile_url: '',

            artists: [],
            tracks: [],
            releases: [],
            comments: [],

            total_artists: 0,
            total_tracks: 0,
            total_releases: 0,

            comments_pagination: {
                current_page: 1,
                last_page: 1,
                total: 0,
                per_page: 10
            }
        })
    }
});

const showPlayer = ref(false);
const currentAudioSource = ref('');
const descriptionMaxLength = 500;
const heroImage = ref(null);
const heroStyle = ref({
    height: '180px',
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

const truncatedDescription = computed(() => {
    if (!props.genre.description) return 'There is no background for this genre.';
    if (props.genre.description.length <= descriptionMaxLength) return props.genre.description;
    return props.genre.description.substring(0, descriptionMaxLength) + '...';
});

const showReadMore = computed(() => {
    return props.genre.description && props.genre.description.length > descriptionMaxLength;
});

function capitalizeFirstLetter(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

const redirectToFullDescription = (slug) => {
    window.location.href = `/genres/${slug}/description`;
};

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

const redirectToArtist = (slug) => {
    window.location.href = `/artists/${slug}`;
};

const redirectToAllArtists = (slug) => {
    window.location.href = `/genres/${slug}/artists`;
};

const redirectToTrack = (slug) => {
    window.location.href = `/tracks/${slug}`;
};

const redirectToAllTracks = (slug) => {
    window.location.href = `/genres/${slug}/tracks`;
};

const redirectToRelease = (slug) => {
    window.location.href = `/releases/${slug}`;
};

const redirectToAllReleases = (slug) => {
    window.location.href = `/genres/${slug}/releases`;
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

</script>

<template>
    <Head :title="genre.name" />
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
                    :style="imageStyle"
                    loading="eager"
                >
            </div>
            <h1 class="genre-name">{{ capitalizeFirstLetter(genre.name) }}</h1>
        </div>

        <div class="genre-content">
            <div class="main-content">
<!--                <section class="genre-description">-->
<!--                    <h2 class="section-title">About</h2>-->
<!--                    <div class="description-text">-->
<!--                        <p v-if="genre.description">{{ genre.description }}</p>-->
<!--                        <p v-else>No description available for this genre.</p>-->

<!--                        <div class="origin-info">-->
<!--                            <p><strong>Origin Year:</strong> {{ genre.origin_year || "Not specified" }}</p>-->
<!--                            <p><strong>Origin Country:</strong> {{ genre.origin_country || "Not specified" }}</p>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </section>-->

                <section class="genre-description">
                    <h2 class="section-title">About</h2>
                    <div class="description-text" v-html="truncatedDescription"></div>
                        <button
                            v-if="showReadMore"
                            @click="redirectToFullDescription(genre.slug)"
                            class="read-more-button"
                        >
                            Read more
                        </button>
                </section>

                <section class="genre-artists">
                    <div class="genre-artists-header">
                        <h2 class="section-title">Representative Artists</h2>
                        <button
                            v-if="genre.total_artists > genre.artists.length"
                            class="see-all-button"
                            @click="redirectToAllArtists(genre.slug)"
                        >
                            See all {{ genre.total_artists }} artists
                        </button>
                    </div>
                    <div class="artist-list">
                        <div v-for="artist in genre.artists" :key="artist.id" class="artist-card" @click="redirectToArtist(artist.slug)">
                            <img :src="artist.profile_url" class="artist-image" :alt="artist.name">
                            <div class="artist-info">
                                <h3>{{ artist.name }}</h3>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="genre-tracks">
                    <div class="genre-tracks-header">
                        <h2 class="section-title">Popular Tracks</h2>
                        <button
                            v-if="genre.total_tracks > genre.tracks.length"
                            class="see-all-button"
                            @click="redirectToAllTracks(genre.slug)"
                        >
                            See all {{ genre.total_tracks }} tracks
                        </button>
                    </div>
                    <div class="track-list">
                        <div v-for="(track, index) in genre.tracks" :key="track.id" class="track-card">
                            <span class="track-number">{{ index + 1 }}</span>
                            <img :src="track.cover_url" class="track-image" :alt="track.title">
                            <div class="track-info">
                                <h3>
                                    <a @click="redirectToTrack(track.slug)" class="track-title">
                                        {{ track.title }}
                                    </a>
                                </h3>
                                <p class="track-artist" @click="redirectToArtist(track.artist_slug)">{{ track.artist_name }}</p>
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

                <section class="genre-releases">
                    <div class="genre-releases-header">
                        <h2 class="section-title">Notable Releases</h2>
                        <button
                            v-if="genre.total_releases > genre.releases.length"
                            class="see-all-button"
                            @click="redirectToAllReleases(genre.slug)"
                        >
                            See all {{ genre.total_releases }} releases
                        </button>
                    </div>
                    <div class="release-results">
                        <div
                            v-for="release in genre.releases"
                            :key="release.id"
                            class="release-card"
                            @click="redirectToRelease(release.slug)"
                        >
                            <div class="image-wrapper">
                                <img :src="release.cover_url" :alt="release.title">
                            </div>
                            <div class="release-info">
                                <h3>{{ release.title }}</h3>
                                <p class="release-artist" @click="redirectToArtist(release.artist_slug)">{{ release.artist_name }}</p>
                                <p class="release-year">{{ release.year }}</p>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Komentāru sekcija -->
                <Comments
                    :entity-type="'genre'"
                    :entity-slug="genre.slug"
                    :entity-id="Number(genre.id)"
                    :parent-key="'genre_id'"
                    :initial-comments="genre.comments || []"
                    :initial-pagination="genre.comments_pagination"
                />
            </div>

            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
        <AudioPlayer
            :source="currentAudioSource"
            :show="showPlayer"
            @close="closePlayer"
        />
    </main>
    <Footer />
</template>

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
    height: 180px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 1rem;
    margin-top: 1rem;
    border-radius: 8px;
    background-color: #f0f0f0; /* fallback krāsa */
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
    padding: 1rem;
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    z-index: 3;
}

.genre-content {
    display: flex;
    gap: 40px;
    margin-top: 0.5rem;
}

.main-content {
    flex: 1;
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

.genre-description {
    margin-bottom: 2rem;
}

.description-text {
    font-size: 0.9rem;
    line-height: 1.6;
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

.origin-info {
    margin-top: 1rem;
    padding: 1rem;
    background: #f8f8f8;
    border-radius: 6px;
}

.origin-info p {
    margin: 0.5rem 0;
}

.genre-artists {
    margin-bottom: 2rem;
}

.genre-artists-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.artist-list {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    margin-bottom: 1rem;
}

.artist-card {
    width: 150px;
    cursor: pointer;
    transition: transform 0.3s ease;
}

.artist-card:hover {
    transform: translateY(-5px);
}

.artist-image {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 50%;
    margin-bottom: 0.5rem;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.artist-info h3 {
    text-align: center;
    font-size: 1rem;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.see-all-button {
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

.see-all-button:hover {
    background: rgba(12, 75, 170, 0.1);
}

.genre-tracks-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
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

.track-artist {
    color: #666;
    font-size: 0.85rem;
    margin: 0.25rem 0 0 0;
    cursor: pointer;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-artist:hover {
    color: #0c4baa;
    text-decoration: underline;
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

.genre-releases-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
    margin-bottom: 2rem;
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

.release-artist {
    color: #666;
    font-size: 0.9rem;
    margin: 0.25rem 0;
    cursor: pointer;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.release-artist:hover {
    color: #0c4baa;
    text-decoration: underline;
}

.release-year {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* Responsivitāte */
@media (max-width: 1455px) {
    .genre-page {
        width: 90%;
    }
}

@media (max-width: 1230px) {
    .release-info h3 {
        font-size: 0.8rem;
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
        height: 200px;
        margin-bottom: 0.5rem;
    }

    .genre-name {
        font-size: 2rem;
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
    .artist-list {
        justify-content: center;
    }

    .artist-card {
        width: 120px;
    }

    .artist-image {
        height: 120px;
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

    .sidebar-space {
        display: none;
    }
}

@media (max-width: 480px) {
    .genre-hero {
        height: 150px;
    }

    .genre-name {
        font-size: 1.5rem;
    }

    .artist-card {
        width: 100px;
    }

    .artist-image {
        height: 100px;
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

    .release-card {
        flex: 0 0 80%;
    }

    .release-info h3 {
        font-size: 0.95rem;
    }

    .release-year, .release-artist {
        font-size: 0.85rem;
    }
}

</style>
