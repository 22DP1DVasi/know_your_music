<script setup>
import { Head, router } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';
import ColorThief from 'colorthief';
import dayjs from 'dayjs';
import { useDate } from '@/composables/useDate';

const { t, locale } = useI18n();
const { formatDuration } = useDate();

const props = defineProps({
    release: {
        type: Object,
        required: true
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

const goBackToRelease = () => {
    router.visit(`/releases/${props.release.slug}`);
};

const capitalize = (value) => {
    if (!value) return '';
    return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
};

const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    return dayjs(dateString).format('DD/MM/YYYY');
};

const totalDuration = computed(() => {
    let totalSeconds = 0;
    props.release.tracks?.forEach(track => {
        const [hours = 0, minutes = 0, seconds = 0] = track.duration?.split(':').map(Number) || [0, 0, 0];
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

/*
ja locale ir EN un angļu teksts pastāv -> angļu teksts
ja locale ir LV un latviešu teksts pastāv -> latviešu teksts
ja locale ir EN un angļu teksts nepastāv -> latviešu teksts
ja locale ir LV un latviešu teksts nepastāv -> angļu teksts
ja neviens teksts nepastāv -> nekas (tālāk - paziņojums par to)
 */
const currentDescription = computed(() => {
    if (locale.value === 'lv' && props.release.description_lv) {
        return props.release.description_lv;
    }
    if (locale.value === 'en' && props.release.description) {
        return props.release.description;
    }
    if (locale.value === 'lv' && !props.release.description_lv && props.release.description) {
        return props.release.description;
    }
    if (locale.value === 'en' && !props.release.description && props.release.description_lv) {
        return props.release.description_lv;
    }
    return '';
});

const languageNotice = computed(() => {
    // latviešu locale, nav latviešu bio, bet angļu bio eksistē
    if (locale.value === 'lv' && !props.release.description_lv && props.release.description) {
        return {
            show: true,
            message: 'Apraksts pieejams tikai angļu valodā.',
            type: 'lv-no-desc'
        };
    }
    // angļu locale, nav angļu bio, bet latviešu bio eksistē
    if (locale.value === 'en' && !props.release.description && props.release.description_lv) {
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

const getReleaseImage = () => {
    if (props.release.cover_url) {
        return props.release.cover_url;
    }
    return '/images/default-release-banner.webp';
};

</script>

<template>
    <Head :title="`${release.title} - Description`" />
    <Navbar />
    <main class="release-page flex-1">
        <div class="release-hero" :style="heroStyle">
            <div class="hero-gradient" v-if="!isLandscape"></div>
            <div class="hero-image-container">
                <img
                    :src="getReleaseImage()"
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
            <div class="back-button" @click="goBackToRelease">
                ← {{ t('releases.description.back_to_release') }}
            </div>
        </div>

        <div class="release-content">
            <div class="main-content">
                <div class="description-wrapper">
                    <div class="info-card wrapped">
                        <h3 class="info-title">{{ t('releases.description.details_title') }}</h3>
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="info-value">
                                    <b>{{ capitalize(release.release_type) || t('releases.description.unknown') }}</b>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-value">
                                    <b>{{ t('releases.description.release_date') }}:</b>
                                    {{ formatDate(release.release_date) || t('releases.description.unknown') }}
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-value">
                                    <b>{{ t('releases.description.length') }}:</b>
                                    {{ release.tracks?.length || 0 }}
                                    {{ (release.tracks?.length || 0) === 1 ? t('releases.description.track') : t('releases.description.tracks') }},
                                    {{ formatTotalDuration }}
                                </span>
                            </div>
                        </div>
                    </div>

                    <h2 class="section-title">{{ t('releases.description.description_title') }}</h2>

                    <!-- Language notice -->
                    <div v-if="languageNotice.show" class="language-notice" :data-type="languageNotice.type">
                        {{ languageNotice.message }}
                    </div>

                    <!-- Description text -->
                    <div v-if="hasDescription" class="description-text" v-html="currentDescription"></div>
                    <div v-else class="description-text no-description">{{ t('releases.description.no_description') }}</div>
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
.release-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto 0;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.release-hero {
    height: 400px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 1rem;
    margin-top: 1rem;
    border-radius: 8px;
    background-color: #f0f0f0;
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

.release-title {
    position: absolute;
    bottom: 0;
    left: 0;
    padding: 1.5rem;
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    z-index: 3;
    margin: 0;
}

.release-artists {
    position: absolute;
    bottom: 0;
    right: 0;
    padding: 1.5rem;
    color: white;
    font-size: 1.1rem;
    text-shadow: 0 1px 2px rgba(0,0,0,0.5);
    z-index: 3;
}

.release-artists a {
    color: white;
    text-decoration: none;
    transition: text-decoration 0.2s;
}

.release-artists a:hover {
    text-decoration: underline;
}

.back-button {
    position: absolute;
    top: 1rem;
    left: 1rem;
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

.release-content {
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

/* Responsivitāte */
@media (max-width: 1455px) {
    .release-page {
        width: 90%;
    }
}

@media (max-width: 1024px) {
    .release-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .release-content {
        flex-direction: column;
        gap: 10px;
    }

    .release-hero {
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
    .release-hero {
        height: 220px;
    }

    .release-title {
        font-size: 2rem;
        padding: 1rem;
    }

    .release-artists {
        font-size: 0.9rem;
        padding: 1rem;
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
    .release-title {
        font-size: 1.8rem;
    }

    .release-artists {
        display: none;
    }

    .back-button {
        font-size: 0.9rem;
        padding: 0.4rem 0.8rem;
    }
}

</style>
