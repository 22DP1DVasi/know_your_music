<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { router } from '@inertiajs/vue3';
import {route} from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    release: {
        type: Object,
        required: true,
        validator: (value) => value.id && value.title
    },
});

const artistNames = computed(() => {
    if (!props.release.artists || props.release.artists.length === 0) return '';
    return props.release.artists.map(artist => artist.name).join(', ');
});

const formattedDate = computed(() => {
    if (!props.release.release_date) return '';
    return new Date(props.release.release_date).getFullYear();
});

const artistRole = computed(() => {
    if (props.release.role) {
        return props.release.role;
    }
    return null;
});

const goToEdit = () => {
    router.get(route('admin-releases-edit', props.release.id));
};

</script>

<template>
    <div class="release-row" @click="goToEdit">
        <div class="release-cover">
            <img :src="release.cover_url" :alt="release.title" />
        </div>
        <div class="release-info">
            <div class="release-main">
                <span class="release-title">{{ release.title }}</span>
                <span class="release-badge">{{ t(`releases.type.${release.release_type || 'unknown'}`) }}</span>
            </div>
            <div class="release-details">
                <span class="release-artists">
                    {{ artistNames }}
                </span>
                <span class="release-date">{{ formattedDate }}</span>
                <span v-if="artistRole" class="release-role">
                    <span class="role-label">•</span>
                    {{ t(`artists.global.${artistRole}`) }}
                </span>
            </div>
        </div>
    </div>
</template>

<style scoped>
.release-row {
    display: flex;
    gap: 1rem;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #f3f4f6;
    cursor: pointer;
    transition: background-color 0.2s;
}

.release-row:hover {
    background-color: #f9fafb;
}

.release-cover {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    border-radius: 6px;
    overflow: hidden;
    background-color: #f3f4f6;
}

.release-cover img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.release-info {
    flex: 1;
    min-width: 0;
}

.release-main {
    display: flex;
    align-items: baseline;
    gap: 0.5rem;
    flex-wrap: wrap;
    margin-bottom: 0.25rem;
}

.release-title {
    font-weight: 600;
    font-size: 0.95rem;
    color: #1f2937;
}

.release-badge {
    font-size: 0.7rem;
    background: #e5e7eb;
    padding: 0.2rem 0.5rem;
    border-radius: 9999px;
    color: #4b5563;
    text-transform: uppercase;
}

.release-details {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    font-size: 0.8rem;
    color: #6b7280;
}

.release-artists {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.release-role {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
}

.role-label {
    color: #9ca3af;
}

</style>
