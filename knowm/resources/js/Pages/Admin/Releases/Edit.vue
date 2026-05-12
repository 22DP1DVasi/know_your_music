<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import {Head, useForm, router, Link} from '@inertiajs/vue3';
import { ref } from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import axios from 'axios';

const props = defineProps({
    release: {
        type: Object,
        required: true
    },
    releaseTypes: {
        type: Array,
        default: () => ['album', 'ep', 'single', 'compilation']
    }
});

const { t } = useI18n();

const form = useForm({
    title: props.release.title || '',
    release_date: props.release.release_date || '',
    release_type: props.release.release_type || 'album',
    description: props.release.description || '',
    description_lv: props.release.description_lv || ''
});

const coverPreview = ref(props.release.cover_url || null);
const coverFile = ref(null);
const isUploadingCover = ref(false);
const coverError = ref(null);

const submit = () => {
    form.put(route('admin-releases-update', { id: props.release.id }), {
        preserveScroll: true,
        onError: (errors) => {
            console.error('Update errors:', errors);
        }
    });
};

const triggerFileInput = () => {
    document.getElementById('cover-input')?.click();
};

const handleCoverUpload = async (event) => {
    const file = event.target.files[0];
    if (!file) return;
    // extension validation
    if (!file.type.match(/image\/webp/)) {
        coverError.value = t('adm_releases.edit.cover_error_type');
        return;
    }
    // size validation
    if (file.size > 2 * 1024 * 1024) {
        coverError.value = t('adm_releases.edit.cover_error_size');
        return;
    }

    coverError.value = null;
    isUploadingCover.value = true;
    const formData = new FormData();
    formData.append('cover', file);
    try {
        const response = await axios.post(
            route('admin-releases-update-cover', { id: props.release.id }),
            formData,
            { headers: { 'Content-Type': 'multipart/form-data' } }
        );
        if (response.data.success) {
            coverPreview.value = response.data.cover_url;
            props.release.cover_url = response.data.cover_url;
        }
    } catch (error) {
        console.error('Cover upload error:', error);
        coverError.value = error.response?.data?.message || t('adm_releases.edit.cover_error_upload');
    } finally {
        isUploadingCover.value = false;
        event.target.value = '';
    }
};

const capitalize = (value) => {
    if (!value) return '';
    return value.charAt(0).toUpperCase() + value.slice(1);
};

</script>

<template>
    <Head :title="`${t('adm_releases.edit.title')}: ${release.title}`" />

    <AdminLayout>
        <div class="edit-container">
            <div class="edit-header">
                <h1>{{ t('adm_releases.edit.title') }}</h1>
                <div class="edit-actions">
                    <Link :href="route('admin-releases-index')" class="btn-secondary">
                        {{ t('adm_releases.edit.back_to_releases') }}
                    </Link>
                </div>
            </div>

            <div class="edit-layout">
                <!-- Left column: main form-->
                <div class="edit-main">
                    <form @submit.prevent="submit" class="edit-form">
                        <!-- Basic fields -->
                        <div class="form-section">
                            <h2 class="section-title">{{ t('adm_releases.edit.basic_info') }}</h2>

                            <div class="form-group">
                                <label for="title">{{ t('adm_releases.edit.title_label') }} <span class="required">*</span></label>
                                <input
                                    id="title"
                                    type="text"
                                    v-model="form.title"
                                    class="input-field"
                                    :class="{ 'error': form.errors.title }"
                                    maxlength="255"
                                />
                                <div v-if="form.errors.title" class="error-message">{{ form.errors.title }}</div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="release_date">{{ t('adm_releases.edit.release_date_label') }}</label>
                                    <input
                                        id="release_date"
                                        type="date"
                                        v-model="form.release_date"
                                        class="input-field"
                                        :class="{ 'error': form.errors.release_date }"
                                    />
                                    <div v-if="form.errors.release_date" class="error-message">{{ form.errors.release_date }}</div>
                                </div>

                                <div class="form-group">
                                    <label for="release_type">{{ t('adm_releases.edit.release_type_label') }}</label>
                                    <select
                                        id="release_type"
                                        v-model="form.release_type"
                                        class="input-field"
                                        :class="{ 'error': form.errors.release_type }"
                                    >
                                        <option v-for="type in releaseTypes" :key="type" :value="type">
                                            {{ t(`releases.type.${type}`) }}
                                        </option>
                                    </select>
                                    <div v-if="form.errors.release_type" class="error-message">{{ form.errors.release_type }}</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="description">{{ t('adm_releases.edit.description_label') }} (EN)</label>
                                <textarea
                                    id="description"
                                    v-model="form.description"
                                    rows="6"
                                    class="textarea-field"
                                    :class="{ 'error': form.errors.description }"
                                ></textarea>
                                <div v-if="form.errors.description" class="error-message">{{ form.errors.description }}</div>
                            </div>

                            <div class="form-group">
                                <label for="description_lv">{{ t('adm_releases.edit.description_lv_label') }} (LV)</label>
                                <textarea
                                    id="description_lv"
                                    v-model="form.description_lv"
                                    rows="6"
                                    class="textarea-field"
                                    :class="{ 'error': form.errors.description_lv }"
                                ></textarea>
                                <div v-if="form.errors.description_lv" class="error-message">{{ form.errors.description_lv }}</div>
                            </div>
                        </div>

                        <!-- Placeholder for "Associated content" -->
                        <div class="form-section">
                            <h2 class="section-title">{{ t('adm_releases.edit.associated_content') }}</h2>
                            <div class="placeholder-box">
                                {{ t('adm_releases.edit.associated_content_placeholder') }}
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-primary" :disabled="form.processing">
                                {{ form.processing ? t('adm_releases.edit.saving') : t('adm_releases.edit.save_changes') }}
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Right column: read-only info & cover image -->
                <div class="edit-sidebar">
                    <!-- Read-only release information -->
                    <div class="info-card">
                        <h3 class="info-title">{{ t('adm_releases.edit.meta_info') }}</h3>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.id_label') }}:</span>
                            <span class="info-value">{{ release.id }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.slug_label') }}:</span>
                            <span class="info-value">{{ release.slug }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.popularity_label') }}:</span>
                            <span class="info-value">{{ release.popularity ?? '—' }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.created_at_label') }}:</span>
                            <span class="info-value">{{ release.created_at }}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">{{ t('adm_releases.edit.updated_at_label') }}:</span>
                            <span class="info-value">{{ release.updated_at }}</span>
                        </div>
                    </div>

                    <!-- Cover image section -->
                    <div class="image-card">
                        <h3 class="info-title">{{ t('adm_releases.edit.cover_image') }}</h3>
                        <div class="cover-container">
                            <div class="cover-preview" @click="triggerFileInput">
                                <img v-if="coverPreview" :src="coverPreview" :alt="release.title" />
                                <div v-else class="cover-placeholder">
                                    <i class="fa-regular fa-image"></i>
                                    <span>{{ t('adm_releases.edit.upload_cover') }}</span>
                                </div>
                            </div>
                            <input
                                id="cover-input"
                                type="file"
                                accept="image/webp"
                                style="display: none"
                                @change="handleCoverUpload"
                            />
                            <button type="button" class="btn-secondary" @click="triggerFileInput" :disabled="isUploadingCover">
                                {{ isUploadingCover ? t('adm_releases.edit.uploading') : t('adm_releases.edit.change_cover') }}
                            </button>
                            <div v-if="coverError" class="error-message">{{ coverError }}</div>
                            <p class="helper-text">{{ t('adm_releases.edit.cover_helper') }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<style scoped>
.edit-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1rem;
}

.edit-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.edit-header h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

.edit-actions {
    display: flex;
    gap: 0.75rem;
}

.btn-secondary {
    background-color: #6b7280;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    text-decoration: none;
    font-weight: 500;
    transition: background 0.2s;
    display: inline-block;
    border: none;
    cursor: pointer;
}

.btn-secondary:hover {
    background-color: #4b5563;
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

.edit-layout {
    display: flex;
    gap: 2rem;
    flex-wrap: wrap;
}

.edit-main {
    flex: 2;
    min-width: 0;
}

.edit-sidebar {
    flex: 1;
    min-width: 280px;
}

.edit-form {
    background: white;
    border-radius: 0.75rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.form-section {
    margin-bottom: 2rem;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 1.5rem;
}

.section-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1.25rem;
}

.form-group {
    margin-bottom: 1.25rem;
}

.form-row {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.form-row .form-group {
    flex: 1;
}

label {
    display: block;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.5rem;
    font-size: 0.875rem;
}

.required {
    color: #ef4444;
}

.input-field,
.textarea-field,
select.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    transition: all 0.2s;
}

.input-field:focus,
.textarea-field:focus,
select.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
}

.input-field.error,
.textarea-field.error,
select.input-field.error {
    border-color: #ef4444;
}

.error-message {
    color: #ef4444;
    font-size: 0.75rem;
    margin-top: 0.25rem;
}

.placeholder-box {
    background: #f9fafb;
    border: 1px dashed #d1d5db;
    border-radius: 0.5rem;
    padding: 2rem;
    text-align: center;
    color: #6b7280;
    font-style: italic;
}

.form-actions {
    margin-top: 1rem;
    text-align: right;
}

.info-card,
.image-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1.25rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.info-title {
    font-size: 1rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 0.5rem;
}

.info-row {
    display: flex;
    padding: 0.5rem 0;
    font-size: 0.875rem;
    border-bottom: 1px solid #f3f4f6;
}

.info-label {
    flex: 0 0 110px;
    font-weight: 500;
    color: #4b5563;
}

.info-value {
    flex: 1;
    color: #1f2937;
    word-break: break-word;
}

.cover-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
}

.cover-preview {
    width: 200px;
    height: 200px;
    border-radius: 0.5rem;
    overflow: hidden;
    background: #f3f4f6;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    border: 1px solid #e5e7eb;
    transition: border 0.2s;
}

.cover-preview:hover {
    border-color: #3b82f6;
}

.cover-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.cover-placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #9ca3af;
    font-size: 0.875rem;
    text-align: center;
}

.cover-placeholder i {
    font-size: 2rem;
    margin-bottom: 0.5rem;
}

.helper-text {
    font-size: 0.75rem;
    color: #6b7280;
    text-align: center;
    margin-top: 0.5rem;
}

/* Responsive design */
@media (max-width: 1115px) {
    .edit-layout {
        flex-direction: column;
    }

    .edit-header {
        flex-direction: column;
        align-items: stretch;
    }

    .edit-actions {
        flex-wrap: wrap;
    }

    .form-row {
        flex-direction: column;
        gap: 0;
    }
}

</style>
