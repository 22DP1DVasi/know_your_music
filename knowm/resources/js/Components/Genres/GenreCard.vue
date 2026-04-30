<script setup>
import { computed } from 'vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
    genre: {
        type: Object,
        required: true,
        validator: (value) => {
            return value.id && value.name && value.slug;
        }
    },
    // custom redirect URL or function
    redirectUrl: {
        type: [String, Function],
        default: null
    },
    // custom image URL (falls back to genre.banner_url)
    imageSrc: {
        type: String,
        default: null
    },
    // fallback image when genre image fails
    fallbackImage: {
        type: String,
        default: '/images/default-genre-banner.webp'
    }
});

const emit = defineEmits(['genre-click']);

const imageUrl = computed(() => {
    return props.imageSrc || props.genre.banner_url || props.fallbackImage;
});

const handleGenreClick = () => {
    emit('genre-click', props.genre);

    if (props.redirectUrl) {
        if (typeof props.redirectUrl === 'function') {
            props.redirectUrl(props.genre.slug);
        } else {
            router.get(props.redirectUrl);
        }
    } else {
        router.get(`/genres/${props.genre.slug}`);
    }
};

const handleImageError = (event) => {
    event.target.src = props.fallbackImage;
};

defineExpose({
    handleGenreClick
});

</script>

<template>
    <div class="genre-card" @click="handleGenreClick">
        <div class="image-wrapper">
            <img
                :src="imageUrl"
                :alt="genre.name"
                loading="lazy"
                @error="handleImageError"
            >
        </div>
        <div class="genre-info">
            <h3 :title="genre.name">{{ genre.name }}</h3>
        </div>
    </div>
</template>

<style scoped>
.genre-card {
    flex: 0 0 calc(25% - 1.125rem);
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(12, 75, 170, 0.08);
    transition: all 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
    display: flex;
    flex-direction: column;
    cursor: pointer;
    border: 1px solid rgba(12, 75, 170, 0.06);
}

.genre-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(12, 75, 170, 0.15);
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

.genre-card:hover .image-wrapper img {
    transform: scale(1.05);
}

.genre-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
    text-align: center;
    background: white;
}

.genre-info h3 {
    margin: 0;
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

/* Responsive breakpoints */
@media (max-width: 1024px) {
    .genre-card {
        flex: 0 0 calc(33.333% - 1rem);
    }
}

@media (max-width: 768px) {
    .genre-card {
        flex: 0 0 calc(50% - 0.75rem);
    }

    .genre-info {
        padding: 0.875rem;
    }

    .genre-info h3 {
        font-size: 0.95rem;
    }
}

@media (max-width: 480px) {
    .genre-card {
        flex: 0 0 100%;
        max-width: 280px;
        margin: 0 auto;
    }

    .genre-info {
        padding: 0.75rem;
    }
}

</style>
