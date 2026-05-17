<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { router } from '@inertiajs/vue3';
import {route} from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    track: {
        type: Object,
        required: true,
        validator: (value) => value.id && value.title
    }
});

const artistNames = computed(() => {
    if (!props.track.artists || props.track.artists.length === 0) return '';
    return props.track.artists.map(artist => artist.name).join(', ');
});

const releaseYear = computed(() => {
    if (!props.track.release_date) return '';
    return new Date(props.track.release_date).getFullYear();
});

const goToEdit = () => {
    router.get(route('admin-tracks-edit', props.track.id));
};

</script>

<template>
    <div class="track-row" @click="goToEdit">
        <div class="track-cover">
            <img :src="track.cover_url" :alt="track.title" />
        </div>
        <div class="track-info">
            <div class="track-main">
                <span class="track-title">{{ track.title }}</span>
            </div>
            <div class="track-details">
                <span class="track-artists">{{ artistNames }}</span>
                <span class="role-label">•</span>
                <span class="track-year">{{ releaseYear }}</span>
                <span v-if="track.role" class="track-role">
                    <span class="role-label">•</span>
                    {{ t(`artists.global.${track.role}`) }}
                </span>
            </div>
        </div>
    </div>
</template>

<style scoped>
.track-row {
    display: flex;
    gap: 1rem;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #f3f4f6;
    cursor: pointer;
    transition: background-color 0.2s;
}

.track-row:hover {
    background-color: #f9fafb;
}

.track-cover {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    border-radius: 6px;
    overflow: hidden;
    background-color: #f3f4f6;
}

.track-cover img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.track-info {
    flex: 1;
    min-width: 0;
}

.track-main {
    display: flex;
    align-items: baseline;
    gap: 0.5rem;
    flex-wrap: wrap;
    margin-bottom: 0.25rem;
}

.track-title {
    font-weight: 600;
    font-size: 0.95rem;
    color: #1f2937;
}

.track-details {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    font-size: 0.8rem;
    color: #6b7280;
}

.track-artists {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-role {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
}

.role-label {
    color: #9ca3af;
}

</style>
