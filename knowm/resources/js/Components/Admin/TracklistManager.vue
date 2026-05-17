<script setup>
import { ref, watch, onMounted, onBeforeUnmount } from 'vue';
import axios from 'axios';
import debounce from 'lodash/debounce';
import { useDate } from '@/composables/useDate';
import { useI18n } from 'vue-i18n';
import {Link} from "@inertiajs/vue3";
import {route} from "ziggy-js";

const props = defineProps({
    release: {
        type: Object,
        required: true
    },
    searchRoute: {
        type: String,
        required: true
    },
    saveRoute: {
        type: String,
        required: true
    }
})

const { formatDuration } = useDate();
const { t } = useI18n();

const emit = defineEmits([
    'updated'
]);

const tracklist = ref(
    [...props.release.tracks]
        .sort((a, b) => a.track_position - b.track_position)
)

const trackSearch = ref('');
const trackResults = ref([]);

const searchingTracks = ref(false);
const savingTracklist = ref(false);

const trackSearchWrapper = ref(null);
const showTrackResults = ref(false);

const handleOutsideClick = (event) => {
    if (
        trackSearchWrapper.value &&
        !trackSearchWrapper.value.contains(event.target)
    ) {
        showTrackResults.value = false
    }
};

const handleTrackInputFocus = () => {
    if (
        trackResults.value.length > 0
    ) {
        showTrackResults.value = true
    }
};

const searchTracks = debounce(async () => {
    const query = trackSearch.value.trim()
    if (query.length < 2) {
        trackResults.value = []
        showTrackResults.value = false
        return
    }
    searchingTracks.value = true
    try {
        const response = await axios.get(props.searchRoute, {
            params: {
                q: query,
                // prioritize tracks by release artists
                release_artist_ids: props.release.artists.map(a => a.id)
            }
        })
        // exclude already attached tracks
        trackResults.value = response.data.filter(result =>
            !tracklist.value.some(
                track => track.id === result.id
            )
        )
        showTrackResults.value = trackResults.value.length > 0
    } catch (error) {
        console.error(error)
    } finally {
        searchingTracks.value = false
    }

}, 300)

watch(trackSearch, () => {
    searchTracks()
})

const addTrack = (track) => {
    tracklist.value.push({
        ...track,
        track_position:
            tracklist.value.length + 1
    })
    // clear search
    trackSearch.value = ''
    trackResults.value = []
    showTrackResults.value = false
}

const removeTrack = (trackId) => {
    tracklist.value =
        tracklist.value.filter(
            track => track.id !== trackId
        )
    reindexTrackPositions()
}

const moveTrackUp = (trackId) => {
    const index =
        tracklist.value.findIndex(
            track => track.id === trackId
        )
    if (index <= 0) return
    // swap tracks
    const temp =
        tracklist.value[index - 1]

    tracklist.value[index - 1] =
        tracklist.value[index]

    tracklist.value[index] = temp
    reindexTrackPositions()
}

const moveTrackDown = (trackId) => {
    const index =
        tracklist.value.findIndex(
            track => track.id === trackId
        )

    if (index === -1) return
    if (index >= tracklist.value.length - 1) return
    // swap tracks
    const temp =
        tracklist.value[index + 1]

    tracklist.value[index + 1] =
        tracklist.value[index]

    tracklist.value[index] = temp
    reindexTrackPositions()
}

const reindexTrackPositions = () => {
    tracklist.value =
        tracklist.value.map((track, index) => ({
            ...track,
            track_position: index + 1
        }))
}

const saveTracklist = async () => {
    savingTracklist.value = true
    try {
        const response = await axios.post(props.saveRoute, { tracks:
                    tracklist.value.map(track => ({
                        id: track.id,
                        track_position: track.track_position
                    }))
            }
        )

        emit('updated', tracklist.value)
        alert(response.data.message || t('adm_releases.edit.save_tracklist_success'))
    } catch (error) {
        console.error(error)
        alert(error.response?.data?.message || t('adm_releases.edit.save_tracklist_error'));
    } finally {
        savingTracklist.value = false
    }
}

onMounted(() => {
    document.addEventListener(
        'click',
        handleOutsideClick
    )
});

onBeforeUnmount(() => {
    document.removeEventListener(
        'click',
        handleOutsideClick
    )
});

// sync when parent changes
watch(
    () => props.release.tracks,
    (newTracks) => {
        tracklist.value = [...newTracks]
                            .sort((a, b) =>
                                    a.track_position - b.track_position
                            )
    }
)

</script>

<template>
    <div class="management-card">
        <!-- Header -->
        <div class="management-header">
            <div>
                <h3 class="management-title">
                    {{ t('adm_releases.edit.tracklist') }}
                </h3>

                <p class="management-subtitle">
                    {{ t('adm_releases.edit.tracklist_desc') }}
                </p>
            </div>

            <span class="management-count">
            {{ tracklist.length }}
        </span>
        </div>

        <!-- Search -->
        <div class="track-search-wrapper" ref="trackSearchWrapper">
            <input
                v-model="trackSearch"
                type="text"
                class="input-field"
                :placeholder="t('adm_releases.edit.search_tracks')"
                @focus="handleTrackInputFocus"
            />

            <!-- Dropdown -->
            <div
                v-if="showTrackResults && trackResults.length > 0"
                class="track-results-dropdown"
            >
                <button
                    v-for="track in trackResults"
                    :key="track.id"
                    type="button"
                    class="track-result-row"
                    @click="addTrack(track)"
                >
                    <!-- Left -->
                    <div class="track-result-left">
                        <div class="track-result-title">
                            {{ track.title }}
                        </div>

                        <div
                            class="track-result-artists"
                        >
                            {{ track.artists.map(a => a.name).join(', ') }}
                        </div>
                    </div>

                    <!-- Right -->
                    <div class="track-result-right">
                        {{ formatDuration(track.duration) }}
                    </div>
                </button>
            </div>
        </div>

        <!-- Tracklist -->
        <div
            v-if="tracklist.length"
            class="tracklist-wrapper"
        >
            <div
                v-for="track in tracklist"
                :key="track.id"
                class="tracklist-row"
            >
                <!-- Left -->
                <div class="tracklist-left">
                    <!-- Position -->
                    <div class="track-position">
                        {{ track.track_position }}
                    </div>

                    <!-- Info -->
                    <div class="track-main-info">
                        <Link :href="route('admin-tracks-edit', { id: track.id })" class="text-link">
                            <div class="track-title">
                                {{ track.title }}
                            </div>
                        </Link>

                        <div
                            v-if="track.artists?.length > 1"
                            class="track-artists"
                        >
                            <template
                                v-for="(artist, index) in track.artists"
                                :key="artist.id"
                            >
                                <Link
                                    :href="route('admin-artists-edit', { id: artist.id })"
                                    class="artist-link"
                                >
                                    {{ artist.name }}
                                </Link>

                                <span v-if="index < track.artists.length - 1">
                                    ,
                                </span>
                            </template>
                        </div>
                    </div>
                </div>

                <!-- Right -->
                <div class="tracklist-right">
                    <!-- Duration -->
                    <div class="track-duration">
                        {{ formatDuration(track.duration) }}
                    </div>

                    <!-- Actions -->
                    <div class="track-actions">
                        <button
                            type="button"
                            class="track-action-btn"
                            @click="moveTrackUp(track.id)"
                            :disabled="track.track_position === 1"
                        >
                            <i class="fa-solid fa-chevron-up"></i>
                        </button>

                        <button
                            type="button"
                            class="track-action-btn"
                            @click="moveTrackDown(track.id)"
                            :disabled="track.track_position === tracklist.length"
                        >
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>

                        <button
                            type="button"
                            class="track-action-btn remove-track-btn"
                            @click="removeTrack(track.id)"
                        >
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Empty -->
        <div
            v-else
            class="empty-tracklist"
        >
            {{ t('adm_releases.edit.no_tracks_added') }}
        </div>

        <!-- Save -->
        <div class="management-actions">
            <button
                type="button"
                class="btn-primary"
                @click="saveTracklist"
                :disabled="savingTracklist"
            >
                {{
                    savingTracklist
                        ? t('adm_releases.edit.saving')
                        : t('adm_releases.edit.save_tracklist')
                }}
            </button>
        </div>
    </div>

</template>

<style scoped>
.management-card {
    margin-top: 1.5rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    padding: 1rem;
    background: #ffffff;
}

.management-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1rem;
    gap: 1rem;
}

.management-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
}

.management-subtitle {
    font-size: 0.85rem;
    color: #6b7280;
    margin-top: 0.25rem;
}

.management-count {
    background: #e2e8f0;
    color: #334155;
    padding: 0.35rem 0.75rem;
    border-radius: 999px;
    font-size: 0.8rem;
    font-weight: 600;
}

.track-search-wrapper {
    position: relative;
    margin-bottom: 1.25rem;
}

.input-field,
select.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    transition: all 0.2s;
}

.input-field:focus,
select.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

.input-field.error,
select.input-field.error {
    border-color: #ef4444;
}

.track-results-dropdown {
    position: absolute;
    top: calc(100% + 0.5rem);
    left: 0;
    right: 0;
    max-height: 320px;
    overflow-y: auto;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    box-shadow: 0 12px 32px rgba(0,0,0,0.12);
    z-index: 40;
}

.track-result-row {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 0.9rem 1rem;
    background: transparent;
    border: none;
    cursor: pointer;
    transition: background 0.15s ease;
}

.track-result-row:hover {
    background: #f8fafc;
}

.track-result-left {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    min-width: 0;
}

.track-result-title {
    font-size: 0.95rem;
    font-weight: 600;
    color: #111827;
    text-align: left;
}

.track-result-artists {
    margin-top: 0.2rem;
    font-size: 0.8rem;
    color: #64748b;
    text-align: left;
}

.track-result-right {
    flex-shrink: 0;
    font-size: 0.82rem;
    font-weight: 600;
    color: #64748b;
}

.tracklist-wrapper {
    display: flex;
    flex-direction: column;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    overflow: hidden;
}

.tracklist-row {
    min-width: 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 1rem;
    background: white;
    border-bottom: 1px solid #f1f5f9;
    transition: background 0.15s ease;
}

.tracklist-row:last-child {
    border-bottom: none;
}

.tracklist-row:hover {
    background: #fafafa;
}

.tracklist-left {
    display: flex;
    align-items: center;
    gap: 1rem;
    min-width: 0;
}

.track-position {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    border-radius: 9999px;
    background: #f1f5f9;
    font-size: 0.82rem;
    font-weight: 700;
    color: #475569;
}

.track-main-info {
    flex: 1;
    min-width: 0;
}

.text-link {
    transition:
        color 0.2s ease,
        transform 0.2s ease,
        background-color 0.2s ease;
}

.text-link:hover {
    color: #2563eb;
    background-color: rgba(37, 99, 235, 0.08);
    text-decoration: underline;
}

.track-title {
    font-size: 0.95rem;
    font-weight: 600;
    color: #111827;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-artists {
    margin-top: 0.2rem;
    font-size: 0.8rem;
    color: #64748b;
    white-space: normal;
    overflow-wrap: anywhere;
    line-height: 1.35;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.artist-link {
    color: inherit;
    text-decoration: none;
    transition: color 0.2s ease;
}

.artist-link:hover {
    color: #2563eb;
    text-decoration: underline;
}

.tracklist-right {
    display: flex;
    align-items: center;
    gap: 1rem;
    flex-shrink: 0;
    margin-left: auto;
}

.track-duration {
    font-size: 0.85rem;
    font-weight: 600;
    color: #64748b;
}

.track-actions {
    display: flex;
    align-items: center;
    gap: 0.35rem;
}

.track-action-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: none;
    border-radius: 0.5rem;
    background: #f8fafc;
    color: #475569;
    cursor: pointer;
    transition:
        background 0.15s ease,
        color 0.15s ease,
        transform 0.15s ease;
}

.track-action-btn:hover:not(:disabled) {
    background: #e2e8f0;
    color: #111827;

    transform: translateY(-1px);
}

.track-action-btn:disabled {
    opacity: 0.35;
    cursor: not-allowed;
}

.remove-track-btn {
    width: 36px;
    height: 36px;
    border: none;
    border-radius: 999px;
    background: #fee2e2;
    color: #dc2626;
    cursor: pointer;
    transition: all 0.2s;
}

.remove-track-btn:hover {
    background: #fecaca;
}

.empty-tracklist {
    padding: 2rem;
    text-align: center;
    color: #64748b;
    font-size: 0.9rem;
    border: 1px dashed #d1d5db;
    border-radius: 0.75rem;
    background: #fafafa;
}

.management-actions {
    margin-top: 1rem;
    display: flex;
    justify-content: flex-end;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    border: none;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-primary:hover:not(:disabled) {
    background-color: #2563eb;
}

.btn-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

@media (max-width: 1100px) {
    .tracklist-row {
        align-items: flex-start;
    }

    .tracklist-right {
        flex-direction: column;
        align-items: flex-end;
        gap: 0.5rem;
    }

    .track-duration {
        font-size: 0.8rem;
    }
}

@media (max-width: 768px) {
    .tracklist-row {
        align-items: flex-start;
    }

    .tracklist-right {
        flex-direction: column;
        align-items: flex-end;
        gap: 0.75rem;
    }

    .track-title,
    .track-artists {
        max-width: 180px;
    }
}

</style>
