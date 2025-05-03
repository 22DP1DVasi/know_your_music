<template>
    <Head :title="title" />
    <Navbar />
    <main class="artist-bio-page">
        <div class="bio-header">
            <h1>{{ artist.name }}</h1>
            <div class="back-button" @click="goBack">
                ← Back to artist
            </div>
        </div>

        <div class="bio-content">
            <section class="full-bio">
                <h2>Biography</h2>
                <div class="bio-text" v-html="artist.biography"></div>
            </section>

            <div class="bio-sidebar">
                <div class="info-card">
                    <h3>Active Years</h3>
                    <div class="info-item">
                        <span class="info-label">Formed:</span>
                        <span class="info-value">{{ artist.formed_year || 'Unknown' }}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Disbanded:</span>
                        <span class="info-value">{{ artist.disbanded_year || 'Still active' }}</span>
                    </div>
                </div>

                <div class="info-card">
                    <h3>Genres</h3>
                    <div class="genre-tags">
                        <span v-for="genre in artist.genres" :key="genre" class="genre-tag">
                            {{ genre }}
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';

const props = defineProps({
    artist: Object,
    title: String
});

const goBack = () => {
    window.history.back();
};
</script>

<style scoped>
.artist-bio-page {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 20px;
}

.bio-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #eee;
}

.bio-header h1 {
    font-size: 2rem;
    color: #0c4baa;
}

.back-button {
    cursor: pointer;
    color: #0c4baa;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    transition: background-color 0.2s;
}

.back-button:hover {
    background-color: #f0f4ff;
}

.bio-content {
    display: flex;
    gap: 40px;
}

.full-bio {
    flex: 1;
}

.bio-text {
    font-size: 1rem;
    line-height: 1.6;
    white-space: pre-line;
}

.bio-sidebar {
    width: 300px;
    flex-shrink: 0;
}

.info-card {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 1.5rem;
}

.info-item {
    margin-bottom: 0.75rem;
}

.info-label {
    font-weight: 500;
    margin-right: 0.5rem;
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

@media (max-width: 768px) {
    .bio-content {
        flex-direction: column;
    }

    .bio-sidebar {
        width: 100%;
    }
}
</style>
