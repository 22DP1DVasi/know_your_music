<script setup>
import { Head, router } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';
import { ref, computed } from 'vue';
import ColorThief from 'colorthief';
import dayjs from 'dayjs';
import { useDate } from '@/composables/useDate';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    track: {
        type: Object,
        required: true
    }
});

const { t, locale } = useI18n();
const { formatDuration } = useDate();

// Hero image logic
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

const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    return dayjs(dateString).format('MMMM D, YYYY');
};

const goBackToTrack = () => {
    router.visit(`/tracks/${props.track.slug}`);
};

// Bilingual description logic
const currentDescription = computed(() => {
    if (locale.value === 'lv' && props.track.description_lv) {
        return props.track.description_lv;
    }
    if (locale.value === 'en' && props.track.description) {
        return props.track.description;
    }
    // Fallback: if LV but no LV description, show EN description
    if (locale.value === 'lv' && !props.track.description_lv && props.track.description) {
        return props.track.description;
    }
    // Fallback: if EN but no EN description, show LV description
    if (locale.value === 'en' && !props.track.description && props.track.description_lv) {
        return props.track.description_lv;
    }
    return '';
});

const languageNotice = computed(() => {
    // Latvian locale, no Latvian description, but English description exists
    if (locale.value === 'lv' && !props.track.description_lv && props.track.description) {
        return {
            show: true,
            message: 'Apraksts pieejams tikai angļu valodā.',
            type: 'lv-no-desc'
        };
    }
    // English locale, no English description, but Latvian description exists
    if (locale.value === 'en' && !props.track.description && props.track.description_lv) {
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

const hasDescription = computed(() => {
    return currentDescription.value !== '';
});

</script>

<template>
    <Head :title="`${track.title} - Description`" />
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
            <div class="back-button" @click="goBackToTrack">
                ← {{ t('tracks.description.back_to_track') }}
            </div>
        </div>

        <div class="track-content">
            <div class="main-content">
                <div class="description-wrapper">
                    <div class="info-card wrapped">
                        <h3 class="info-title">{{ t('tracks.description.details_title') }}</h3>
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="info-value">
                                    <b>{{ t('tracks.global.release_date') }}</b> {{ formatDate(track.release_date) || t('tracks.description.unknown') }}
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-value">
                                    <b>{{ t('tracks.global.length') }}</b> {{ formatDuration(track.duration) || t('tracks.description.unknown') }}
                                </span>
                            </div>
                        </div>
                    </div>

                    <h2 class="section-title">{{ t('tracks.description.description_title') }}</h2>

                    <!-- Language notice -->
                    <div v-if="languageNotice.show" class="language-notice" :data-type="languageNotice.type">
                        {{ languageNotice.message }}
                    </div>

                    <!-- Description text -->
                    <div v-if="hasDescription" class="description-text" v-html="currentDescription"></div>
                    <div v-else class="description-text no-description">{{ t('tracks.description.no_description') }}</div>
                </div>
            </div>

            <div class="sidebar-space">
                <!-- Future content will go here -->
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.track-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto 0;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.track-hero {
    height: 300px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 2rem;
    margin-top: 1rem;
    border-radius: 8px;
    background-color: #f0f0f0;
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
}

.track-artists a {
    color: white;
    text-decoration: none;
    transition: text-decoration 0.2s;
}

.track-artists a:hover {
    text-decoration: underline;
}

.back-button {
    position: absolute;
    top: 1rem;
    right: 1rem;
    cursor: pointer;
    color: white;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 4;
    transition: background-color 0.2s;
}

.back-button:hover {
    background-color: rgba(0, 0, 0, 0.7);
}

.track-content {
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

.description-wrapper {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    margin-bottom: 2rem;
    position: relative;
}

.info-card.wrapped {
    float: right;
    width: fit-content;
    max-width: 50%;
    margin: 0 0 1rem 1.5rem;
    background: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 1rem;
    box-shadow: none;
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

.description-text {
    flex: 3;
    font-size: 0.9rem;
    line-height: 1.6;
    white-space: pre-line;
    word-break: break-word;
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    margin-bottom: 1.5rem;
}

.no-description {
    color: #666;
    font-style: italic;
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

@media (max-width: 1455px) {
    .track-page {
        width: 90%;
    }
}

@media (max-width: 1024px) {
    .track-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .track-content {
        flex-direction: column;
        gap: 10px;
    }

    .track-hero {
        margin-bottom: 0.5rem;
    }

    .sidebar-space {
        width: 100%;
        order: -1;
        margin-bottom: 1rem;
    }

    .info-card.wrapped {
        font-size: 0.8rem;
    }
}

@media (max-width: 768px) {
    .track-hero {
        height: 220px;
    }

    .track-title {
        font-size: 1.5rem;
        padding: 1rem;
    }

    .track-artists {
        font-size: 0.8rem;
        padding: 1rem;
        display: none;
    }

    .main-content {
        max-width: 100%;
        width: 100%;
    }

    .description-wrapper {
        flex-direction: column;
    }

    .info-card.wrapped {
        float: none;
        width: 100%;
        max-width: 100%;
        margin: 0 0 1rem 0;
        line-height: 1.3;
    }

    .info-flex {
        gap: 0.5rem;
    }

    .sidebar-space {
        display: none;
    }
}

@media (max-width: 480px) {
    .track-title {
        font-size: 1.2rem;
    }

    .back-button {
        font-size: 0.8rem;
        padding: 0.3rem 0.6rem;
    }
}

</style>
