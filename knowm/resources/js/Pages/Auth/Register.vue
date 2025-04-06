<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { debounce } from 'lodash';

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

// go back to the previous page
const goBack = () => {
    window.history.back();
};

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
            // Validation error (invalid email format)
            emailExists.value = false;
        } else {
            console.error('Email check failed:', error);
            // Optional: show user-friendly error
        }
    } finally {
        checkingEmail.value = false;
    }
}, 500);
</script>

<template>
    <Head title="Register Signup" />
    <div class="register-container">
        <!-- go-back arrow -->
        <div class="go-back-arrow" @click="goBack">
            <span class="arrow-icon text-3xl">←</span>
        </div>

        <!-- box for logo and fields -->
        <div class="register-box">
            <div class="logo-container">
                <img src="../../../../public/images/mini-logo.png" alt="App Logo" class="logo">
            </div>

            <h2 class="register-title">Press Play on Your Journey</h2>

            <!-- Registration form -->
            <form @submit.prevent="submit">
                <div>
                    <InputLabel for="name" value="Userame" class="label" />
                    <TextInput
                        id="name"
                        type="text"
                        class="input"
                        v-model="form.name"
                        required
                        autofocus
                        autocomplete="name"
                    />
                    <InputError class="error-text" :message="form.errors.name" />
                </div>
                <br>

                <div>
                    <InputLabel for="email" value="Email" class="label" />
                    <TextInput
                        id="email"
                        type="email"
                        class="input"
                        v-model="form.email"
                        required
                        autocomplete="username"
                    />
                    <InputError class="error-text" :message="form.errors.email" />
                </div>
                <br>

                <div>
                    <InputLabel for="password" value="Password" class="label" />
                    <TextInput
                        id="password"
                        type="password"
                        class="input"
                        v-model="form.password"
                        required
                        autocomplete="new-password"
                    />
                    <InputError class="error-text" :message="form.errors.password" />
                </div>
                <br>

                <div>
                    <InputLabel for="password_confirmation" value="Confirm Password" class="label" />
                    <TextInput
                        id="password_confirmation"
                        type="password"
                        class="input"
                        v-model="form.password_confirmation"
                        required
                        autocomplete="new-password"
                    />
                    <InputError class="error-text" :message="form.errors.password_confirmation" />
                </div>


                <div class="form-footer">
                    <Link
                        :href="route('login')"
                        class="forgot-password"
                    >
                        Already registered?
                    </Link>
                </div>

                <div class="submit-button">
                    <PrimaryButton
                        class="register-button"
                        :class="{ 'disabled': form.processing }"
                        :disabled="form.processing"
                    >
                        Register
                    </PrimaryButton>
                </div>
            </form>

            <div class="signup-text">
                Already have an account?
                <Link href="/login" class="signup-link">Log in</Link>
            </div>
        </div>
    </div>
</template>

<style>
.register-container {
    display: flex;
    min-height: 90vh;
    align-items: center;
    justify-content: center;
    background-image: linear-gradient(to right, #ffffff, #b3eaff);
}

/* go-back arrow */
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

.go-back-arrow:hover {
    background-color: rgba(255, 255, 255, 1);
}

.arrow-icon {
    width: 24px;
    height: 24px;
    color: #0c4baa; /* Match the color scheme */
}

.register-box {
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

.register-title {
    text-align: center;
    color: #000000;
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 6px;
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
    align-items: center;
    margin-top: 16px;
    margin-bottom: 10px;
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

.register-button {
    width: 100%;
    background-color: #0c4baa;
    color: #ffffff;
    font-weight: bold;
    padding: 12px;
    border-radius: 6px;
    transition: background 0.2s;
    justify-content: center;
}

.register-button:hover {
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
