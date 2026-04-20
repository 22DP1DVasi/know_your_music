<script setup>
import { computed } from 'vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
    release: {
        type: Object,
        required: true,
        validator: (value) => {
            return value.id && value.title && value.slug;
        }
    },
    // pielāgota novirzīšanas URL vai funkcija
    redirectUrl: {
        type: [String, Function],
        default: null
    },
    // pielāgota attēla URL (atkāpšanās pie release.cover_url)
    imageSrc: {
        type: String,
        default: null
    },
    fallbackImage: {
        type: String,
        default: '/images/default-release-banner.webp'
    },
    // vai radīt izpildītājus
    showArtists: {
        type: Boolean,
        default: true
    },
    // maksimālais izpildītāju skaits, kas jārāda pirms apciršanas
    maxArtists: {
        type: Number,
        default: 3
    },
    // vai rādīt dziesmu skaitu
    showTrackCount: {
        type: Boolean,
        default: true
    },
    // vai rādīt albuma tipu
    showReleaseType: {
        type: Boolean,
        default: true
    }
});

const emit = defineEmits(['release-click']);

// computed rekvizīti
const imageUrl = computed(() => {
    return props.imageSrc || props.release.cover_url || props.fallbackImage;
});

const formattedArtists = computed(() => {
    if (!props.release.artists || !Array.isArray(props.release.artists)) {
        return '';
    }
    return props.release.artists.map(artist => artist.name).join(', ');
});

const truncatedArtists = computed(() => {
    if (!props.release.artists || !Array.isArray(props.release.artists)) {
        return '';
    }
    const artistNames = props.release.artists.map(artist => artist.name);
    if (artistNames.length <= props.maxArtists) {
        return artistNames.join(', ');
    }
    const visibleArtists = artistNames.slice(0, props.maxArtists);
    const remainingCount = artistNames.length - props.maxArtists;
    return `${visibleArtists.join(', ')} +${remainingCount}`;
});

// const formattedTrackCount = computed(() => {
//     if (!props.showTrackCount) return '';
//     const count = props.release.tracks_count || 0;
//     return `${count} ${count === 1 ? 'track' : 'tracks'}`;
// });

const formattedReleaseType = computed(() => {
    if (!props.showReleaseType) return '';
    const type = props.release.release_type || props.release.type || 'Album';
    return type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();
});

const handleReleaseClick = () => {
    emit('release-click', props.release);

    if (props.redirectUrl) {
        if (typeof props.redirectUrl === 'function') {
            props.redirectUrl(props.release.slug);
        } else {
            router.get(props.redirectUrl);
        }
    } else {
        router.get(`/releases/${props.release.slug}`);
    }
};

const handleImageError = (event) => {
    event.target.src = props.fallbackImage;
};

defineExpose({
    handleReleaseClick
});

</script>

<template>
    <div class="release-card" @click="handleReleaseClick">
        <div class="image-wrapper">
            <img
                :src="imageUrl"
                :alt="release.title"
                loading="lazy"
                @error="handleImageError"
            >
        </div>
        <div class="release-info">
            <h3 class="release-title" :title="release.title">{{ release.title }}</h3>

            <div v-if="showArtists && release.artists && release.artists.length > 0" class="artists-container">
                <span class="artists-names" :title="formattedArtists">
                    {{ truncatedArtists }}
                </span>
            </div>

            <p class="release-meta">
                {{ release.release_date ? release.release_date.substring(0, 4) : '----' }} • {{ formattedReleaseType }}
            </p>

            <!-- Papildu informācijas slots -->
            <slot name="extra-info"></slot>
        </div>
    </div>
</template>

<style scoped>
.release-card {
    flex: 0 0 calc(25% - 1.125rem);
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow:
        0 10px 25px rgba(12, 75, 170, 0.15),
        0 4px 10px rgba(12, 75, 170, 0.08);
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
    display: flex;
    flex-direction: column;
    border: 1px solid rgba(12, 75, 170, 0.06);
}

.release-card:hover {
    transform: translateY(-6px);
    box-shadow:
        0 18px 40px rgba(12, 75, 170, 0.25),
        0 8px 16px rgba(12, 75, 170, 0.12);
    border-color: rgba(12, 75, 170, 0.12);
}

.image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: linear-gradient(135deg, #f8fafc, #f1f5f9);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    position: relative;
}

.image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.release-card:hover .image-wrapper img {
    transform: scale(1.05);
}

.release-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
    background: white;
}

.release-title {
    margin: 0 0 0.5rem 0;
    font-size: 1rem;
    font-weight: 600;
    color: #1e293b;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: 1.4;
}

.artists-container {
    margin: 0 0 0.5rem 0;
    font-size: 0.85rem;
    line-height: 1.4;
    display: flex;
    align-items: baseline;
    flex-wrap: wrap;
    gap: 0.25rem;
}

.artists-names {
    color: #475569;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    flex: 1;
    min-width: 0;
}

.release-meta {
    margin: 0;
    color: #94a3b8;
    font-size: 0.8rem;
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

/* Responsivitāte */
@media (max-width: 1024px) {
    .release-card {
        flex: 0 0 calc(33.333% - 1rem);
    }
}

@media (max-width: 768px) {
    .release-card {
        flex: 0 0 calc(50% - 0.75rem);
    }

    .release-info {
        padding: 0.875rem;
    }

    .release-title {
        font-size: 0.95rem;
    }

    .artists-container {
        font-size: 0.8rem;
    }

    .release-meta {
        font-size: 0.75rem;
    }
}

@media (max-width: 480px) {
    .release-card {
        flex: 0 0 100%;
        max-width: 280px;
        margin: 0 auto;
    }

    .release-info {
        padding: 0.75rem;
    }
}

</style>
