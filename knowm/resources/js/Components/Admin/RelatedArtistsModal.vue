<script setup>
import { ref, watch } from 'vue';
import axios from 'axios';
import debounce from 'lodash/debounce';
import { useI18n } from 'vue-i18n';
import {router} from "@inertiajs/vue3";
import {route} from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    visible: {
        type: Boolean,
        default: false
    },
    artists: {
        type: Array,
        required: true,
        default: () => []
    },
    // remote search mode
    remoteSearch: {
        type: Boolean,
        default: false
    },
    searchRoute: {
        type: String,
        default: null
    }
});

const emit = defineEmits([
    'close'
]);

const searchQuery = ref('');
const displayedArtists = ref([...props.artists]);
const searching = ref(false);

const close = () => {
    emit('close');
    searchQuery.value = '';
    displayedArtists.value = [...props.artists];
};

// local / remote search
watch(
    searchQuery,
    debounce(async (value) => {
        const query = value.trim();
        // local mode
        if (!props.remoteSearch) {
            if (!query) {
                displayedArtists.value = [...props.artists];
                return;
            }
            displayedArtists.value =
                props.artists.filter(artist =>
                    artist.name.toLowerCase().includes(
                        query.toLowerCase()
                    )
                );
            return;
        }

        // remote mode
        if (!query) {
            displayedArtists.value = [...props.artists];
            return;
        }
        searching.value = true;
        try {
            const response = await axios.get(
                props.searchRoute,{
                    params: {q: query}
                }
            );
            displayedArtists.value = response.data;
        } catch (error) {
            console.error(error);
        } finally {
            searching.value = false;
        }
    }, 300)
);

// sync artists from parent
watch(
    () => props.artists,
    (newArtists) => {
        displayedArtists.value = [...newArtists];
    }, {immediate: true}
);

const goToEdit = (id) => {
    router.get(route('admin-artists-edit', id));
};

</script>

<template>
    <Teleport to="body">
        <div
            v-if="visible"
            class="modal-overlay"
            @click.self="close"
        >
            <div class="related-artists-modal">
                <!-- Header -->
                <div class="modal-header">
                    <h2>
                        {{ t('adm_components.related_artists.title') }}
                    </h2>
                    <button class="modal-close" @click="close">
                        ×
                    </button>
                </div>

                <!-- Body -->
                <div class="modal-body">
                    <!-- Search -->
                    <div class="search-section">
                        <input
                            type="text"
                            v-model="searchQuery"
                            class="search-input"
                            :placeholder="t('adm_components.related_artists.search_placeholder')"
                        />
                    </div>

                    <!-- Artists list -->
                    <div class="artists-list">
                        <!-- Loading -->
                        <div v-if="searching" class="loading-state"
                        >
                            {{ t('adm_components.related_artists.searching') }}
                        </div>

                        <!-- Rows -->
                        <div
                            v-for="artist in displayedArtists"
                            :key="artist.id"
                            class="artist-row"
                            @click="goToEdit(artist.id)"
                        >
                            <!-- Left -->
                            <div class="artist-left">
                                <!-- Image -->
                                <img
                                    :src="artist.banner_url"
                                    :alt="artist.name"
                                    class="artist-image"
                                />
                                <!-- Info -->
                                <div class="artist-main-info">
                                    <div class="artist-name">
                                        {{ artist.name }}
                                    </div>
                                    <div class="artist-id">
                                        #{{ artist.id }}
                                    </div>
                                </div>
                            </div>

                            <!-- Right -->
                            <div class="artist-right">
                                <div class="artist-slug">
                                    {{ artist.slug }}
                                </div>
                                <div
                                    v-if="artist.formed_year"
                                    class="artist-formed-year"
                                >
                                    {{ artist.formed_year }}
                                </div>

                            </div>
                        </div>

                        <!-- Empty -->
                        <div v-if="!searching && displayedArtists.length === 0" class="empty-state">
                            {{ t('adm_components.related_artists.no_results') }}
                        </div>

                    </div>
                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <button
                        class="btn-secondary"
                        @click="close"
                    >
                        {{ t('adm_components.related_artists.close') }}
                    </button>
                </div>

            </div>
        </div>
    </Teleport>
</template>

<style scoped>
.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 2000;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    touch-action: none;
}

.related-artists-modal {
    background: white;
    width: 100%;
    max-width: 650px;
    border-radius: 1rem;
    box-shadow: 0 20px 35px rgba(0, 0, 0, 0.2);
    display: flex;
    flex-direction: column;
    max-height: 85vh;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.25rem 1.5rem;
    border-bottom: 1px solid #e5e7eb;
}

.modal-header h2 {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: #6b7280;
    line-height: 1;
}

.modal-close:hover {
    color: #374151;
}

.modal-body {
    padding: 1.5rem;
    overflow-y: auto;
    flex: 1;
}

.search-section {
    margin-bottom: 1.5rem;
}

.search-input {
    width: 100%;
    padding: 0.6rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    font-size: 0.9rem;
    transition: all 0.2s;
}

.search-input:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

.artists-list {
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    overflow-y: auto;
    max-height: 400px;
}

.loading-state {
    padding: 1rem;
    text-align: center;
    color: #64748b;
    font-size: 0.9rem;
}

.empty-state {
    padding: 2rem;
    text-align: center;
    color: #9ca3af;
    font-style: italic;
    font-size: 0.9rem;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
    padding: 1rem 1.5rem;
    border-top: 1px solid #e5e7eb;
    background: #fefefe;
    border-radius: 0 0 1rem 1rem;
}

.btn-secondary {
    background: white;
    border: 1px solid #d1d5db;
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-secondary:hover {
    background: #f3f4f6;
}

.artist-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1rem;
    padding: 0.85rem 1rem;
    border-bottom: 1px solid #f1f5f9;
    cursor: pointer;
    transition: background-color 0.2s;
}

.artist-row:hover {
    background-color: #f9fafb;
}

.artist-row:last-child {
    border-bottom: none;
}

.artist-left {
    display: flex;
    align-items: center;
    gap: 0.85rem;
    min-width: 0;
}

.artist-image {
    width: 56px;
    height: 56px;
    border-radius: 0.75rem;
    object-fit: cover;
    flex-shrink: 0;
}

.artist-main-info {
    min-width: 0;
}

.artist-name {
    font-size: 0.95rem;
    font-weight: 600;
    color: #111827;
}

.artist-id {
    margin-top: 0.2rem;
    font-size: 0.75rem;
    color: #94a3b8;
}

.artist-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 0.2rem;
    flex-shrink: 0;
}

.artist-slug {
    font-size: 0.82rem;
    color: #64748b;
}

.artist-formed-year {
    font-size: 0.78rem;
    color: #94a3b8;
}

.loading-state {
    padding: 1rem;
    text-align: center;
    color: #64748b;
    font-size: 0.9rem;
}

@media (max-width: 768px) {
    .artist-row {
        align-items: flex-start;
    }
    .artist-right {
        align-items: flex-end;
    }
}

@media (max-width: 640px) {
    .related-artists-modal {
        width: 95%;
        max-height: 90vh;
    }
    .modal-body {
        padding: 1rem;
    }
}

</style>
