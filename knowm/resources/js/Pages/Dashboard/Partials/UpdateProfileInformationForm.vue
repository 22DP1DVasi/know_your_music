<script setup>
import { ref } from 'vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Link, useForm, usePage } from '@inertiajs/vue3';
import axios from 'axios';
import { route } from "ziggy-js";
import { useI18n } from 'vue-i18n';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const user = usePage().props.auth.user;
const { t } = useI18n();

// reaktīvās atsauces uz lietotāja datiem, kas var mainīties
const userInitial = ref(user.initial);
const userColor1 = ref(user.avatar_color_1);
const userColor2 = ref(user.avatar_color_2);
const userName = ref(user.name);

const form = useForm({
    name: user.name,
    email: user.email,
});

// iesniegt veidlapu + atjaunināt lietotāja datus veiksmīgas izpildes gadījumā
const submitForm = () => {
    form.patch(route('profile.update'), {
        onSuccess: () => {
            // atjaunināt reaktīvās atsauces ar jauniem lietotāja datiem no lapas props
            const updatedUser = usePage().props.auth.user;
            userName.value = updatedUser.name;
            userInitial.value = updatedUser.initial;
            userColor1.value = updatedUser.avatar_color_1;
            userColor2.value = updatedUser.avatar_color_2;
            // atjaunināt veidlapas nosaukumu, ja tas tika mainīts
            form.name = updatedUser.name;
        }
    });
};

// Avatar handling
const isUploadingAvatar = ref(false);
const avatarPreview = ref(user.avatar_url || null);
const fileInput = ref(null);

const triggerFileInput = () => {
    fileInput.value.click();
};

const handleAvatarUpload = async (event) => {
    const file = event.target.files[0];
    if (!file) return;
    // validēt faila tipu
    if (!file.type.match(/image\/(jpeg|jpg|png|gif|webp)/)) {
        alert(t('user_pages.settings.avatar_error_type'));
        return;
    }

    // validēt faila lielumu (maks. 2 MB)
    if (file.size > 2 * 1024 * 1024) {
        alert(t('user_pages.settings.avatar_error_size'));
        return;
    }

    isUploadingAvatar.value = true;
    const formData = new FormData();
    formData.append('avatar', file);
    try {
        const response = await axios.post(route('profile.avatar.update'), formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });
        if (response.data.success) {
            avatarPreview.value = response.data.avatar_url;
            // atjaunināt lietotāja objektu lapas props'os
            const updatedUser = usePage().props.auth.user;
            updatedUser.avatar_url = response.data.avatar_url;
            updatedUser.avatar = response.data.avatar_path;
        }
    } catch (error) {
        console.error('Error uploading avatar:', error);
        alert(t('user_pages.settings.avatar_error_upload'));
    } finally {
        isUploadingAvatar.value = false;
        // notīrīt faila ievadi
        event.target.value = '';
    }
};

const handleAvatarRemove = async () => {
    if (!confirm(t('user_pages.settings.avatar_remove_confirm'))) return;
    isUploadingAvatar.value = true;
    try {
        const response = await axios.delete(route('profile.avatar.destroy'));

        if (response.data.success) {
            avatarPreview.value = null;
            // atjaunināt lietotāja objektu lapas props'os
            const updatedUser = usePage().props.auth.user;
            updatedUser.avatar_url = response.data.avatar_url;
            updatedUser.avatar = null;
        }
    } catch (error) {
        console.error('Error removing avatar:', error);
        alert(t('user_pages.settings.avatar_error_remove'));
    } finally {
        isUploadingAvatar.value = false;
    }
};

</script>

<template>
    <section class="profile-info-section">
        <div class="profile-info-layout">
            <!-- Kreisā puse: veidlapas lauki -->
            <div class="form-fields">
                <header class="section-header">
                    <h2 class="section-title">
                        {{ t('user_pages.settings.profile_info_label') }}
                    </h2>
                    <p class="section-description">
                        {{ t('user_pages.settings.profile_info_description') }}
                    </p>
                </header>

                <form
                    @submit.prevent="submitForm"
                    class="profile-form"
                >
                    <div class="form-group">
                        <InputLabel for="name" :value="t('user_pages.settings.name_label')" />

                        <TextInput
                            id="name"
                            type="text"
                            class="form-input"
                            v-model="form.name"
                            required
                            autofocus
                            autocomplete="name"
                        />

                        <InputError class="error-message" :message="form.errors.name" />
                    </div>

                    <div class="form-group">
                        <InputLabel for="email" :value="t('user_pages.settings.email_label')" />

                        <TextInput
                            id="email"
                            type="email"
                            class="form-input"
                            v-model="form.email"
                            required
                            autocomplete="username"
                        />

                        <InputError class="error-message" :message="form.errors.email" />
                    </div>

                    <div v-if="mustVerifyEmail && user.email_verified_at === null" class="verification-section">
                        <p class="verification-text">
                            {{ t('user_pages.settings.verification_text') }}
                            <Link
                                :href="route('verification.send')"
                                method="post"
                                as="button"
                                class="verification-link"
                            >
                                {{ t('user_pages.settings.verification_link') }}
                            </Link>
                        </p>

                        <div
                            v-show="status === 'verification-link-sent'"
                            class="verification-success"
                        >
                            {{ t('user_pages.settings.verification_success') }}
                        </div>
                    </div>

                    <div class="form-actions">
                        <PrimaryButton :disabled="form.processing">
                            {{ t('user_pages.settings.save_button') }}
                        </PrimaryButton>

                        <Transition
                            enter-active-class="transition"
                            enter-from-class="fade-out"
                            leave-active-class="transition"
                            leave-to-class="fade-out"
                        >
                            <p
                                v-if="form.recentlySuccessful"
                                class="success-message"
                            >
                                {{ t('user_pages.settings.saved_message') }}
                            </p>
                        </Transition>
                    </div>
                </form>
            </div>

            <!-- Labā puse: iemiesojums -->
            <div class="avatar-section">
                <h3 class="avatar-title">
                    {{ t('user_pages.settings.avatar_title') }}
                </h3>

                <div class="avatar-container">
                    <div class="avatar-preview-wrapper">
                        <img
                            v-if="avatarPreview"
                            :src="avatarPreview"
                            :alt="userName"
                            class="avatar-preview"
                        >
                        <div
                            v-else
                            class="avatar-initial"
                            :style="{
                                background: `linear-gradient(135deg, ${userColor1}, ${userColor2})`
                            }"
                        >
                            {{ userInitial }}
                        </div>

                        <!-- Atveidot pārklājumu, novietojot kursoru -->
                        <div class="avatar-overlay">
                            <button
                                @click="triggerFileInput"
                                class="avatar-action-button upload-action"
                                :disabled="isUploadingAvatar"
                                :title="t('user_pages.settings.avatar_upload_title')"
                            >
                                <i class="fa-solid fa-camera"></i>
                            </button>
                            <button
                                v-if="avatarPreview"
                                @click="handleAvatarRemove"
                                class="avatar-action-button remove-action"
                                :disabled="isUploadingAvatar"
                                :title="t('user_pages.settings.avatar_remove_title')"
                            >
                                <i class="fa-solid fa-trash-can"></i>
                            </button>
                        </div>

                        <!-- Slēptā faila ievade -->
                        <input
                            ref="fileInput"
                            type="file"
                            accept="image/jpeg,image/png,image/gif,image/webp"
                            @change="handleAvatarUpload"
                            class="hidden-input"
                        >
                    </div>

                    <!-- Ielādēšana indikators -->
                    <div v-if="isUploadingAvatar" class="avatar-loading">
                        <i class="fa-solid fa-spinner fa-spin"></i>
                        <span>{{ t('user_pages.settings.avatar_uploading') }}</span>
                    </div>

                    <p class="avatar-helper">
                        {{ t('user_pages.settings.avatar_helper_1') }}<br>
                        {{ t('user_pages.settings.avatar_helper_2') }}
                    </p>
                </div>
            </div>
        </div>
    </section>
</template>

<style scoped>
.profile-info-section {
    width: 100%;
}

.profile-info-layout {
    display: grid;
    grid-template-rows: 1fr;
    gap: 2rem;
    justify-items: center;
    width: 65vw;
}

.form-fields {
    min-width: 0;
    width: 100%;
    max-width: 600px;
}

.section-header {
    margin-bottom: 1.5rem;
}

.section-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #111827;
    margin: 0 0 0.25rem 0;
}

.section-description {
    margin-top: 0.25rem;
    font-size: 0.875rem;
    color: #4b5563;
    line-height: 1.5;
}

.profile-form {
    margin-top: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.form-input {
    margin-top: 0.25rem;
    width: 100%;
}

.error-message {
    margin-top: 0.5rem;
}

.verification-section {
    margin-top: 1rem;
}

.verification-text {
    margin-top: 0.5rem;
    font-size: 0.875rem;
    color: #1f2937;
    line-height: 1.5;
}

.verification-link {
    border-radius: 0.375rem;
    font-size: 0.875rem;
    color: #4b5563;
    text-decoration: underline;
    background: none;
    border: none;
    padding: 0;
    cursor: pointer;
    transition: color 0.2s ease;
}

.verification-link:hover {
    color: #111827;
}

.verification-link:focus {
    outline: none;
    box-shadow: 0 0 0 2px #6366f1;
}

.verification-success {
    margin-top: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
    color: #16a34a;
}

.form-actions {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-top: 0.5rem;
}

.success-message {
    font-size: 0.875rem;
    color: #4b5563;
}

.avatar-section {
    width: 100%;
    max-width: 320px;
    flex-shrink: 0;
    min-width: 0;
    background: #f9fafb;
    border-radius: 0.75rem;
    padding: 1.5rem 1.5rem 1rem;
    border: 1px solid #e5e7eb;
    box-sizing: border-box;
}

.avatar-title {
    font-size: 1rem;
    font-weight: 500;
    color: #111827;
    margin: 0 0 1.25rem 0;
}

.avatar-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
}

.avatar-preview-wrapper {
    position: relative;
    width: 150px;
    height: 150px;
    border-radius: 50%;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.2);
    transition: transform 0.3s ease;
}

.avatar-preview-wrapper:hover {
    transform: scale(1.02);
}

.avatar-preview {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.avatar-initial {
    width: 100%;
    height: 100%;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 3rem;
    font-weight: 600;
}

.avatar-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.avatar-preview-wrapper:hover .avatar-overlay {
    opacity: 1;
}

.avatar-action-button {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    border: none;
    background: white;
    color: #0c4baa;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.avatar-action-button:hover:not(:disabled) {
    transform: scale(1.1);
    background: #f0f7ff;
}

.avatar-action-button:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.upload-action:hover {
    color: #0c4baa;
}

.remove-action:hover {
    color: #dc3545;
}

.hidden-input {
    display: none;
}

.avatar-loading {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #0c4baa;
    font-size: 0.875rem;
    margin-top: 0.5rem;
}

.avatar-loading i {
    font-size: 1rem;
}

.avatar-helper {
    font-size: 0.75rem;
    color: #6b7280;
    text-align: center;
    margin: 0.5rem 0 0 0;
    line-height: 1.4;
}

.fade-out {
    opacity: 0;
}

.transition {
    transition: opacity 0.15s ease-in-out;
}

/* Responsivitāte */
@media (max-width: 1285px) {
    .profile-info-layout {
        width: 58vw;
    }
}

@media (max-width: 1023px) {
    .profile-info-layout {
        width: 78vw;
    }
}

@media (min-width: 768px) {
    .profile-info-layout {
        grid-template-columns: minmax(0, 1fr) 320px;
        gap: 3rem;
        justify-items: stretch;
        align-items: start;
    }

    .form-fields {
        width: 100%;
        max-width: none;
    }
}

@media (max-width: 767px) {
    .profile-info-layout {
        width: 100%;
    }

    .form-fields {
        width: 100%;
        max-width: 600px;
    }
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(5px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.avatar-section {
    animation: fadeIn 0.3s ease-out;
}

</style>
