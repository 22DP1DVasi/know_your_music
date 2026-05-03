<script setup>
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { router, usePage } from '@inertiajs/vue3';
import axios from 'axios';
import {route} from "ziggy-js";

const { t } = useI18n();

const props = defineProps({
    show: {
        type: Boolean,
        default: false
    },
    mode: {
        type: String,
        default: 'create',
        validator: (value) => ['create', 'edit'].includes(value)
    },
    showDescription: {
        type: Boolean,
        default: true
    },
    initialData: {
        type: Object,
        default: () => ({
            name: '',
            description: '',
            is_private: false
        })
    },
    trackId: {
        type: Number,
        default: null
    },
    redirectAfterCreate: {
        type: Boolean,
        default: true
    },
    redirectRoute: {
        type: String,
        default: null
    }
});

// piekļuve koplietojamiem datiem no servera puses
const page = usePage();
const user = page.props.auth?.user;

const emit = defineEmits(['close', 'created', 'error']);

const form = ref({
    name: props.initialData.name || '',
    description: props.initialData.description || '',
    is_private: props.initialData.is_private || false
});

const errors = ref({
    name: null,
    description: null
});

const isSubmitting = ref(false);

// reset form when modal opens
watch(() => props.show, (newVal) => {
    if (newVal) {
        form.value = {
            name: props.initialData.name || '',
            description: props.initialData.description || '',
            is_private: props.initialData.is_private || false
        };
        errors.value = { name: null, description: null };
    }
});

const close = () => {
    if (!isSubmitting.value) {
        emit('close');
    }
};

const validate = () => {
    let isValid = true;
    errors.value = { name: null, description: null };

    if (!form.value.name.trim()) {
        errors.value.name = t('components.playlist_create.error_name_required');
        isValid = false;
    } else if (form.value.name.length > 100) {
        errors.value.name = t('components.playlist_create.error_name_length');
        isValid = false;
    }
    if (form.value.description && form.value.description.length > 255) {
        errors.value.description = t('components.playlist_create.error_description_length');
        isValid = false;
    }

    return isValid;
};

const submit = async () => {
    if (!validate() || isSubmitting.value) return;
    isSubmitting.value = true;
    try {
        const payload = {
            name: form.value.name.trim(),
            description: form.value.description?.trim() || null,
            is_private: form.value.is_private
        };

        // choose the appropriate endpoint whether trackId is provided
        const endpoint = props.trackId
            ? route('playlists.store.with-track')
            : route('playlists.store');

        if (props.trackId) {
            payload.track_id = props.trackId;
        }
        const response = await axios.post(endpoint, payload);
        emit('created', response.data.playlist);
        if (props.redirectAfterCreate) {
            if (props.redirectRoute) {
                router.get(route(props.redirectRoute, { user: user.slug, playlist: response.data.playlist.slug }));
            } else {
                router.get(route('playlists.show', {
                    user: user.slug,
                    playlist: response.data.playlist.slug,
                    page
                }))
            }
        }
        close();
    } catch (error) {
        console.error('Error creating playlist:', error);
        if (error.response?.data?.errors) {
            errors.value = error.response.data.errors;
        } else {
            emit('error', error.response?.data?.message || t('playlists.create.error_general'));
        }
    } finally {
        isSubmitting.value = false;
    }
};

</script>

<template>
    <Teleport to="body">
        <div v-if="show" class="modal-overlay" @click.self="close">
            <div class="modal-container modal-small">
                <div class="modal-header">
                    <h3 class="modal-title">
                        <i class="fa-solid fa-plus"></i>
                        {{ mode === 'create' ? t('components.playlist_create.title') : t('components.playlist_create.edit_title') }}
                    </h3>
                    <button @click="close" class="modal-close-button">
                        <i class="fa-solid fa-times"></i>
                    </button>
                </div>

                <div class="modal-body">
                    <!-- Playlist Name -->
                    <div class="form-group">
                        <label class="form-label">
                            {{ t('components.playlist_create.playlist_name') }} <span class="required">*</span>
                        </label>
                        <input
                            v-model="form.name"
                            type="text"
                            class="form-input"
                            :class="{ 'error': errors.name }"
                            maxlength="100"
                            :placeholder="t('components.playlist_create.name_placeholder')"
                            autofocus
                            @keyup.enter="submit"
                        >
                        <div class="input-footer">
                            <span v-if="errors.name" class="error-message">{{ errors.name }}</span>
                            <span class="char-counter">{{ form.name.length }}/100</span>
                        </div>
                    </div>

                    <!-- Description (conditional) -->
                    <div v-if="showDescription" class="form-group">
                        <label class="form-label">
                            {{ t('components.playlist_create.description_label') }}
                        </label>
                        <textarea
                            v-model="form.description"
                            class="form-textarea"
                            :class="{ 'error': errors.description }"
                            maxlength="255"
                            rows="3"
                            :placeholder="t('components.playlist_create.description_placeholder')"
                        ></textarea>
                        <div class="input-footer">
                            <span v-if="errors.description" class="error-message">{{ errors.description }}</span>
                            <span class="char-counter">{{ form.description.length }}/255</span>
                        </div>
                    </div>

                    <!-- Privacy Toggle -->
                    <div class="form-group">
                        <label class="form-label">{{ t('components.playlist_create.privacy_label') }}</label>
                        <div class="privacy-toggle-compact">
                            <button
                                type="button"
                                class="toggle-option-compact"
                                :class="{ 'active': !form.is_private }"
                                @click="form.is_private = false"
                            >
                                <i class="fa-solid fa-globe"></i>
                                <span>{{ t('components.playlist_create.public') }}</span>
                            </button>
                            <button
                                type="button"
                                class="toggle-option-compact"
                                :class="{ 'active': form.is_private }"
                                @click="form.is_private = true"
                            >
                                <i class="fa-solid fa-lock"></i>
                                <span>{{ t('components.playlist_create.private') }}</span>
                            </button>
                        </div>
                        <p class="privacy-description">
                            {{ form.is_private
                            ? t('components.playlist_create.private_desc')
                            : t('components.playlist_create.public_desc')
                            }}
                        </p>
                    </div>
                </div>

                <div class="modal-footer">
                    <button @click="close" class="cancel-button" :disabled="isSubmitting">
                        {{ t('components.playlist_create.cancel') }}
                    </button>
                    <button
                        @click="submit"
                        class="create-button"
                        :disabled="!form.name.trim() || isSubmitting"
                        :class="{ 'loading': isSubmitting }"
                    >
                        <span v-if="isSubmitting">
                            <i class="fa-solid fa-spinner fa-spin"></i>
                            {{ t('components.playlist_create.creating') }}
                        </span>
                        <span v-else>
                            <i class="fa-solid fa-plus"></i>
                            {{ t('components.playlist_create.create_button') }}
                        </span>
                    </button>
                </div>
            </div>
        </div>
    </Teleport>
</template>

<style scoped>
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(5px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    animation: fadeIn 0.2s ease;
}

.modal-container {
    background: white;
    border-radius: 16px;
    width: 90%;
    max-width: 500px;
    max-height: 90vh;
    display: flex;
    flex-direction: column;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    animation: slideUp 0.3s ease;
}

.modal-container.modal-small {
    max-width: 480px;
}

@media (prefers-color-scheme: dark) {
    .modal-container {
        background: #1f2937;
    }
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 1.25rem;
    border-bottom: 1px solid rgba(12, 75, 170, 0.1);
    flex-shrink: 0;
}

.modal-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #333;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.modal-title i {
    color: #0c4baa;
}

@media (prefers-color-scheme: dark) {
    .modal-title {
        color: #f3f4f6;
    }
}

.modal-close-button {
    background: none;
    border: none;
    color: #666;
    font-size: 1rem;
    cursor: pointer;
    padding: 0.4rem;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
}

.modal-close-button:hover {
    background: rgba(0, 0, 0, 0.05);
    color: #0c4baa;
}

.modal-body {
    padding: 1.25rem;
    overflow-y: auto;
    flex: 1;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
    padding: 1rem 1.25rem;
    border-top: 1px solid rgba(12, 75, 170, 0.1);
    flex-shrink: 0;
}

.form-group {
    margin-bottom: 1.25rem;
}

.form-group:last-child {
    margin-bottom: 0;
}

.form-label {
    display: block;
    font-size: 0.85rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 0.5rem;
}

@media (prefers-color-scheme: dark) {
    .form-label {
        color: #e5e7eb;
    }
}

.required {
    color: #dc2626;
}

.form-input,
.form-textarea {
    width: 100%;
    padding: 0.6rem 0.75rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 0.9rem;
    transition: all 0.2s ease;
    font-family: inherit;
}

.form-input:focus,
.form-textarea:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
}

.form-input.error,
.form-textarea.error {
    border-color: #dc2626;
}

.form-textarea {
    resize: vertical;
    min-height: 80px;
}

.input-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 0.35rem;
}

.error-message {
    color: #dc2626;
    font-size: 0.75rem;
}

.char-counter {
    color: #666;
    font-size: 0.7rem;
}

.privacy-toggle-compact {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
}

.toggle-option-compact {
    flex: 1;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.35rem;
    padding: 0.5rem 0.75rem;
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 30px;
    color: #666;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.toggle-option-compact.active {
    background: white;
    border-color: #0c4baa;
    color: #0c4baa;
}

.toggle-option-compact.active:first-of-type {
    border-color: #16a34a;
    color: #16a34a;
}

.toggle-option-compact.active:last-of-type {
    border-color: #dc2626;
    color: #dc2626;
}

.privacy-description {
    font-size: 0.75rem;
    color: #666;
    margin: 0.5rem 0 0 0;
}

.cancel-button {
    padding: 0.45rem 1rem;
    background: white;
    border: 1px solid #ddd;
    border-radius: 30px;
    color: #666;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
}

.cancel-button:hover:not(:disabled) {
    background: #f5f5f5;
    border-color: #999;
}

.cancel-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.create-button {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.45rem 1.25rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border: none;
    border-radius: 30px;
    color: white;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    min-width: 100px;
    justify-content: center;
}

.create-button:hover:not(:disabled) {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.3);
}

.create-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.create-button.loading {
    opacity: 0.8;
}

.create-button.loading i {
    margin-right: 0.35rem;
}

/* Animācijas */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsivitāte */
@media (max-width: 640px) {
    .modal-container {
        width: 95%;
        max-height: 85vh;
    }

    .privacy-toggle-compact {
        flex-direction: column;
    }

    .toggle-option-compact {
        justify-content: center;
    }

    .modal-footer {
        flex-direction: column;
    }

    .cancel-button,
    .create-button {
        width: 100%;
        justify-content: center;
    }
}

</style>
