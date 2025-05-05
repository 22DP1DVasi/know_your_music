<template>
    <Head :title="track.title" />
    <link rel="preload" :href="track.cover_url" as="image">
    <Navbar />
    <main class="track-page flex-1">
        <div class="track-hero" :style="heroStyle">
            <div class="hero-image-container">
                <img
                    :src="track.cover_url"
                    :alt="track.title"
                    class="hero-image"
                    ref="heroImage"
                    @load="handleImageLoad"
                    :style="imageStyle"
                    loading="eager"
                >
            </div>
            <h1 class="track-title">{{ track.title }}</h1>
            <div class="track-artists">
                <span v-for="(artist, index) in track.artists" :key="artist.id">
                    <a :href="`/artists/${artist.slug}`">{{ artist.name }}</a>
                    <span v-if="index < track.artists.length - 1">, </span>
                </span>
            </div>
        </div>

        <div class="track-content-container">
            <div class="track-cover-container">
                <div class="track-cover">
                    <img :src="track.cover_url" :alt="track.title">
                </div>
                <div class="top-info-card">
                    <div class="top-info-card-wrapped">
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="meta-value"><b>Release Date:</b> {{ formatDate(track.release_date) }}</span>
                            </div>
                            <div class="info-item">
                                <span class="meta-value">
                                    <b>Length:</b> {{ formatDuration(track.duration) }}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="track-content">
                <div class="main-content">
                    <div class="track-description">
                        <div class="info-card-wrapped">
                            <div class="info-flex">
                                <div class="info-item">
                                    <span class="meta-value"><b>Release Date:</b> {{ formatDate(track.release_date) }}</span>
                                </div>
                                <div class="info-item">
                                    <span class="meta-value">
                                        <b>Length:</b> {{ formatDuration(track.duration) }}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <h2 class="section-title">About This Track</h2>
                        <div v-if="track.description" class="description-text" v-html="track.description"></div>
                        <div v-else class="description-text">There is no background for this track.</div>

                        <div v-if="track.genres && track.genres.length" class="genres-card">
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
                            <div class="genre-tags">
                                <span
                                    v-for="(genre, index) in track.genres.slice(0, 5)"
                                    :key="index"
                                    class="genre-tag"
                                    :title="genre.length > 16 ? genre : ''"
                                >
                                    {{ genre.name }}
                                </span>
                            </div>
                        </div>

                        <section class="track-lyrics">
                            <div class="lyrics-header">
                                <h2 class="section-title">Lyrics</h2>
                                <span v-if="lyrics.status === 'verified'" class="verified-badge">
                                    Verified
                                </span>
                                <span v-else class="unverified-badge">
                                    Needs Verification
                                </span>
                            </div>
                            <div class="lyrics-content">
                                <pre v-if="lyrics.text" class="lyrics-text">{{ lyrics.text }}</pre>
                                <div v-else class="no-lyrics">
                                    No lyrics available for this track yet.
                                </div>
                            </div>
                        </section>
                    </div>

                    <section class="track-comments">
                        <h2 class="section-title">Comments</h2>
                        <div class="comments-section">
                            <!-- Comment components would go here -->
                        </div>
                    </section>
                </div>
            </div>

            <div class="sidebar-space">
                <!-- Future content like "Similar Tracks" will go here -->
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
    track: {
        type: Object,
        required: true,
        default: () => ({
            id: Number,
            title: String,
            cover_url: String,
            release_date: String,
            duration: String,
            artists: Array,
            genres: Array,
            release: Object
        })
    },
    lyrics: {
        type: Object,
        default: () => ({
            id: Number,
            text: String,
            status: String,
            track_id: Number
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
.track-page {
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

.track-hero {
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

.track-title {
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

.track-artists {
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

.track-artists a {
    color: white;
    text-decoration: none;
}

.track-artists a:hover {
    text-decoration: underline;
}

.track-content-container {
    position: relative;
    display: flex;
    flex-direction: column;
    margin-top: 20px;
}

.track-cover-container {
    position: absolute;
    top: -80px;
    right: 50px;
    width: 400px;
    height: 480px;
    z-index: 2;
    pointer-events: none;
}

.track-cover {
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

.track-cover img {
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
    max-width: calc(100% - 30px);
    padding-right: 20px;
    margin-left: 20px;
}

.track-content {
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

.track-description {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    margin-bottom: 2rem;
    position: relative;
    white-space: pre-line;
    word-break: break-word;
}

.info-card-wrapped {
    float: right;
    width: fit-content;
    max-width: 50%;
    margin: 3.3rem 0 1rem 1.5rem;
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

.track-lyrics {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    margin: 2rem 0;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.lyrics-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.lyrics-text {
    white-space: pre-wrap;
    font-family: inherit;
    line-height: 1.6;
    margin: 0;
    font-size: 1rem;
    color: #333;
}

.no-lyrics {
    color: #666;
    font-style: italic;
}

.verified-badge {
    background: #4CAF50;
    color: white;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
    font-weight: 500;
}

.unverified-badge {
    background: #FFC107;
    color: #333;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
    font-weight: 500;
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

@media (max-width: 1455px) {
    .track-page {
        width: 90%;
    }

    .track-cover-container {
        width: 350px;
        height: 470px;
    }

    .track-cover {
        width: 350px;
        height: 350px;
    }
}

@media (max-width: 1200px) {
    .track-hero {
        height: 280px !important;
    }
    .track-title {
        font-size: 2.2rem;
        bottom: 55px;
    }

    .track-artists {
        font-size: 1.1rem;
        bottom: 28px;
    }

    .track-content {
        padding-right: 340px;
    }

    .sidebar-space {
        top: 390px;
    }
}

@media (max-width: 1150px) {
    .track-cover-container {
        width: 300px;
        height: 420px;
    }

    .track-cover {
        width: 300px;
        height: 300px;
    }

    .track-content {
        padding-right: 290px;
    }

    .sidebar-space {
        top: 340px;
        width: 280px;
    }
}

@media (max-width: 1024px) {
    .track-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }
    .track-hero {
        height: 260px !important;
    }
    .track-title {
        font-size: 2rem;
        bottom: 50px;
    }
    .track-artists {
        font-size: 1rem;
        bottom: 26px;
    }
}

@media (max-width: 900px) {
    .track-hero {
        height: 240px !important;
    }
    .track-title {
        font-size: 1.8rem;
        bottom: 45px;
    }
    .track-artists {
        font-size: 0.95rem;
        bottom: 24px;
    }

    .track-content-container {
        flex-direction: column;
    }

    .track-cover-container {
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

    .track-cover {
        min-width: 300px;
        width: 300px;
        height: 300px;
    }

    .top-info-card {
        display: flex;
    }

    .track-content {
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
    .track-hero {
        height: 220px !important;
    }
    .track-title {
        font-size: 1.6rem;
        bottom: 40px;
    }
    .track-artists {
        font-size: 0.9rem;
        bottom: 22px;
    }

    .track-cover {
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

    .lyrics-text {
        font-size: 0.95rem;
    }
}

@media (max-width: 640px) {
    .track-hero {
        height: 200px !important;
    }
    .track-title {
        font-size: 1.4rem;
        bottom: 35px;
    }
    .track-artists {
        font-size: 0.85rem;
        bottom: 20px;
    }
}

@media (max-width: 580px) {
    .track-title {
        font-size: 1.5rem;
        bottom: 40px;
        padding: 0 1rem;
        max-width: 50%;
    }

    .track-artists {
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

    .track-title {
        font-size: 0.9rem;
    }
}

@media (max-width: 530px) {
    .track-cover-container {
        margin-left: 10px;
    }

    .track-cover {
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

    .track-description {
        padding: 1.25rem 0;
    }
}

@media (max-width: 480px) {
    .track-hero {
        height: 180px !important;
    }
    .track-title {
        font-size: 1.2rem;
        bottom: 30px;
        padding: 0 1rem;
    }
    .track-artists {
        font-size: 0.8rem;
        bottom: 18px;
        padding: 0 1rem;
    }

    .lyrics-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.5rem;
    }

    .lyrics-text {
        font-size: 0.9rem;
    }
}

@media (max-width: 410px) {
    .trackcover {
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
    .track-hero {
        height: 160px !important;
    }
    .track-title {
        font-size: 1.1rem;
        bottom: 25px;
    }
    .track-artists {
        font-size: 0.75rem;
        bottom: 15px;
    }
}

</style>
