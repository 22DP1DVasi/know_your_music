<script setup>
import { ref, computed, watch } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const props = defineProps({
    visible: {
        type: Boolean,
        default: false
    },
    entityType: {
        type: String,
        required: true,
        validator: (value) => ['artist', 'release', 'track'].includes(value)
    },
    entityId: {
        type: [Number, String],
        required: true
    },
    currentGenres: {
        type: Array,
        default: () => []
    },
    allGenres: {
        type: Array,
        required: true,
        default: () => []
    }
});

const emit = defineEmits(['close', 'saved']);

// reaktīvie stāvokli
const selectedGenres = ref([]);
const searchQuery = ref('');
const saving = ref(false);

// entītijas tipa etiķete priekš i18n
const entityTypeLabel = computed(() => {
    return t(`adm_components.genre_manager.${props.entityType}`);
});

// filtrēti žanri pēc meklēšanas vaicājuma
const filteredGenres = computed(() => {
    if (!searchQuery.value.trim()) {
        return props.allGenres;
    }
    const query = searchQuery.value.toLowerCase().trim();
    return props.allGenres.filter(genre =>
        genre.name.toLowerCase().includes(query)
    );
});

// palīgs, lai pārbaudītu, vai ir atlasīts žanrs
const isGenreSelected = (genreId) => {
    return selectedGenres.value.some(g => g.id === genreId);
};

// pārslēgt žanru atlasītajā sarakstā
const toggleGenre = (genre) => {
    const index = selectedGenres.value.findIndex(g => g.id === genre.id);
    if (index === -1) {
        selectedGenres.value.push(genre);
    } else {
        selectedGenres.value.splice(index, 1);
    }
};

// noņemt žanru pēc id
const removeGenre = (genreId) => {
    const index = selectedGenres.value.findIndex(g => g.id === genreId);
    if (index !== -1) {
        selectedGenres.value.splice(index, 1);
    }
};

// inicializēt lokālo stāvokli, kad tiek atvērts modālais logs vai mainās currentGenres
watch(() => props.visible, (newVal) => {
    if (newVal) {
        // klonēt currentGenres uz lokālo stāvokli, lai izvairītos no prop tiešas mutācijas
        selectedGenres.value = [...props.currentGenres];
        searchQuery.value = '';
    }
});

// arī skatīties izmaiņas currentGenres kamēr modāls ir atvērts
watch(() => props.currentGenres, (newGenres) => {
    if (props.visible) {
        selectedGenres.value = [...newGenres];
    }
});

// saglabāt izmaiņas: emitēt atlasītos žanru ID uz vecākobjektu
const saveChanges = async () => {
    saving.value = true;
    try {
        const genreIds = selectedGenres.value.map(g => g.id);
        const payload = {
            entity_type: props.entityType,
            entity_id: props.entityId,
            genre_ids: genreIds
        };
        emit('saved', payload);
        close();
    } catch (error) {
        console.error('Failed to save genres:', error);
    } finally {
        saving.value = false;
    }
};

const close = () => {
    emit('close');
};

</script>

<template>
    <Teleport to="body">
        <div v-if="visible" class="modal-overlay" @click.self="close">
            <div class="genre-modal">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h2>{{ t('adm_components.genre_manager.title', { entity: entityTypeLabel }) }}</h2>
                    <button class="modal-close" @click="close">×</button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <!-- Attached genres (chips) -->
                    <div class="attached-section">
                        <label class="section-label">{{ t('adm_components.genre_manager.selected_genres') }}</label>
                        <div class="chips-container">
                            <div v-for="genre in selectedGenres" :key="genre.id" class="genre-chip">
                                {{ genre.name }}
                                <button class="chip-remove" @click="removeGenre(genre.id)">×</button>
                            </div>
                            <div v-if="selectedGenres.length === 0" class="empty-chip-message">
                                {{ t('adm_components.genre_manager.no_genres_selected') }}
                            </div>
                        </div>
                    </div>

                    <!-- Search input -->
                    <div class="search-section">
                        <label class="section-label">{{ t('adm_components.genre_manager.search_genres') }}</label>
                        <input
                            type="text"
                            v-model="searchQuery"
                            class="search-input"
                            :placeholder="t('adm_components.genre_manager.search_placeholder')"
                        />
                    </div>

                    <!-- Search results (scrollable) -->
                    <div class="results-section">
                        <div class="results-list">
                            <div
                                v-for="genre in filteredGenres"
                                :key="genre.id"
                                class="result-item"
                                :class="{ 'selected': isGenreSelected(genre.id) }"
                                @click="toggleGenre(genre)"
                            >
                                <span class="genre-name">{{ genre.name }}</span>
                                <i class="fa-solid" :class="isGenreSelected(genre.id) ? 'fa-check-circle' : 'fa-circle'"></i>
                            </div>
                            <div v-if="filteredGenres.length === 0" class="no-results">
                                {{ t('adm_components.genre_manager.no_results') }}
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button class="btn-secondary" @click="close">{{ t('adm_components.genre_manager.cancel') }}</button>
                    <button class="btn-primary" @click="saveChanges" :disabled="saving">
                        <span v-if="saving"><i class="fa-solid fa-spinner fa-spin"></i> {{ t('adm_components.genre_manager.saving') }}</span>
                        <span v-else>{{ t('adm_components.genre_manager.save_changes') }}</span>
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

.genre-modal {
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

.section-label {
    font-weight: 600;
    font-size: 0.9rem;
    color: #374151;
    margin-bottom: 0.75rem;
    display: block;
}

.chips-container {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
    background: #f9fafb;
    padding: 1rem;
    border-radius: 0.75rem;
    min-height: 70px;
}

.genre-chip {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    background: #e0f2fe;
    color: #0369a1;
    padding: 0.4rem 0.8rem;
    border-radius: 9999px;
    font-size: 0.85rem;
    font-weight: 500;
    transition: all 0.2s;
}

.genre-chip .chip-remove {
    background: none;
    border: none;
    font-size: 1rem;
    cursor: pointer;
    color: #0369a1;
    padding: 0;
    line-height: 1;
    margin-left: 0.2rem;
}

.genre-chip .chip-remove:hover {
    color: #b91c1c;
}

.empty-chip-message {
    color: #9ca3af;
    font-style: italic;
    font-size: 0.85rem;
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

.results-section {
    max-height: 300px;
    overflow-y: auto;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
}

.results-list {
    display: flex;
    flex-direction: column;
}

.result-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 1rem;
    cursor: pointer;
    border-bottom: 1px solid #f3f4f6;
    transition: background 0.15s;
}

.result-item:hover {
    background-color: #f9fafb;
}

.result-item.selected {
    background-color: #eff6ff;
}

.result-item .genre-name {
    font-size: 0.9rem;
    color: #1f2937;
}

.result-item i {
    font-size: 1rem;
    color: #9ca3af;
}

.result-item.selected i {
    color: #3b82f6;
}

.no-results {
    padding: 2rem;
    text-align: center;
    color: #9ca3af;
    font-style: italic;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
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

.btn-primary {
    background: #0c4baa;
    border: none;
    padding: 0.5rem 1.25rem;
    border-radius: 0.5rem;
    color: white;
    font-weight: 500;
    font-size: 0.85rem;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-primary:hover:not(:disabled) {
    background: #1a5fc9;
    transform: translateY(-1px);
}

.btn-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

/* Responsive */
@media (max-width: 640px) {
    .genre-modal {
        width: 95%;
        max-height: 90vh;
    }
    .modal-body {
        padding: 1rem;
    }
    .result-item {
        padding: 0.6rem 0.75rem;
    }
}

</style>
