<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { route } from "ziggy-js";
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    login: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};

const goBack = () => {
    window.history.back();
};

</script>

<template>
    <Head :title="t('auth.login.page_title')" />
    <div class="login-container">
        <div class="go-back-arrow" @click="goBack">
            <span class="arrow-icon">←</span>
        </div>

        <div class="login-card">
            <div class="login-header">
                <div class="logo-container">
                    <img src="/images/mini-logo.png" alt="App Logo" class="logo">
                </div>
                <h1 class="login-title">{{ t('auth.login.title') }}</h1>
                <p class="login-subtitle">{{ t('auth.login.subtitle') }}</p>
            </div>

            <form @submit.prevent="submit">
                <div class="form-group">
                    <InputLabel for="login" :value="t('auth.login.username_email_label')" class="label" />
                    <TextInput
                        id="login"
                        type="text"
                        class="input"
                        v-model="form.login"
                        required
                        autofocus
                        autocomplete="username"
                        :placeholder="t('auth.login.username_email_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.login" />
                </div>

                <div class="form-group">
                    <InputLabel for="password" :value="t('auth.login.password_label')" class="label" />
                    <TextInput
                        id="password"
                        type="password"
                        class="input"
                        v-model="form.password"
                        required
                        autocomplete="current-password"
                        :placeholder="t('auth.login.password_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.password" />
                </div>

                <div class="form-footer">
                    <label class="remember-me">
                        <Checkbox name="remember" v-model:checked="form.remember" />
                        <span>{{ t('auth.login.remember_me') }}</span>
                    </label>
                    <Link
                        v-if="canResetPassword"
                        :href="route('password.request')"
                        class="forgot-password"
                    >
                        {{ t('auth.login.forgot_password') }}
                    </Link>
                </div>

                <PrimaryButton
                    class="login-button"
                    :class="{ 'disabled': form.processing }"
                    :disabled="form.processing"
                >
                    <span v-if="!form.processing">{{ t('auth.login.login_button') }}</span>
                    <span v-else class="loading-spinner"></span>
                </PrimaryButton>
            </form>

            <div class="signup-text">
                {{ t('auth.login.no_account') }}
                <Link :href="route('signup')" class="signup-link">{{ t('auth.login.signup_link') }}</Link>
            </div>
        </div>
    </div>
</template>

<style scoped>
.login-container {
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

.login-card {
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

.login-header {
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

.login-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #0c4baa;
    margin-bottom: 0.5rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.login-subtitle {
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

.form-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 0.5rem;
    margin-bottom: 1.5rem;
}

.remember-me {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-size: 0.85rem;
    color: #475569;
}

.remember-me span {
    margin-left: 0.5rem;
}

.forgot-password {
    font-size: 0.85rem;
    color: #0c4baa;
    text-decoration: none;
    transition: color 0.2s;
}

.forgot-password:hover {
    color: #20c1f7;
    text-decoration: underline;
}

.login-button {
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

.login-button:hover:not(.disabled) {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(12, 75, 170, 0.25);
}

.login-button.disabled {
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
    .login-container {
        padding: 1rem;
    }

    .login-card {
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

    .login-title {
        font-size: 1.5rem;
    }

    .logo {
        height: 52px;
    }

    .form-footer {
        flex-direction: column;
        gap: 0.75rem;
        align-items: flex-start;
    }
}

@media (max-width: 480px) {
    .login-card {
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
