<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { debounce } from 'lodash';
import { route } from "ziggy-js";
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};

const goBack = () => {
    window.history.back();
};

const emailExists = ref(false);
const checkingEmail = ref(false);

const checkEmail = debounce(async (email) => {
    if (!email || !email.includes('@')) {
        emailExists.value = false;
        return;
    }
    try {
        checkingEmail.value = true;
        const response = await axios.get('/api/check-email', {
            params: { email },
            headers: {
                'Accept': 'application/json'
            }
        });
        emailExists.value = response.data.exists;
    } catch (error) {
        if (error.response && error.response.status === 422) {
            emailExists.value = false;
        } else {
            console.error('Email check failed:', error);
        }
    } finally {
        checkingEmail.value = false;
    }
}, 500);

</script>

<template>
    <Head :title="t('auth.signup.page_title')" />
    <div class="register-container">
        <div class="go-back-arrow" @click="goBack">
            <span class="arrow-icon">←</span>
        </div>

        <div class="register-card">
            <div class="register-header">
                <div class="logo-container">
                    <img src="/images/mini-logo.png" alt="App Logo" class="logo">
                </div>
                <h1 class="register-title">{{ t('auth.signup.title') }}</h1>
                <p class="register-subtitle">{{ t('auth.signup.subtitle') }}</p>
            </div>

            <form @submit.prevent="submit">
                <div class="form-group">
                    <InputLabel for="name" :value="t('auth.signup.username_label')" class="label" />
                    <TextInput
                        id="name"
                        type="text"
                        class="input"
                        v-model="form.name"
                        required
                        autofocus
                        autocomplete="name"
                        :placeholder="t('auth.signup.username_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.name" />
                </div>

                <div class="form-group">
                    <InputLabel for="email" :value="t('auth.signup.email_label')" class="label" />
                    <TextInput
                        id="email"
                        type="email"
                        class="input"
                        v-model="form.email"
                        required
                        autocomplete="username"
                        :placeholder="t('auth.signup.email_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.email" />
                </div>

                <div class="form-group">
                    <InputLabel for="password" :value="t('auth.signup.password_label')" class="label" />
                    <TextInput
                        id="password"
                        type="password"
                        class="input"
                        v-model="form.password"
                        required
                        autocomplete="new-password"
                        :placeholder="t('auth.signup.password_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.password" />
                </div>

                <div class="form-group">
                    <InputLabel for="password_confirmation" :value="t('auth.signup.confirm_password_label')" class="label" />
                    <TextInput
                        id="password_confirmation"
                        type="password"
                        class="input"
                        v-model="form.password_confirmation"
                        required
                        autocomplete="new-password"
                        :placeholder="t('auth.signup.confirm_password_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.password_confirmation" />
                </div>

                <PrimaryButton
                    class="register-button"
                    :class="{ 'disabled': form.processing }"
                    :disabled="form.processing"
                >
                    <span v-if="!form.processing">{{ t('auth.signup.register_button') }}</span>
                    <span v-else class="loading-spinner"></span>
                </PrimaryButton>
            </form>

            <div class="signup-text">
                {{ t('auth.signup.already_have_account') }}
                <Link href="/login" class="signup-link">{{ t('auth.signup.login_link') }}</Link>
            </div>
        </div>
    </div>
</template>

<style scoped>
.register-container {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    padding: 2rem;
    position: relative;
}

.go-back-arrow {
    position: fixed;
    top: 2rem;
    left: 2rem;
    cursor: pointer;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(8px);
    border-radius: 50%;
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.1);
    z-index: 10;
}

.go-back-arrow:hover {
    background: white;
    transform: translateX(-4px);
    box-shadow: 0 6px 16px rgba(12, 75, 170, 0.15);
}

.arrow-icon {
    font-size: 1.5rem;
    color: #0c4baa;
    font-weight: 500;
}

.register-card {
    width: 100%;
    max-width: 460px;
    background: white;
    border-radius: 32px;
    padding: 2.5rem;
    box-shadow: 0 20px 40px rgba(12, 75, 170, 0.12);
    transition: transform 0.3s ease;
    animation: fadeInUp 0.5s ease-out;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.register-header {
    text-align: center;
    margin-bottom: 2rem;
}

.logo-container {
    display: flex;
    justify-content: center;
    margin-bottom: 1rem;
}

.logo {
    height: 64px;
    width: auto;
    padding-right: 40px;
}

.register-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #0c4baa;
    margin-bottom: 0.5rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.register-subtitle {
    font-size: 0.9rem;
    color: #64748b;
    margin: 0;
}

.form-group {
    margin-bottom: 1.25rem;
}

.label {
    display: block;
    font-size: 0.85rem;
    font-weight: 500;
    color: #334155;
    margin-bottom: 0.5rem;
}

.input {
    width: 100%;
    padding: 0.75rem 1rem;
    background: #f8fafc;
    border: 1.5px solid #e2e8f0;
    border-radius: 12px;
    font-size: 0.95rem;
    color: #1e293b;
    transition: all 0.2s ease;
}

.input:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
    background: white;
}

.input::placeholder {
    color: #94a3b8;
}

.error-text {
    color: #ef4444;
    font-size: 0.75rem;
    margin-top: 0.5rem;
    display: block;
}

.register-button {
    width: 100%;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    color: white;
    font-weight: 600;
    font-size: 1rem;
    padding: 0.875rem;
    border-radius: 40px;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.register-button:hover:not(.disabled) {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(12, 75, 170, 0.25);
}

.register-button.disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
}

.loading-spinner {
    width: 20px;
    height: 20px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-top-color: white;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.signup-text {
    margin-top: 1.5rem;
    text-align: center;
    font-size: 0.85rem;
    color: #64748b;
}

.signup-link {
    color: #0c4baa;
    font-weight: 600;
    text-decoration: none;
    margin-left: 0.25rem;
    transition: color 0.2s;
}

.signup-link:hover {
    color: #20c1f7;
    text-decoration: underline;
}

/* Responsivitāte */
@media (max-width: 640px) {
    .register-container {
        padding: 1rem;
    }

    .register-card {
        padding: 1.75rem;
        border-radius: 24px;
    }

    .go-back-arrow {
        top: 1rem;
        left: 1rem;
        width: 36px;
        height: 36px;
    }

    .arrow-icon {
        font-size: 1.2rem;
    }

    .register-title {
        font-size: 1.5rem;
    }

    .logo {
        height: 52px;
    }
}

@media (max-width: 480px) {
    .register-card {
        padding: 1.5rem;
    }

    .form-group {
        margin-bottom: 1rem;
    }

    .input {
        padding: 0.65rem 0.875rem;
    }
}

</style>
