<script setup>
import { Link } from '@inertiajs/vue3';
import { useI18n } from 'vue-i18n';
import {route} from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    isOpen: {
        type: Boolean,
        default: false
    },
    genres: {
        type: Array,
        default: () => []
    },
    genreEditRoute: {
        type: Function,
        default: (id) => route('admin-dashboard')
    }
});

const emit = defineEmits(['close']);

const closeModal = () => {
    emit('close');
};

const handleWheel = (event) => {
    event.stopPropagation();
};

</script>

<template>
    <div v-if="isOpen" class="modal-overlay" @wheel="handleWheel" @touchmove.prevent @scroll.prevent>
        <div class="modal">
            <div class="modal-header">
                <h2>{{ t('adm_artists.edit.genres_modal_title') }}</h2>
                <button class="modal-close" @click="closeModal">×</button>
            </div>

            <div class="modal-body">
                <div class="modal-table-container">
                    <div class="modal-table-header">
                        <div class="modal-table-row">
                            <div class="modal-table-cell modal-table-cell-name">
                                {{ t('adm_artists.edit.genre_name') }}
                            </div>
                        </div>
                    </div>

                    <div class="modal-table-body">
                        <Link
                            v-for="genre in genres"
                            :key="genre.id"
                            :href="genreEditRoute(genre.id)"
                            class="modal-table-row clickable-row"
                        >
                            <div class="modal-table-cell modal-table-cell-name">
                                {{ genre.name }}
                            </div>
                        </Link>

                        <div v-if="!genres || genres.length === 0" class="modal-table-empty">
                            {{ t('adm_artists.edit.no_genres') }}
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button class="btn-secondary" @click="closeModal">
                    {{ t('adm_artists.edit.modal_close') }}
                </button>
            </div>
        </div>
    </div>
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

.modal {
    background: white;
    width: 100%;
    max-width: 800px;
    border-radius: 0.5rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    display: flex;
    flex-direction: column;
    max-height: 90vh;
}

.modal-header,
.modal-footer {
    padding: 1rem;
    border-bottom: 1px solid #e5e7eb;
    flex-shrink: 0;
}

.modal-footer {
    border-top: 1px solid #e5e7eb;
    border-bottom: none;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.modal-body {
    padding: 1rem;
    overflow-y: auto;
    flex: 1;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.25rem;
    cursor: pointer;
    color: #6b7280;
}

.modal-close:hover {
    color: #374151;
}

.modal-table-container {
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    overflow: hidden;
    background-color: white;
}

.modal-table-header {
    background-color: #f9fafb;
    border-bottom: 1px solid #e5e7eb;
}

.modal-table-body {
    overflow: visible;
}

.modal-table-body a {
    text-decoration: none;
    color: inherit;
}

.modal-table-row {
    display: flex;
    align-items: center;
    min-height: 3rem;
    border-bottom: 1px solid #f3f4f6;
    position: relative;
}

.modal-table-row:last-child {
    border-bottom: none;
}

.modal-table-row:hover {
    background-color: #f9fafb;
}

.clickable-row {
    text-decoration: none;
    color: inherit;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.clickable-row:hover {
    background-color: #e0f2fe !important;
}

.clickable-row .modal-table-cell {
    text-decoration: none;
}

.modal-table-cell {
    padding: 0.75rem 1rem;
    font-size: 0.875rem;
    color: #374151;
    display: flex;
    align-items: center;
    min-height: 3rem;
    overflow: hidden;
}

.modal-table-cell-name {
    flex: 3;
    min-width: 250px;
    max-width: 400px;
    word-break: break-word;
}

.modal-table-empty {
    padding: 2rem;
    text-align: center;
    color: #6b7280;
    font-size: 0.875rem;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .modal {
        width: 95%;
        max-height: 95vh;
    }

    .modal-table-row {
        flex-direction: column;
        align-items: flex-start;
        padding: 1rem;
        gap: 0.5rem;
    }

    .modal-table-cell {
        padding: 0.25rem 0;
        border-bottom: 1px solid #f3f4f6;
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        flex: none;
        justify-content: flex-start;
    }

    .modal-table-cell:last-child {
        border-bottom: none;
    }

    .modal-table-cell-name {
        font-weight: 600;
        order: 1;
    }
}

</style>
