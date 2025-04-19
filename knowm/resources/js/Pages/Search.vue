<template>
    <div class="search-results">
        <h1>Search Results for "{{ $page.props.searchQuery }}"</h1>

        <!-- Artists Results -->
        <section v-if="artists.length > 0">
            <h2>Artists</h2>
            <div class="artist-grid">
                <div v-for="artist in artists" :key="artist.id" class="artist-card">
                    <img :src="artist.image_url" :alt="artist.name">
                    <h3>{{ artist.name }}</h3>
                </div>
            </div>
        </section>

        <!-- Tracks Results -->
        <section v-if="tracks.length > 0">
            <h2>Tracks</h2>
            <div class="track-list">
                <div v-for="track in tracks" :key="track.id" class="track-item">
                    <div class="track-info">
                        <h3>{{ track.title }}</h3>
                        <p>{{ track.artist.name }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- No Results -->
        <div v-if="artists.length === 0 && tracks.length === 0" class="no-results">
            No results found for "{{ $page.props.searchQuery }}"
        </div>
    </div>
</template>

<script setup>
const props = defineProps({
    artists: Array,
    tracks: Array,
    searchQuery: String
});
</script>

<style scoped>
.search-results {
    padding: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.artist-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 1.5rem;
    margin: 1.5rem 0;
}

.artist-card {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: transform 0.2s;
}

.artist-card:hover {
    transform: translateY(-5px);
}

.artist-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.artist-card h3 {
    padding: 1rem;
    margin: 0;
    text-align: center;
}

.track-list {
    margin: 1.5rem 0;
}

.track-item {
    padding: 1rem;
    border-bottom: 1px solid #eee;
    display: flex;
    align-items: center;
}

.track-item:hover {
    background: #f9f9f9;
}

.no-results {
    padding: 2rem;
    text-align: center;
    font-size: 1.2rem;
    color: #666;
}

</style>
