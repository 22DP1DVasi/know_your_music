<script setup>
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';
import TrackRelationRow from './TrackRelationRow.vue';

const { t } = useI18n();

const props = defineProps({
    visible: {
        type: Boolean,
        default: false
    },
    tracks: {
        type: Array,
        required: true,
        default: () => []
    }
});

const emit = defineEmits(['close']);

const searchQuery = ref('');

const filteredTracks = computed(() => {
    if (!searchQuery.value.trim()) {
        return props.tracks;
    }
    const query = searchQuery.value.toLowerCase().trim();
    return props.tracks.filter(track =>
        track.title.toLowerCase().includes(query)
    );
});

const close = () => {
    emit('close');
    searchQuery.value = '';
};

</script>

<template>
    <Teleport to="body">
        <div v-if="visible" class="modal-overlay" @click.self="close">
            <div class="related-tracks-modal">
                <!-- Header -->
                <div class="modal-header">
                    <h2>{{ t('adm_components.related_tracks.title') }}</h2>
                    <button class="modal-close" @click="close">×</button>
                </div>

                <!-- Body -->
                <div class="modal-body">
                    <!-- Search input -->
                    <div class="search-section">
                        <input
                            type="text"
                            v-model="searchQuery"
                            class="search-input"
                            :placeholder="t('adm_components.related_tracks.search_placeholder')"
                        />
                    </div>

                    <!-- Tracks list -->
                    <div class="tracks-list">
                        <TrackRelationRow
                            v-for="track in filteredTracks"
                            :key="track.id"
                            :track="track"
                        />
                        <div v-if="filteredTracks.length === 0" class="empty-state">
                            {{ t('adm_components.related_tracks.no_results') }}
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <button class="btn-secondary" @click="close">
                        {{ t('adm_components.related_tracks.close') }}
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

.related-tracks-modal {
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

.tracks-list {
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    overflow-y: auto;
    max-height: 400px;
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

/* Responsive design */
@media (max-width: 640px) {
    .related-tracks-modal {
        width: 95%;
        max-height: 90vh;
    }
    .modal-body {
        padding: 1rem;
    }
}

</style>
