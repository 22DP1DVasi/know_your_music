<script setup>
import { router } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';

const props = defineProps({
    artist: {
        type: Object,
        required: true,
        validator: (value) => value.id && value.name && value.slug
    },
    redirectUrl: {
        type: [String, Function],
        default: null
    },
    clickable: {
        type: Boolean,
        default: true
    },
    showRole: {
        type: Boolean,
        default: false
    }
});

const { t } = useI18n();

const emit = defineEmits(['click']);

const handleClick = () => {
    if (!props.clickable) return;
    emit('click', props.artist);
    if (props.redirectUrl) {
        if (typeof props.redirectUrl === 'function') {
            props.redirectUrl(props.artist.slug);
        } else {
            router.get(props.redirectUrl);
        }
    } else {
        router.get(`/artists/${props.artist.slug}`);
    }
};

</script>

<template>
    <div class="artist-card" :class="{ 'clickable': clickable }" @click="handleClick">
        <img
            :src="artist.banner_url"
            class="artist-image"
            :alt="artist.name"
            loading="lazy"
            @error="(e) => e.target.src = '/images/default-artist-banner.webp'"
        />
        <div class="artist-info">
            <h3>{{ artist.name }}</h3>
            <p v-if="showRole && artist.pivot.role" class="artist-role">{{ t(`artists.global.${artist.pivot.role}`) }}</p>
        </div>
    </div>
</template>

<style scoped>
.artist-card {
    width: 150px;
    flex-shrink: 0;
    transition: transform 0.3s ease;
}

.artist-card.clickable {
    cursor: pointer;
}

.artist-card.clickable:hover {
    transform: translateY(-5px);
}

.artist-image {
    width: 100%;
    aspect-ratio: 1 / 1;
    object-fit: cover;
    border-radius: 50%;
    margin-bottom: 0.5rem;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.artist-info h3 {
    text-align: center;
    font-size: 1rem;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.artist-role {
    text-align: center;
    font-size: 0.75rem;
    color: #0c4baa;
    margin: 0.25rem 0 0;
    text-transform: capitalize;
    font-weight: 500;
}

/* Responsive design */
@media (max-width: 768px) {
    .artist-card {
        width: 120px;
    }

    .artist-info h3 {
        font-size: 0.9rem;
    }

    .artist-role {
        font-size: 0.7rem;
    }
}

@media (max-width: 480px) {
    .artist-card {
        width: 100px;
    }

    .artist-info h3 {
        font-size: 0.8rem;
    }

    .artist-role {
        font-size: 0.65rem;
    }
}

</style>
