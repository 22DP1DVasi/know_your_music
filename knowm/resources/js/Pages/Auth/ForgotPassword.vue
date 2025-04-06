<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

/* VUE 3 properties for status message (e.g. success message after resetting password */
defineProps({
    status: String,
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};

const goBack = () => {
    window.history.back();
};
</script>

<template>
    <Head title="Forgot Password" />
    <div class="main-container">
        <!-- go-back arrow -->
        <div class="go-back-arrow" @click="goBack">
            <span class="arrow-icon">←</span>
        </div>

        <!-- box for form fields -->
        <div class="forgot-password-box">
            <div class="logo-container">
                <img src="../../../../public/images/mini-logo.png" alt="App Logo" class="logo">
            </div>

            <h2 class="reset-password-title">Reload Your Beat</h2>

            <div class="forgot-password-text">
                Forgot your password? No problem. Just enter your email address and we'll email you a password reset link.
            </div>

            <div v-if="status" class="status-message">
                {{ status }}
            </div>

            <form @submit.prevent="submit">
                <div>
                    <InputLabel for="email" value="Email" class="label" />
                    <TextInput
                        id="email"
                        type="email"
                        class="input"
                        v-model="form.email"
                        required
                        autofocus
                        autocomplete="username"
                    />
                    <InputError class="error-text" :message="form.errors.email" />
                </div>

                <div class="submit-button">
                    <PrimaryButton
                        class="reset-password-button"
                        :class="{ 'disabled': form.processing }"
                        :disabled="form.processing"
                    >
                        Email Password Reset Link
                    </PrimaryButton>
                </div>
            </form>

            <div class="signup-text">
                Remember your password?
                <Link href="/login" class="signup-link">Log in</Link>
            </div>
        </div>
    </div>
</template>

<style scoped>
.main-container {
    display: flex;
    min-height: 90vh;
    align-items: center;
    justify-content: center;
    background-image: linear-gradient(to right, #ffffff, #b3eaff);
}

.go-back-arrow {
    position: absolute;
    top: 20px;
    left: 20px;
    cursor: pointer;
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 50%;
    padding: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.2s ease;
}

.arrow-icon {
    font-size: 24px;
    color: #0c4baa;
    display: inline-block;
}

.forgot-password-box {
    width: 100%;
    max-width: 400px;
    background-color: rgb(185, 225, 255);
    padding: 32px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.logo-container {
    display: flex;
    justify-content: center;
    margin-bottom: 24px;
    margin-right: 10px;
}

.logo {
    height: 48px;
}

.reset-password-title {
    text-align: center;
    color: #000000;
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 16px;
}

.forgot-password-text {
    text-align: center;
    color: #000000;
    margin-bottom: 24px;
    font-size: 16px;
    line-height: 1.4;
}

.status-message {
    text-align: center;
    color: #2ecc71;
    margin-bottom: 16px;
    font-size: 14px;
}

.label {
    display: block;
    color: #000000;
    font-size: 14px;
    margin-bottom: 6px;
}

.input {
    width: 100%;
    padding: 10px;
    background-color: #ffffff;
    border: 5px solid #b0ddff !important;
    border-radius: 6px;
    color: #000000;
}

.input:focus {
    outline: none !important;
    box-shadow: none !important;
}

.error-text {
    color: #ef4444;
    font-size: 12px;
    margin-top: 6px;
}

.submit-button {
    margin-top: 24px;
}

.reset-password-button {
    width: 100%;
    background-color: #0c4baa;
    color: #ffffff;
    font-weight: bold;
    padding: 12px;
    border-radius: 6px;
    text-align: center;
    transition: background 0.2s;
    justify-content: center;
}

.reset-password-button:hover {
    background-color: #06419a;
}

.disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.signup-text {
    margin-top: 16px;
    text-align: center;
    color: black;
    font-size: 14px;
}

.signup-link {
    color: #0c4baa;
    text-decoration: none;
}

.signup-link:hover {
    text-decoration: underline;
}
</style>
