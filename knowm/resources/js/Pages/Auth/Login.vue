<template>
    <Head title="Log in" />
    <div class="login-container">
        <div class="go-back-arrow" @click="goBack">
            <span class="arrow-icon text-3xl">←</span>
        </div>

        <div class="login-box">
            <div class="logo-container">
                <img src="../../../../public/images/mini-logo.png" alt="App Logo" class="logo">
            </div>

            <h2 class="login-title">Find Your Groove Again</h2>
            <!-- Registration with social media, WIP -->
            <!--                <div class="social-buttons">-->
            <!--                    <button class="social-button">-->
            <!--                        <img src="/icons/google.svg" alt="Google" class="social-icon"> Continue with Google-->
            <!--                    </button>-->
            <!--                    <button class="social-button">-->
            <!--                        <img src="/icons/facebook.svg" alt="Facebook" class="social-icon"> Continue with Facebook-->
            <!--                    </button>-->
            <!--                    <button class="social-button">-->
            <!--                        <img src="/icons/apple.svg" alt="Apple" class="social-icon"> Continue with Apple-->
            <!--                    </button>-->
            <!--                </div>-->

            <!--                <div class="separator">-->
            <!--                    <hr class="line">-->
            <!--                    <span class="or-text">or</span>-->
            <!--                    <hr class="line">-->
            <!--                </div>-->

            <form @submit.prevent="submit">
                <div>
                    <InputLabel for="login" value="Username or Email" class="label" />
                    <TextInput
                        id="login"
                        type="text"
                        class="input"
                        v-model="form.login"
                        required
                        autofocus
                        autocomplete="username"
                    />
                    <InputError class="error-text" :message="form.errors.login" />
                </div>
                <br>

                <div class="form-group">
                    <InputLabel for="password" value="Password" class="label" />
                    <TextInput
                        id="password"
                        type="password"
                        class="input"
                        v-model="form.password"
                        required
                        autocomplete="current-password"
                    />
                    <InputError class="error-text" :message="form.errors.password" />
                </div>

                <div class="form-footer">
                    <label class="remember-me">
                        <Checkbox name="remember" v-model:checked="form.remember" />
                        <span>Remember me</span>
                    </label>
                    <Link
                        v-if="canResetPassword"
                        :href="route('password.request')"
                        class="forgot-password"
                    >
                        Forgot your password?
                    </Link>
                </div>

                <div class="submit-button">
                    <PrimaryButton
                        class="login-button"
                        :class="{ 'disabled': form.processing }"
                        :disabled="form.processing"
                    >
                        Log in
                    </PrimaryButton>
                </div>
            </form>

            <div class="signup-text">
                Don't have an account?
                <Link href="/signup" class="signup-link">Sign up</Link>
            </div>
        </div>
    </div>
</template>

<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

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

<style>
.login-container {
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
    width: 24px;
    height: 24px;
    color: #0c4baa;
}

.login-box {
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

.login-title {
    text-align: center;
    color: #000000;
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 6px;
}

.social-buttons {
    margin-top: 24px;
}

.social-button {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    background-color: transparent;
    border: 1px solid #4b5563;
    border-radius: 6px;
    color: #000000;
    cursor: pointer;
    transition: background 0.2s;
}

.social-button:hover {
    background-color: #374151;
}

.social-icon {
    height: 18px;
    width: 18px;
    margin-right: 10px;
}

.separator {
    display: flex;
    align-items: center;
    margin: 24px 0;
}

.line {
    flex-grow: 1;
    border: none;
    height: 1px;
    background-color: #4b5563;
}

.or-text {
    margin: 0 10px;
    color: #9ca3af;
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

.form-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 16px;
    margin-bottom: 10px;
}

.remember-me {
    display: flex;
    align-items: center;
    color: #ffffff;
    font-size: 14px;
}

.remember-me, span {
    margin-left: 5px;
    color: black;
}

.forgot-password {
    font-size: 14px;
    color: #0c4baa;
    text-decoration: none;
}

.forgot-password:hover {
    text-decoration: underline;
}

.submit-button {
    margin-top: 24px;
}

.login-button {
    width: 100%;
    background-color: #0c4baa;
    color: #ffffff;
    font-weight: bold;
    padding: 12px;
    border-radius: 6px;
    text-align: center;
    transition: background 0.2s;
    display: flex;
    justify-content: center;
}

.login-button:hover {
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
