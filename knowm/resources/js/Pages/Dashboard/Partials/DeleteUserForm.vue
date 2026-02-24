<script setup>
import DangerButton from '@/Components/DangerButton.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import Modal from '@/Components/Modal.vue';
import SecondaryButton from '@/Components/SecondaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { useForm } from '@inertiajs/vue3';
import { nextTick, ref } from 'vue';
import {route} from "ziggy-js";
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const confirmingUserDeletion = ref(false);
const passwordInput = ref(null);

const form = useForm({
    password: '',
});

const confirmUserDeletion = () => {
    confirmingUserDeletion.value = true;

    nextTick(() => passwordInput.value.focus());
};

const deleteUser = () => {
    form.delete(route('profile.destroy'), {
        preserveScroll: true,
        onSuccess: () => closeModal(),
        onError: () => passwordInput.value.focus(),
        onFinish: () => form.reset(),
    });
};

const closeModal = () => {
    confirmingUserDeletion.value = false;

    form.clearErrors();
    form.reset();
};

</script>

<template>
    <section class="delete-account-section">
        <header class="delete-header">
            <h2 class="delete-title">
                {{ t('user_pages.settings.delete_account_title') }}
            </h2>

            <p class="delete-description">
                {{ t('user_pages.settings.delete_account_description') }}
            </p>
        </header>

        <DangerButton @click="confirmUserDeletion">
            {{ t('user_pages.settings.delete_account_button') }}
        </DangerButton>

        <Modal :show="confirmingUserDeletion" @close="closeModal">
            <div class="modal-content">
                <h2 class="modal-title">
                    {{ t('user_pages.settings.delete_confirm_title') }}
                </h2>

                <p class="modal-description">
                    {{ t('user_pages.settings.delete_confirm_description') }}
                </p>

                <div class="password-field">
                    <InputLabel
                        for="password"
                        :value="t('user_pages.settings.password_label')"
                        class="sr-only"
                    />

                    <TextInput
                        id="password"
                        ref="passwordInput"
                        v-model="form.password"
                        type="password"
                        class="password-input"
                        :placeholder="t('user_pages.settings.password_placeholder')"
                        @keyup.enter="deleteUser"
                    />

                    <InputError :message="form.errors.password" class="error-message" />
                </div>

                <div class="modal-actions">
                    <SecondaryButton @click="closeModal">
                        {{ t('user_pages.settings.cancel_button') }}
                    </SecondaryButton>

                    <DangerButton
                        class="delete-confirm-button"
                        :class="{ 'loading': form.processing }"
                        :disabled="form.processing"
                        @click="deleteUser"
                    >
                        {{ t('user_pages.settings.delete_confirm_button') }}
                    </DangerButton>
                </div>
            </div>
        </Modal>
    </section>
</template>

<style scoped>
.delete-account-section {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.delete-header {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.delete-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #111827;
    margin: 0;
}

.delete-description {
    margin-top: 0.25rem;
    font-size: 0.875rem;
    color: #4b5563;
    line-height: 1.5;
}

.modal-content {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.modal-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #111827;
    margin: 0;
}

.modal-description {
    margin-top: 0.25rem;
    font-size: 0.875rem;
    color: #4b5563;
    line-height: 1.5;
}

.password-field {
    margin-top: 1rem;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.password-input {
    margin-top: 0.25rem;
    width: 75%;
}

.error-message {
    margin-top: 0.5rem;
}

.modal-actions {
    margin-top: 1.5rem;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.delete-confirm-button {
    margin-left: 0.75rem;
}

.delete-confirm-button.loading {
    opacity: 0.25;
}

.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border-width: 0;
}

.modal-content {
    animation: fadeIn 0.2s ease-out;
}

/* Tumšais režīms */
@media (prefers-color-scheme: dark) {
    .delete-title, .modal-title,
    .modal-title {
        color: #f3f4f6;
    }

    .delete-description, .modal-description {
        color: #9ca3af;
    }
}

/* Animācijas */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
