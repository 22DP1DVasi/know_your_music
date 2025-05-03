<template>
    <Head :title="artist.name" />
    <Navbar />
    <main class="artist-page">
        <div class="artist-hero">
            <img :src="getArtistImage(artist)" :alt="artist.name" class="hero-image">
        </div>

        <div class="artist-content">
            <div class="main-content">
                <section class="artist-description">
                    <h2 class="section-title">About</h2>
                    <div class="bio-text" v-html="artist.biography"></div>
                </section>

                <div class="artist-side-info">
                    <div class="info-card">
                        <h3 class="info-title">Details</h3>
                        <div class="info-grid">
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
                    <div class="release-grid">
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
import { Head } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'

const props = defineProps({
    artist: Object
})

const getArtistImage = (artist, type = 'profile') => {
    if (artist.profile_url) return artist.profile_url;
    return `/storage/artists/${artist.id}/${type}/${type}.webp`;
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

</script>

<style scoped>
.artist-page {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
}

.artist-hero {
    width: 100%;
    margin-bottom: 2rem;
}

.hero-image {
    width: 100%;
    max-height: 400px;
    object-fit: cover;
    border-radius: 0 0 8px 8px;
}

.artist-content {
    display: flex;
    gap: 40px;
}

.main-content {
    flex: 1;
    max-width: 800px;
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

.bio-text {
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
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    flex: 1;
    min-width: 250px;
}

.info-title {
    font-size: 1.1rem;
    margin-bottom: 1rem;
    color: #333;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.75rem;
}

.info-item {
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

.release-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 1.5rem;
    margin-bottom: 3rem;
}

.release-card {
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
    .artist-side-info {
        flex-direction: column;
    }

    .info-card {
        min-width: 100%;
    }

    .release-grid {
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
    }
}
</style>
