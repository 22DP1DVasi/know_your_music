<script setup>
import { router } from '@inertiajs/vue3';
import { computed } from "vue";

const props = defineProps({
    artist: {
        type: Object,
        required: true,
        validator: (value) => {
            return value.id && value.name && value.slug;
        }
    },
    // atļaut novirzīšanas uzvedības pielāgošanu, noklusējums - standarta novirzīšana
    redirectTo: {
        type: Function,
        default: (slug) => router.get(`/artists/${slug}`)
    },
    // visticamāk būs nomainīts uz popularitātes vērtību vai vispār noņemts
    showTrackCount: {
        type: Boolean,
        default: true
    },
    // pielāgots ierakstu skaita teksta formatētājs
    trackCountText: {
        type: Function,
        default: (count) => `${count} ${count === 1 ? 'track' : 'tracks'}`
    },
    // papildu wrapper klase
    wrapperClass: {
        type: String,
        default: ''
    }
});

const handleClick = () => {
    props.redirectTo(props.artist.slug);
};

const imageUrl = computed(() => {
    return props.artist.banner_url || props.artist.profile_url || props.artist.image_url || '/default-artist.jpg';
});

</script>

<template>
    <div
        class="artist-card"
        :class="wrapperClass"
        @click="handleClick"
        role="button"
        tabindex="0"
        @keydown.enter="handleClick"
        @keydown.space.prevent="handleClick"
    >
        <div class="image-wrapper">
            <img
                :src="imageUrl"
                :alt="artist.name"
                loading="lazy"
            >
        </div>
        <div class="artist-info">
            <h3 :title="artist.name">{{ artist.name }}</h3>
            <p v-if="showTrackCount && artist.tracks_count !== undefined">
                {{ trackCountText(artist.tracks_count) }}
            </p>
        </div>
    </div>
</template>

<style scoped>
.artist-card {
    flex: 0 0 calc(25% - 1.125rem); /* 4 kartītes rindā */
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    cursor: pointer;
    outline: none; /* noņemt noklusējuma fokusa kontūru */
}

.artist-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.artist-card:focus-visible {
    outline: 2px solid #0c4baa;
    outline-offset: 2px;
    transform: translateY(-2px);
}

.artist-card .image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.artist-card .image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.artist-card:hover .image-wrapper img {
    transform: scale(1.05);
}

.artist-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
}

/* maks. divas rindas nosaukumam/virsrakstam, ja pārpildes - daudzpunkte */
.artist-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: 1.4;
}

.artist-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
}

/* Responsivitāte */
@media (max-width: 1024px) {
    .artist-card {
        flex: 0 0 calc(33.333% - 1rem); /* 3 kartītes rindā */
    }
}

@media (max-width: 768px) {
    .artist-card {
        flex: 0 0 calc(50% - 0.75rem); /* 2 kartītes rindā */
    }

    .artist-info {
        padding: 0.875rem;
    }

    .artist-info h3 {
        font-size: 1rem;
    }

    .artist-info p {
        font-size: 0.9rem;
    }
}

@media (max-width: 480px) {
    .artist-card {
        flex: 0 0 100%; /* 1 kartīte rindā */
        max-width: 300px;
        margin: 0 auto;
    }

    .artist-info {
        padding: 0.75rem;
    }
}

/* Animācijas */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.artist-card {
    animation: fadeInUp 0.5s ease forwards;
}

</style>
