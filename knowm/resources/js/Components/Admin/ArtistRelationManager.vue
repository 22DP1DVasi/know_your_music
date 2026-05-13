<script setup>
import { ref, watch } from 'vue'
import axios from 'axios'
import debounce from 'lodash/debounce'
import { useI18n } from 'vue-i18n';

const props = defineProps({
    title: {
        type: String,
        default: 'Artists'
    },

    subtitle: {
        type: String,
        default: ''
    },

    initialArtists: {
        type: Array,
        default: () => []
    },

    searchRoute: {
        type: String,
        required: true
    },

    searchPlaceholder: {
        type: String,
        default: 'Search artists...'
    },

    saveButtonText: {
        type: String,
        default: 'Save'
    }
})

const { t } = useI18n();

const emit = defineEmits([
    'update'
])

const relatedArtists = ref([...props.initialArtists])

const artistSearch = ref('')
const artistResults = ref([])
const artistSearchLoading = ref(false)

const searchArtists = debounce(async () => {
    const query = artistSearch.value.trim()
    if (query.length < 2) {
        artistResults.value = []
        return
    }
    artistSearchLoading.value = true
    try {
        const response = await axios.get(props.searchRoute, {
            params: {
                q: query
            }
        })
        artistResults.value = response.data.filter(result =>
            !relatedArtists.value.some(
                artist => artist.id === result.id
            )
        )
    } catch (error) {
        console.error(error)
    } finally {
        artistSearchLoading.value = false
    }
}, 300)

watch(artistSearch, () => {
    searchArtists()
})

const addArtist = (artist) => {
    relatedArtists.value.push(artist)
    artistSearch.value = ''
    artistResults.value = []
}

const removeArtist = (artistId) => {
    relatedArtists.value =
        relatedArtists.value.filter(
            artist => artist.id !== artistId
        )
}

const emitUpdate = () => {
    emit('update', relatedArtists.value)
}

watch(
    () => props.initialArtists,
    (newArtists) => {
        relatedArtists.value = [...newArtists]
    }
)

</script>

<template>
    <div class="management-card">
        <div class="management-header">
            <div>
                <h3 class="management-title">
                    {{ t('adm_releases.edit.release_artists') }}
                </h3>
                <p class="management-subtitle">
                    {{ t('adm_releases.edit.release_artists_desc') }}
                </p>
            </div>

            <span class="management-count">
                                        {{ relatedArtists.length }}
                                    </span>
        </div>

        <!-- Search -->
        <div class="artist-search-wrapper">
            <input
                v-model="artistSearch"
                type="text"
                class="input-field"
                :placeholder="t('adm_releases.edit.search_artists')"
            />

            <!-- Dropdown -->
            <div
                v-if="artistResults.length > 0"
                class="artist-results-dropdown"
            >
                <button
                    v-for="artist in artistResults"
                    :key="artist.id"
                    type="button"
                    class="artist-result-row"
                    @click="addArtist(artist)"
                >
                    <img
                        :src="artist.banner_url"
                        :alt="artist.name"
                        class="artist-result-image"
                    />

                    <div class="artist-result-content">
                        <div class="artist-result-top">
                            <span class="artist-name">
                                {{ artist.name }}
                            </span>
                            <span class="artist-slug">
                                {{ artist.slug }}
                            </span>
                            <span class="artist-formed-year">
                                {{ artist.formed_year }}
                            </span>
                            <span class="artist-genre">
                                {{ artist.first_genre_name }}
                            </span>
                        </div>

                        <div class="artist-meta">
                            #{{ artist.id }}
                        </div>
                    </div>
                </button>
            </div>
        </div>

        <!-- Attached artists -->
        <div
            v-if="relatedArtists.length"
            class="attached-artists"
        >
            <div
                v-for="artist in relatedArtists"
                :key="artist.id"
                class="attached-artist-row"
            >
                <div class="attached-artist-left">
                    <img
                        :src="artist.banner_url"
                        :alt="artist.name"
                        class="attached-artist-image"
                    />

                    <div class="attached-artist-info">
                        <div class="attached-artist-name">
                            {{ artist.name }}
                        </div>

                        <div class="attached-artist-slug">
                            {{ artist.slug }}
                        </div>
                    </div>
                </div>

                <button
                    type="button"
                    class="remove-artist-btn"
                    @click="removeArtist(artist.id)"
                >
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
        </div>

        <!-- Save -->
        <div class="management-actions">
            <button
                type="button"
                class="btn-primary"
                @click="emitUpdate"
            >
                {{ t('adm_releases.edit.save_artists') }}
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
    font-size: 1rem;
    font-weight: 600;
    color: #111827;
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

.artist-search-wrapper {
    position: relative;
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

.artist-results-dropdown {
    position: absolute;
    top: calc(100% + 0.5rem);
    left: 0;
    right: 0;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    max-height: 320px;
    overflow-y: auto;
    z-index: 50;
}

.artist-result-row {
    width: 100%;
    display: flex;
    gap: 0.75rem;
    padding: 0.75rem;
    background: transparent;
    border: none;
    cursor: pointer;
    transition: background 0.2s;
}

.artist-result-row:hover {
    background: #f8fafc;
}

.artist-result-image {
    width: 52px;
    height: 52px;
    border-radius: 0.5rem;
    object-fit: cover;
}

.artist-result-content {
    flex: 1;
    min-width: 0;
}

.artist-result-top {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem 1rem;
}

.artist-name {
    font-weight: 600;
    color: #111827;
}

.artist-slug {
    color: #64748b;
    font-size: 0.8rem;
}

.artist-formed-year {
    color: #64748b;
    font-size: 0.8rem;
}

.artist-genre {
    color: #64748b;
    font-size: 0.8rem;
}

.artist-meta {
    display: flex;
    justify-content: flex-start;
    margin-top: 0.25rem;
    font-size: 0.75rem;
    color: #9ca3af;
}

.attached-artists {
    margin-top: 1rem;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.attached-artist-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    background: #f8fafc;
}

.attached-artist-left {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.attached-artist-image {
    width: 52px;
    height: 52px;
    border-radius: 0.5rem;
    object-fit: cover;
}

.attached-artist-info {
    display: flex;
    flex-direction: column;
}

.attached-artist-name {
    font-weight: 600;
    color: #111827;
}

.attached-artist-slug {
    font-size: 0.8rem;
    color: #64748b;
}

.remove-artist-btn {
    width: 36px;
    height: 36px;
    border: none;
    border-radius: 999px;
    background: #fee2e2;
    color: #dc2626;
    cursor: pointer;
    transition: all 0.2s;
}

.remove-artist-btn:hover {
    background: #fecaca;
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

</style>
