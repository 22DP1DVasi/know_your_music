<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { router } from '@inertiajs/vue3';

const { t } = useI18n();

const props = defineProps({
    playlist: {
        type: Object,
        required: true,
        validator: (value) => {
            return value.id && value.name && value.slug;
        }
    },
    // attēlošanas opcijas
    clickable: {
        type: Boolean,
        default: true
    },
    showPrivacy: {
        type: Boolean,
        default: true
    },
    showTrackCount: {
        type: Boolean,
        default: true
    },
    // noklusējuma attēls tukšam atskaņošanas sarakstam
    defaultImage: {
        type: String,
        default: '/images/default-playlist-banner.webp'
    },
    // pielāgots novirzīšanas URL vai funkcija
    redirectUrl: {
        type: [String, Function],
        default: null
    }
});

const emit = defineEmits(['playlist-click']);

// helper, lai iegūtu pirmās dziesmas attēlu vai noklusējuma
const playlistImage = computed(() => {
    if (props.playlist.tracks &&
        props.playlist.tracks.length > 0 &&
        props.playlist.tracks[0].cover_url) {
        return props.playlist.tracks[0].cover_url;
    }
    return props.defaultImage;
});

// helper, lai iegūtu dziesmu skaita tekstu
const tracksCountText = computed(() => {
    const count = props.playlist.tracks?.length || 0;
    if (count === 1) {
        return t('user_pages.playlists.track_count_singular', { count });
    }
    return t('user_pages.playlists.track_count_plural', { count });
});

const handlePlaylistClick = () => {
    if (!props.clickable) return;
    emit('playlist-click', props.playlist);
    if (props.redirectUrl) {
        if (typeof props.redirectUrl === 'function') {
            props.redirectUrl(props.playlist.slug);
        } else {
            router.get(props.redirectUrl);
        }
    } else {
        router.get(`/playlists/${props.playlist.slug}`);
    }
};

const handleImageError = (event) => {
    event.target.src = props.defaultImage;
};

</script>

<template>
    <div
        class="playlist-card"
        :class="{ 'clickable': clickable }"
        @click="handlePlaylistClick"
    >
        <div class="playlist-image-wrapper">
            <img
                :src="playlistImage"
                :alt="playlist.name"
                class="playlist-image"
                loading="lazy"
                @error="handleImageError"
            >

            <!-- Skaits, cik dziesmas atskaņošanas sarakstā -->
            <div v-if="showTrackCount" class="tracks-count-badge">
                <i class="fa-solid fa-music"></i>
                <span>{{ tracksCountText }}</span>
            </div>
        </div>

        <div class="playlist-info">
            <h3 class="playlist-name">{{ playlist.name }}</h3>

            <!-- Privātuma statusa emblēma -->
            <div v-if="showPrivacy" class="playlist-meta">
                <span
                    class="privacy-badge"
                    :class="{ 'private': playlist.is_private, 'public': !playlist.is_private }"
                >
                    <i
                        :class="playlist.is_private ? 'fa-solid fa-lock' : 'fa-solid fa-globe'"
                    ></i>
                    <span>
                        {{ playlist.is_private
                        ? t('user_pages.playlists.private')
                        : t('user_pages.playlists.public')
                        }}
                    </span>
                </span>
            </div>

            <!-- Slots papildu informācijai -->
            <slot name="extra-info"></slot>
        </div>

        <!-- Labais slots pielāgotām darbībām -->
        <slot name="actions"></slot>
    </div>
</template>

<style scoped>
.playlist-card {
    background: white;
    border-radius: 12px;
    overflow: visible;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.08);
    transition: all 0.3s ease;
    animation: fadeIn 0.4s ease-out;
    display: flex;
    flex-direction: column;
    height: 100%;
}

.playlist-card.clickable {
    cursor: pointer;
}

.playlist-card.clickable:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(12, 75, 170, 0.15);
}

@media (prefers-color-scheme: dark) {
    .playlist-card {
        background: #1f2937;
    }
}

.playlist-image-wrapper {
    position: relative;
    width: 100%;
    aspect-ratio: 1 / 1;
    margin-top: 7%;
}

.playlist-image-wrapper::before,
.playlist-image-wrapper::after {
    content: "";
    position: absolute;
    left: 0;
    width: 100%;
    height: 100%;
    border-radius: 10px;
    pointer-events: none;
}

.playlist-image-wrapper::before {
    top: -5%;
    transform: scale(0.96);
    background: rgba(0, 0, 0, 0.15);
    z-index: 0;
}

.playlist-image-wrapper::after {
    top: -9%;
    transform: scale(0.92);
    background: rgba(0, 0, 0, 0.08);
    z-index: 0;
}

.playlist-image {
    position: relative;
    z-index: 2;
    border-radius: 12px;
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.playlist-card.clickable:hover .playlist-image {
    transform: scale(1.01);
}

.tracks-count-badge {
    position: absolute;
    bottom: 8px;
    right: 8px;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(4px);
    color: white;
    padding: 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 0.35rem;
    border: 1px solid rgba(255, 255, 255, 0.2);
    z-index: 3;
}

.tracks-count-badge i {
    font-size: 0.7rem;
}

.playlist-info {
    padding: 1rem;
    flex: 1;
}

.playlist-name {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
    margin: 0 0 0.5rem 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

@media (prefers-color-scheme: dark) {
    .playlist-name {
        color: #f3f4f6;
    }
}

.playlist-meta {
    display: flex;
    align-items: center;
}

.privacy-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    padding: 0.25rem 0.6rem;
    border-radius: 16px;
    font-size: 0.75rem;
    font-weight: 500;
}

.privacy-badge i {
    font-size: 0.7rem;
}

.privacy-badge.public {
    background: rgba(34, 197, 94, 0.1);
    color: #16a34a;
    border: 1px solid rgba(34, 197, 94, 0.2);
}

.privacy-badge.private {
    background: rgba(239, 68, 68, 0.1);
    color: #dc2626;
    border: 1px solid rgba(239, 68, 68, 0.2);
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsivitāte */
@media (max-width: 640px) {
    .tracks-count-badge {
        padding: 0.25rem 0.6rem;
        font-size: 0.7rem;
    }

    .playlist-name {
        font-size: 0.95rem;
    }

    .privacy-badge {
        font-size: 0.7rem;
        padding: 0.2rem 0.5rem;
    }
}

</style>
