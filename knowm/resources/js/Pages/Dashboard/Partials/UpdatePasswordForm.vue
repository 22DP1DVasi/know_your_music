<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';
import {route} from "ziggy-js";
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('password.update'), {
        preserveScroll: true,
        onSuccess: () => form.reset(),
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }
            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>

<template>
    <section class="update-password-section">
        <header class="update-header">
            <h2 class="update-title">
                {{ t('user_pages.settings.update_password_title') }}
            </h2>

            <p class="update-description">
                {{ t('user_pages.settings.update_password_description') }}
            </p>
        </header>

        <form @submit.prevent="updatePassword" class="password-form">
            <div class="form-group">
                <InputLabel
                    for="current_password"
                    :value="t('user_pages.settings.current_password_label')"
                />

                <TextInput
                    id="current_password"
                    ref="currentPasswordInput"
                    v-model="form.current_password"
                    type="password"
                    class="form-input"
                    autocomplete="current-password"
                />

                <InputError
                    :message="form.errors.current_password"
                    class="error-message"
                />
            </div>

            <div class="form-group">
                <InputLabel
                    for="password"
                    :value="t('user_pages.settings.new_password_label')"
                />

                <TextInput
                    id="password"
                    ref="passwordInput"
                    v-model="form.password"
                    type="password"
                    class="form-input"
                    autocomplete="new-password"
                />

                <InputError
                    :message="form.errors.password"
                    class="error-message"
                />
            </div>

            <div class="form-group">
                <InputLabel
                    for="password_confirmation"
                    :value="t('user_pages.settings.confirm_password_label')"
                />

                <TextInput
                    id="password_confirmation"
                    v-model="form.password_confirmation"
                    type="password"
                    class="form-input"
                    autocomplete="new-password"
                />

                <InputError
                    :message="form.errors.password_confirmation"
                    class="error-message"
                />
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
    </section>
</template>

<style scoped>
.update-password-section {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.update-header {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.update-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #111827;
    margin: 0;
}

.update-description {
    margin-top: 0.25rem;
    font-size: 0.875rem;
    color: #4b5563;
    line-height: 1.5;
}

.password-form {
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

/* Pārejas */
.fade-out {
    opacity: 0;
}

.transition {
    transition: opacity 0.15s ease-in-out;
}

.password-form {
    animation: fadeIn 0.2s ease-out;
}

/* Tumšais režīms */
@media (prefers-color-scheme: dark) {
    .update-description, .success-message {
        color: #9ca3af;
    }

    .update-title {
        color: #f3f4f6;
    }
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-5px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

</style>
