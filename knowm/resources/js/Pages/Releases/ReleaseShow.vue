<script setup>
import { Head, router } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import { ref, computed } from 'vue'
import ColorThief from 'colorthief'
import dayjs from 'dayjs';

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
    height: '300px',
    position: 'relative',
    overflow: 'hidden',
    backgroundColor: '#f0f0f0'
});
const imageStyle = ref({
    opacity: 0,
    transition: 'opacity 0.3s ease'
});

const handleImageLoad = () => {
    const img = heroImage.value;
    if (!img) return;

    imageStyle.value.opacity = 1;
    imageStyle.value.width = '100%';
    imageStyle.value.height = 'auto';
    imageStyle.value.objectFit = 'cover';
    imageStyle.value.objectPosition = 'center';
};

const sortedTracks = computed(() => {
    return [...props.release.tracks].sort((a, b) => a.pivot.track_position - b.pivot.track_position);
});

const totalDuration = computed(() => {
    let totalSeconds = 0;
    props.release.tracks.forEach(track => {
        const [hours = 0, minutes = 0, seconds = 0] = track.duration.split(':').map(Number);
        totalSeconds += hours * 3600 + minutes * 60 + seconds;
    });

    return totalSeconds;
});

const formatTotalDuration = computed(() => {
    const hours = Math.floor(totalDuration.value / 3600);
    const minutes = Math.floor((totalDuration.value % 3600) / 60);
    const seconds = totalDuration.value % 60;
    if (hours > 0) {
        return `${hours}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    } else {
        return `${minutes}:${seconds.toString().padStart(2, '0')}`;
    }
});

const capitalize = (value) => {
    if (!value) return '';
    return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
};

const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    return dayjs(dateString).format('DD/MM/YYYY');
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

const redirectToGenre = (slug) => {
    window.location.href = `/genres/${slug}`;
};

const redirectToTrack = (slug) => {
    window.location.href = `/tracks/${slug}`;
};

</script>

<template>
    <Head :title="release.title" />
    <link rel="preload" :href="release.cover_url" as="image">
    <Navbar />
    <main class="release-page flex-1">
        <div class="release-hero" :style="heroStyle">
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

        <div class="release-content-container">
            <div class="release-cover-container">
                <div class="release-cover">
                    <img :src="release.cover_url" :alt="release.title">
                </div>
                <div class="top-info-card">
                    <div class="top-info-card-wrapped">
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="meta-value"><b>{{ capitalize(release.release_type) }}</b></span>
                            </div>
                            <div class="info-item">
                                <span class="meta-value"><b>Release Date:</b> {{ formatDate(release.release_date) }}</span>
                            </div>
                            <div class="info-item">
                                <span class="meta-value">
                                    <b>Length:</b> {{ release.tracks.length }} {{ release.tracks.length === 1 ? 'track' : 'tracks' }}, {{ formatTotalDuration }}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="release-content">
                <div class="main-content">
                    <div class="release-description">
                        <div class="info-card-wrapped">
                            <div class="info-flex">
                                <div class="info-item">
                                    <span class="meta-value"><b>{{ capitalize(release.release_type) }}</b></span>
                                </div>
                                <div class="info-item">
                                    <span class="meta-value"><b>Release Date:</b> {{ formatDate(release.release_date) }}</span>
                                </div>
                                <div class="info-item">
                                    <span class="meta-value">
                                        <b>Length:</b> {{ release.tracks.length }} {{ release.tracks.length === 1 ? 'track' : 'tracks' }}, {{ formatTotalDuration }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <h2 class="section-title">About This Release</h2>
                        <div v-if="release.description" class="description-text" v-html="release.description"></div>
                        <div v-else class="description-text" style="margin-bottom: 150px;">There is no background for this release.</div>

                        <div class="genres-card">
                            <div class="genres-header">
                                <h3 class="info-title">Genres</h3>
                                <!--                                <button-->
                                <!--                                    v-if="release.genres.length > 5"-->
                                <!--                                    class="see-all-genres"-->
                                <!--                                    @click="redirectToAllGenres"-->
                                <!--                                >-->
                                <!--                                    See all genres-->
                                <!--                                </button>-->
                            </div>
                            <div v-if="!release.genres.length">No genres related to this release.</div>
                            <div v-else class="genre-tags">
                                <button
                                    v-for="(genre, index) in release.genres.slice(0, 5)"
                                    :key="genre"
                                    class="genre-tag"
                                    :title="genre.name.length > 16 ? genre.name : ''"
                                    @click="redirectToGenre(genre.slug)"
                                >
                                    {{ genre.name }}
                                </button>
                            </div>
                        </div>

                    </div>

                    <section class="release-tracks">
                        <div class="tracks-header">
                            <h2 class="section-title">Tracklist</h2>
                            <span class="tracks-count">{{ release.tracks.length }} {{ release.tracks.length === 1 ? 'track' : 'tracks' }}</span>
                        </div>
                        <div class="track-list">
                            <div v-for="track in sortedTracks" :key="track.id" class="track-card">
                                <span class="track-number">{{ track.pivot.track_position }}</span>
                                <div class="track-info">
                                    <h3>
                                        <a @click="redirectToTrack(track.slug)" class="track-title">
                                            {{ track.title }}
                                        </a>
                                    </h3>
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
            </div>

            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.release-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    position: relative;
}

.release-hero {
    height: 300px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 1rem;
    margin-top: 1rem;
    background-color: #f0f0f0;
    display: flex;
    align-items: center;
    justify-content: center;
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
}

.hero-image {
    width: 100%;
    height: auto;
    min-height: 100%;
    object-fit: cover;
    object-position: center;
    filter: brightness(0.7);
    transition: filter 0.3s ease;
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
    max-width: 70%;
    white-space: normal;
    display: -webkit-box;
    -webkit-line-clamp: 4;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
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
    max-width: 70%;
}

.release-artists a {
    color: white;
    text-decoration: none;
}

.release-artists a:hover {
    text-decoration: underline;
}

.release-content-container {
    position: relative;
    display: flex;
    flex-direction: column;
    margin-top: 20px;
}

.release-cover-container {
    position: absolute;
    top: -80px;
    right: 50px;
    width: 400px;
    height: 480px;
    z-index: 2;
    pointer-events: none;
}

.release-cover {
    position: sticky;
    top: 20px;
    width: 400px;
    height: 400px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
    border: 1px solid rgb(136, 136, 136);
    background: #f0f0f0;
}

.release-cover img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.top-info-card {
    display: none;
}

.top-info-card-wrapped {
    width: 450px;
    height: 130px;
    max-width: 50%;
    margin: 0 0 1rem 1.5rem;
    top: 70%;
    transform: translateY(70%);
    box-shadow: none;
}

.main-content {
    flex: 1;
    max-width: calc(100% - 100px);
    padding-right: 20px;
    margin-left: 20px;
}

.release-content {
    display: flex;
    flex-direction: column;
    margin-top: 1rem;
    padding-right: 380px;
}

.section-title {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: #0c4baa;
}

.meta-value {
    display: block;
}

.release-description {
    background: white;
    border-radius: 8px;
    margin-bottom: 2rem;
    position: relative;
    white-space: pre-line;
    word-break: break-word;
}

.info-card-wrapped {
    float: right;
    width: fit-content;
    max-width: 50%;
    margin: 3.3rem 1rem 1rem 1.5rem;
    background: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 1rem;
    box-shadow: none;
}

.info-flex {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    flex-direction: column;
}

.info-item {
    flex: 1;
    min-width: 120px;
    display: flex;
    flex-direction: row;
}

.sidebar-space {
    width: 300px;
    position: absolute;
    right: 20px;
    top: 440px;
    bottom: 20px;
    margin-top: 20px;
    display: flex;
    flex-direction: column;
}

.description-text {
    flex: 3;
    font-size: 0.9rem;
    line-height: 1.6;
    white-space: pre-line;
}

.genres-card {
    width: fit-content;
    max-width: 100%;
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    margin-top: 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.genres-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    width: 100%;
}

.genres-header .info-title {
    margin: 0;
    font-size: 1.1rem;
    color: #333;
    font-weight: 600;
}

.see-all-genres {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 0.9rem;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    transition: background 0.2s;
    white-space: nowrap;
}

.see-all-genres:hover {
    background: rgba(12, 75, 170, 0.1);
}

.genre-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    max-width: 100%;
    overflow-x: auto;
    padding-bottom: 0.5rem;
    -webkit-overflow-scrolling: touch;
}

.genre-tag {
    background: #f0f4ff;
    color: #0c4baa;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.9rem;
    white-space: nowrap;
    flex-shrink: 0;
    transition: background 0.2s;
}

.genre-tag:hover {
    background: #e0e8ff;
}

.genre-tags::-webkit-scrollbar {
    display: none;
}

.tracks-header {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.tracks-count {
    color: #666;
    font-size: 1rem;
    margin-bottom: 1rem;
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

    .release-cover-container {
        width: 350px;
        height: 470px;
    }

    .release-cover {
        width: 350px;
        height: 350px;
    }

    .info-card-wrapped {
        margin-right: 0.7rem;
    }

    .main-content {
        max-width: calc(100% - 40px);
    }
}

@media (max-width: 1200px) {
    .release-hero {
        height: 280px !important;
    }

    .release-title {
        font-size: 2.2rem;
        bottom: 55px;
    }

    .release-artists {
        font-size: 1.1rem;
        bottom: 28px;
    }

    .release-content {
        padding-right: 370px;
    }

    .sidebar-space {
        top: 390px;
    }
}

@media (max-width: 1150px) {
    .release-cover-container {
        width: 300px;
        height: 420px;
    }

    .release-cover {
        width: 300px;
        height: 300px;
    }

    .release-content {
        padding-right: 320px;
    }

    .sidebar-space {
        top: 340px;
        width: 280px;
    }
}

@media (max-width: 1024px) {
    .release-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }
    .release-hero {
        height: 260px !important;
    }
    .release-title {
        font-size: 2rem;
        bottom: 50px;
    }
    .release-artists {
        font-size: 1rem;
        bottom: 26px;
    }
}

@media (max-width: 900px) {
    .release-hero {
        height: 240px !important;
    }
    .release-title {
        font-size: 1.8rem;
        bottom: 45px;
    }
    .release-artists {
        font-size: 0.95rem;
        bottom: 24px;
    }

    .release-content-container {
        flex-direction: column;
    }

    .release-cover-container {
        position: relative;
        top: 0;
        width: 100%;
        height: auto;
        margin-bottom: 1.5rem;
        display: flex;
        justify-content: flex-start;
        left: 0;
        margin-left: 30px;
    }

    .release-cover {
        min-width: 300px;
        width: 300px;
        height: 300px;
    }

    .top-info-card {
        display: flex;
    }

    .release-content {
        padding-right: 0;
    }

    .main-content {
        max-width: 100%;
        padding-right: 0;
        margin-left: 10px;
        margin-right: 10px;
    }

    .info-card-wrapped {
        display: none;
    }

    .sidebar-space {
        position: static;
        width: 100%;
        height: auto;
        margin-top: 2rem;
    }
}

@media (max-width: 768px) {
    .release-hero {
        height: 220px !important;
    }
    .release-title {
        font-size: 1.6rem;
        bottom: 40px;
    }
    .release-artists {
        font-size: 0.9rem;
        bottom: 22px;
    }

    .release-cover {
        min-width: 250px;
        width: 250px;
        height: 250px;
    }

    .top-info-card-wrapped {
        top: 50%;
        transform: translateY(50%);
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

@media (max-width: 640px) {
    .release-hero {
        height: 200px !important;
    }
    .release-title {
        font-size: 1.4rem;
        bottom: 35px;
    }
    .release-artists {
        font-size: 0.85rem;
        bottom: 20px;
    }
}

@media (max-width: 580px) {
    .release-title {
        font-size: 1.5rem;
        bottom: 40px;
        padding: 0 1rem;
        max-width: 50%;
    }

    .release-artists {
        font-size: 0.9rem;
        bottom: 20px;
        padding: 0 1rem;
        max-width: 50%;
    }

    .top-info-card-wrapped {
        height: 160px;
        width: 300px;
        top: 45%;
        transform: translateY(45%);
    }

    .meta-value {
        font-size: 0.9rem;
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

@media (max-width: 530px) {
    .release-cover-container {
        margin-left: 10px;
    }

    .release-cover {
        min-width: 200px;
        width: 200px;
        height: 200px;
    }

    .top-info-card-wrapped {
        height: 160px;
        width: 300px;
        top: 30%;
        transform: translateY(30%);
        margin-left: 0.8rem;
    }

    .top-info-card-wrapped span {
        font-size: 0.8rem;
    }

    .release-description {
        padding: 1.25rem 0;
    }
}

@media (max-width: 480px) {
    .release-hero {
        height: 180px !important;
    }
    .release-title {
        font-size: 1.2rem;
        bottom: 30px;
        padding: 0 1rem;
    }
    .release-artists {
        font-size: 0.8rem;
        bottom: 18px;
        padding: 0 1rem;
    }
}

@media (max-width: 410px) {
    .release-cover {
        min-width: 150px;
        width: 150px;
        height: 150px;
    }

    .top-info-card-wrapped {
        top: 15%;
        transform: translateY(15%);
        width: calc(100% - 170px);
        max-width: 220px;
        height: auto;
        min-height: 120px;
        padding: 0.5rem;
        margin-left: 0.5rem;
    }

    .info-flex {
        display: flex;
        flex-direction: column;
        gap: 0.3rem;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        width: 100%;
    }

    .meta-value {
        font-size: 0.7rem;
        line-height: 1.4;
        word-break: break-word;
        overflow-wrap: break-word;
        white-space: normal;
        display: inline;
    }

    .meta-value b {
        font-size: 0.75rem;
        margin-right: 0.2rem;
    }

    .description-text {
        font-size: 0.8rem;
    }
}

@media (max-width: 360px) {
    .release-hero {
        height: 160px !important;
    }
    .release-title {
        font-size: 1.1rem;
        bottom: 25px;
        margin-bottom: 7px;
    }
    .release-artists {
        font-size: 0.75rem;
        bottom: 15px;
    }
}

@media (max-width: 320px) {
    .release-title {
        font-size: 1rem !important;
        margin-bottom: 10px;
    }
}

@media (max-width: 317px) {
    .release-title {
        margin-bottom: 23px;
    }
}

</style>
