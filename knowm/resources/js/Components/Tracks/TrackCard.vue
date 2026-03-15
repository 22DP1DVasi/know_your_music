<script setup>
import { computed, ref, onMounted, onUnmounted } from 'vue';
import { router } from '@inertiajs/vue3';
import { useDate } from '@/composables/useDate';

const props = defineProps({
    track: {
        type: Object,
        required: true,
        validator: (value) => {
            return value.id && value.title && value.slug;
        }
    },
    // attēlošanas opcijas
    index: {
        type: Number,
        default: null
    },
    showNumber: {
        type: Boolean,
        default: true
    },
    showImage: {
        type: Boolean,
        default: true
    },
    showDuration: {
        type: Boolean,
        default: true
    },
    showArtists: {
        type: Boolean,
        default: false
    },
    // vizuālie varianti
    compact: {
        type: Boolean,
        default: false
    },
    hoverable: {
        type: Boolean,
        default: true
    },
    // mijiedarbības iespējas
    clickable: {
        type: Boolean,
        default: true
    },
    // pielāgots novirzīšanas URL vai funkcija
    redirectUrl: {
        type: [String, Function],
        default: null
    },
    // pielāgots attēla URL (atkāpšanās uz track.cover_url)
    imageSrc: {
        type: String,
        default: null
    },
    // atkāpšanās attēls, ja neizdodas izsekot attēlu
    fallbackImage: {
        type: String,
        default: '/images/default-release-banner.webp'
    },
    // konteksta izvēlnes opcijas
    showContextMenu: {
        type: Boolean,
        default: true
    },
    canAdd: {
        type: Boolean,
        default: true
    },
    canRemove: {
        type: Boolean,
        default: false
    },
    menuOpen: {
        type: Boolean,
        default: false
    },
    durationFormat: {
        type: String,
        default: ''
    }
});

const { formatDuration } = useDate();
// definē emitu: saņēm funkciju/vērtību no vecākkomponenta un izmanto šajā
const emit = defineEmits([
    'track-click',
    'add-to-playlist',
    'remove',
    'toggle-menu'
]);
const menuContainer = ref(null);

// computed rekvizīti
const displayIndex = computed(() => {
    if (props.index === null) return '';
    return props.index + 1;
});

const imageUrl = computed(() => {
    return props.imageSrc || props.track.cover_url || props.fallbackImage;
});

const formattedDuration = computed(() => {
    return formatDuration(props.track.duration, props.durationFormat);
});

const formattedArtists = computed(() => {
    if (!props.track.artists || !Array.isArray(props.track.artists)) return '';
    return props.track.artists.map(artist => artist.name).join(', ');
});

const handleTrackClick = () => {
    if (!props.clickable) return;
    emit('track-click', props.track);
    if (props.redirectUrl) {
        if (typeof props.redirectUrl === 'function') {
            props.redirectUrl(props.track.slug);
        } else {
            router.get(props.redirectUrl);
        }
    } else {
        router.get(`/tracks/${props.track.slug}`);
    }
};

const handleImageError = (event) => {
    event.target.src = props.fallbackImage;
};

const redirectToArtist = (slug, event) => {
    event.stopPropagation(); // novērst dziesmas kartes klikšķa palaidi
    router.get(`/artists/${slug}`);
};

// konteksta izvēlnes apstrādātāji
const toggleMenu = () => {
    emit('toggle-menu', props.track.id);
};

const closeMenu = () => {
    emit('toggle-menu', null);
};

const handleClickOutside = (event) => {
    if (
        props.menuOpen &&
        menuContainer.value &&
        !menuContainer.value.contains(event.target)
    ) {
        emit('toggle-menu', null);
    }
};

const handleAddToPlaylist = () => {
    console.log('Add to playlist:', props.track.title);
    // emit/izsūtīt notikumu vecākkomponentam apstrādei
    emit('add-to-playlist', props.track);
    closeMenu();
};

const handleRemove = () => {
    console.log('Remove:', props.track.title);
    // emit/izsūtīt notikumu vecākkomponentam apstrādei
    emit('remove', props.track);
    closeMenu();
};

// aizvērt izvēlni, noklikšķinot ārpusē
onMounted(() => {
    document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
    document.removeEventListener('click', handleClickOutside);
});

defineExpose({
    handleTrackClick
});

</script>

<template>
    <div class="track-card" :class="{ 'compact': compact, 'no-hover': !hoverable }">
        <span v-if="showNumber" class="track-number">
            {{ displayIndex }}
        </span>

        <!-- Izsekot attēlu ar klikšķa apstrādātāju -->
        <a
            v-if="showImage"
            @click="handleTrackClick"
            class="track-image-btn"
            :class="{ 'clickable': clickable }"
        >
            <img
                :src="imageUrl"
                class="track-image"
                :alt="track.title"
                loading="lazy"
                @error="handleImageError"
            >
        </a>

        <!-- Informācija par dziesmu -->
        <div class="track-info">
            <h3>
                <a
                    @click="handleTrackClick"
                    class="track-title"
                    :class="{ 'clickable': clickable }"
                >
                    {{ track.title }}
                </a>
            </h3>

            <!-- Izpildītāju slots vairāku izpildītāju izcelšanai -->
            <slot name="artists">
                <div v-if="showArtists && track.artists && track.artists.length" class="track-artists">
                    <span
                        v-for="(artist, artistIndex) in track.artists"
                        :key="artist.id"
                        class="artist-link-wrapper"
                    >
                        <a
                            @click="redirectToArtist(artist.slug, $event)"
                            class="artist-link"
                        >
                            {{ artist.name }}
                        </a>
                        <span v-if="artistIndex < track.artists.length - 1" class="artist-separator">, </span>
                    </span>
                </div>
            </slot>

            <!-- Papildu informācijas slots (like album name, etc.) -->
            <slot name="extra-info"></slot>
        </div>

        <!-- Ilgums -->
        <div v-if="showDuration" class="track-duration">
            {{ formattedDuration }}
        </div>

        <!-- Konteksta izvēlne -->
        <div v-if="showContextMenu" class="context-menu-container" ref="menuContainer">
            <button
                class="context-menu-button"
                @click.stop="toggleMenu"
                aria-label="Track actions"
            >
                <i class="fa-solid fa-ellipsis-vertical"></i>
            </button>

            <div v-if="menuOpen" class="context-dropdown">
                <button
                    v-if="canAdd"
                    class="context-menu-item"
                    @click="handleAddToPlaylist"
                >
                    <i class="fa-regular fa-plus"></i>
                    Add to playlist
                </button>
                <button
                    v-if="canRemove"
                    class="context-menu-item"
                    @click="handleRemove"
                >
                    <i class="fa-regular fa-trash-can"></i>
                    Remove
                </button>
            </div>
        </div>

        <!-- Labais slots pielāgotām darbībām -->
        <slot name="actions"></slot>
    </div>
</template>

<style scoped>
.track-card {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
    gap: 0.75rem;
    transition: background-color 0.2s ease;
}

.track-card.hoverable:hover {
    background-color: #f9f9f9;
}

.track-card.compact {
    padding: 0.5rem 0.75rem;
    gap: 0.5rem;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .track-card {
        padding: 0.75rem;
        gap: 0.75rem;
    }
}

@media (max-width: 480px) {
    .track-card {
        padding: 0.5rem;
        gap: 0.5rem;
    }
}

.track-number {
    color: #666;
    width: 24px;
    text-align: center;
    font-size: 0.9rem;
    flex-shrink: 0;
}

@media (max-width: 480px) {
    .track-number {
        width: 20px;
        font-size: 0.85rem;
    }
}

.track-image-btn {
    cursor: pointer;
    transition: all 0.2s ease;
    display: block;
    line-height: 0;
    flex-shrink: 0;
}

.track-image-btn.clickable:hover {
    transform: translateY(-2px);
    opacity: 0.9;
}

.track-image {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    object-fit: cover;
    flex-shrink: 0;
    display: block;
}

@media (max-width: 768px) {
    .track-image {
        width: 45px;
        height: 45px;
    }
}

@media (max-width: 480px) {
    .track-image {
        width: 40px;
        height: 40px;
    }
}

.track-info {
    flex: 1;
    min-width: 0;
}

.track-info h3 {
    margin: 0;
    line-height: 1.4;
}

.track-title {
    font-size: clamp(9px, 3vw, 1rem);
    cursor: pointer;
    color: inherit;
    text-decoration: none;
    transition: color 0.2s ease;
    display: inline-block;
}

.track-title.clickable:hover {
    color: #0c4baa;
    text-decoration: underline;
}

.track-artists {
    margin: 0.25rem 0 0;
    font-size: 0.85rem;
    color: #666;
    line-height: 1.5;
    word-break: break-word;
}

.artist-link-wrapper {
    display: inline;
}

.artist-link {
    color: #666;
    text-decoration: none;
    cursor: pointer;
    transition: color 0.2s ease;
    display: inline;
    font-size: clamp(9px, 3vw, 1rem);
}

.artist-link:hover {
    color: #0c4baa;
    text-decoration: underline;
}

.artist-separator {
    color: #666;
    white-space: pre;
}

.track-duration {
    color: #666;
    font-size: 0.9rem;
    flex: 0 0 50px;
    text-align: right;
    white-space: nowrap;
    font-feature-settings: "tnum";
}

@media (max-width: 768px) {
    .track-duration {
        flex: 0 0 50px;
    }
}

@media (max-width: 480px) {
    .track-duration {
        font-size: 0.85rem;
        flex: 0 0 45px;
    }
}

.context-menu-container {
    position: relative;
    display: flex;
    align-items: center;
    margin-left: 0.5rem;
}

.context-menu-button {
    background: none;
    border: none;
    color: #999;
    font-size: 1.2rem;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
}

.context-menu-button:hover {
    background-color: #f0f0f0;
    color: #0c4baa;
}

.context-dropdown {
    position: absolute;
    top: 100%;
    right: 0;
    margin-top: 0.25rem;
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    min-width: 160px;
    z-index: 10;
    overflow: hidden;
    animation: fadeIn 0.2s ease;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.context-menu-item {
    width: 100%;
    padding: 0.75rem 1rem;
    border: none;
    background: none;
    text-align: left;
    font-size: 0.9rem;
    color: #333;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.75rem;
    transition: background-color 0.2s ease;
}

.context-menu-item i {
    width: 16px;
    color: #666;
    font-size: 0.9rem;
}

.context-menu-item:hover {
    background-color: #f5f5f5;
    color: #0c4baa;
}

.context-menu-item:hover i {
    color: #0c4baa;
}

@media (max-width: 768px) {
    .context-menu-button {
        font-size: 1.1rem;
        width: 28px;
        height: 28px;
    }

    .context-dropdown {
        min-width: 140px;
    }

    .context-menu-item {
        padding: 0.6rem 0.75rem;
        font-size: 0.85rem;
    }
}

</style>
