<script setup>
import { Head, router, usePage } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import AudioPlayer from '@/Components/MiniAudioPlayer.vue';
import Footer from '@/Components/Footer.vue';
import Comments from '@/Components/Comments/Comments.vue';
import TrackCard from '@/Components/Tracks/TrackCard.vue';
import AddToPlaylistModal from "@/Components/Playlists/AddToPlaylistModal.vue";
import ReleaseCard from "@/Components/Releases/ReleaseCard.vue";
import { ref, computed } from 'vue';
import ColorThief from 'colorthief';
import { route } from "ziggy-js";
import { useI18n } from 'vue-i18n';

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

const { t, locale } = useI18n();

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

// piekļuve koplietojamiem datiem no servera puses
const page = usePage();
const user = page.props.auth?.user;

/*
ja locale ir EN un angļu teksts pastāv -> angļu teksts
ja locale ir LV un latviešu teksts pastāv -> latviešu teksts
ja locale ir EN un angļu teksts nepastāv -> latviešu teksts
ja locale ir LV un latviešu teksts nepastāv -> angļu teksts
ja neviens teksts nepastāv -> nekas (tālāk - paziņojums par to)
 */
const currentDescription = computed(() => {
    if (locale.value === 'lv' && props.genre.description_lv) {
        return props.genre.description_lv;
    }
    if (locale.value === 'en' && props.genre.description) {
        return props.genre.description;
    }
    if (locale.value === 'lv' && !props.genre.description_lv && props.genre.description) {
        return props.genre.description;
    }
    if (locale.value === 'en' && !props.genre.description && props.genre.description_lv) {
        return props.genre.description_lv;
    }
    return '';
});

const languageNotice = computed(() => {
    // latviešu locale, nav latviešu bio, bet angļu bio eksistē
    if (locale.value === 'lv' && !props.genre.description_lv && props.genre.description) {
        return {
            show: true,
            message: 'Apraksts pieejams tikai angļu valodā.',
            type: 'lv-no-desc'
        };
    }
    // angļu locale, nav angļu bio, bet latviešu bio eksistē
    if (locale.value === 'en' && !props.genre.description && props.genre.description_lv) {
        return {
            show: true,
            message: 'Description available only in Latvian.',
            type: 'en-no-desc'
        };
    }
    return {
        show: false,
        message: '',
        type: null
    };
});

const truncatedDescription = computed(() => {
    const desc = currentDescription.value;
    if (!desc) {
        return t('genres.show.no_description');
    }
    if (desc.length <= descriptionMaxLength) return desc;
    return desc.substring(0, descriptionMaxLength) + '...';
});

const showReadMore = computed(() => {
    const desc = currentDescription.value;
    return desc && desc.length > descriptionMaxLength;
});

function capitalizeFirstLetter(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

const redirectToFullDescription = (slug) => {
    window.location.href = `/genres/${slug}/description`;
};

// const playTrack = (source) => {
//     currentAudioSource.value = source;
//     showPlayer.value = true;
//     setTimeout(() => {
//         document.querySelector('.audio-player')?.scrollIntoView({ behavior: 'smooth' });
//     }, 100);
// };

const closePlayer = () => {
    showPlayer.value = false;
    currentAudioSource.value = '';
};

const redirectToArtist = (slug) => {
    router.get(`/artists/${slug}`);
};

const redirectToAllArtists = (slug) => {
    router.get(`/genres/${slug}/artists`);
};

const redirectToTrack = (track) => {
    router.get(`/tracks/${track.slug}`);
};

const redirectToAllTracks = (slug) => {
    router.get(`/genres/${slug}/tracks`);
};

const redirectToRelease = (slug) => {
    router.get(`/releases/${slug}`);
};

const redirectToAllReleases = (slug) => {
    router.get(`/genres/${slug}/releases`);
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

// izvēlnes stāvoklis dziesmu kartēm
const openMenuId = ref(null);

// refs priekš modālajam logam priekš dziesmas pievienošanas kolekcijām
const showPlaylistModal = ref(false);
const selectedTrack = ref(null);

const toggleTrackMenu = (trackId) => {
    openMenuId.value = openMenuId.value === trackId ? null : trackId;
};

const openAddToPlaylistModal = (track) => {
    if (!user) {
        router.get(route('login'));
        return;
    }
    selectedTrack.value = track;
    showPlaylistModal.value = true;
};

const closeModal = () => {
    showPlaylistModal.value = false
    selectedTrack.value = null
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
                    <h2 class="section-title">{{ t('genres.show.about') }}</h2>

                    <!-- Language notice -->
                    <div v-if="languageNotice.show" class="language-notice" :data-type="languageNotice.type">
                        {{ languageNotice.message }}
                    </div>

                    <div class="description-text" v-html="truncatedDescription"></div>
                    <button
                        v-if="showReadMore"
                        @click="redirectToFullDescription(genre.slug)"
                        class="read-more-button"
                    >
                        {{ t('genres.show.read_more') }}
                    </button>
                </section>

                <section class="genre-artists">
                    <div class="genre-artists-header">
                        <h2 class="section-title">{{ t('genres.show.representative_artists') }}</h2>
                        <button
                            v-if="genre.total_artists > genre.artists.length"
                            class="see-all-button"
                            @click="redirectToAllArtists(genre.slug)"
                        >
                            {{ t('genres.show.see_all_artists', { count: genre.total_artists }) }}
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
                        <h2 class="section-title">{{ t('genres.show.popular_tracks') }}</h2>
                        <button
                            v-if="genre.total_tracks > genre.tracks.length"
                            class="see-all-button"
                            @click="redirectToAllTracks(genre.slug)"
                        >
                            {{ t('genres.show.see_all_tracks', { count: genre.total_tracks }) }}
                        </button>
                    </div>
                    <div class="track-list">
                        <TrackCard
                            v-for="(track, index) in genre.tracks"
                            :key="track.id"
                            :track="track"
                            :index="index"
                            duration-format="HH:mm:ss"
                            :show-number="true"
                            :show-image="true"
                            :show-artists="true"
                            :show-duration="true"
                            :show-context-menu="true"
                            :can-add="true"
                            :can-remove="false"
                            @track-click="redirectToTrack"
                            :menu-open="openMenuId === track.id"
                            @add-to-playlist="openAddToPlaylistModal"
                            @toggle-menu="toggleTrackMenu"
                        />
                    </div>
                </section>

                <section class="genre-releases">
                    <div class="genre-releases-header">
                        <h2 class="section-title">{{ t('genres.show.notable_releases') }}</h2>
                        <button
                            v-if="genre.total_releases > genre.releases.length"
                            class="see-all-button"
                            @click="redirectToAllReleases(genre.slug)"
                        >
                            {{ t('genres.show.see_all_releases', { count: genre.total_releases }) }}
                        </button>
                    </div>
                    <div class="release-results">
                        <ReleaseCard
                            v-for="release in genre.releases"
                            :key="release.id"
                            :release="release"
                            :max-artists="3"
                            @release-click="(release) => redirectToRelease(release.slug)"
                        />
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

    <AddToPlaylistModal
        :show="showPlaylistModal"
        :track="selectedTrack"
        @close="closeModal"
    />
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

.language-notice {
    font-size: 0.85rem;
    color: #666;
    margin-bottom: 0.75rem;
    padding: 0.4rem 0.75rem;
    background-color: #f5f5f5;
    border-radius: 4px;
    border-left: 3px solid #999;
    font-style: italic;
}

.language-notice[data-type="lv-no-desc"] {
    border-left-color: #0c4baa;
}

.language-notice[data-type="en-no-desc"] {
    border-left-color: #aa0c4b;
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
    overflow: visible;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
    max-width: 100%;
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
}

</style>
