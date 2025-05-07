<template>
    <Head title="Contact Us" />
    <Navbar />
    <div class="contact-container">
        <div class="contact-box">
            <div class="logo-container">
                <img src="../../../public/images/mini-logo.png" alt="Know Your Music Logo" class="logo">
            </div>

            <h1 class="contact-title">Contact Us</h1>
            <p class="contact-subtitle">Have questions or feedback? We'd love to hear from you!</p>

            <form @submit.prevent="submitForm" class="contact-form">
                <div class="form-group">
                    <InputLabel for="name" value="Your Name" class="label" />
                    <TextInput
                        id="name"
                        type="text"
                        class="input"
                        v-model="form.name"
                        required
                    />
                    <InputError class="error-text" :message="form.errors.name" />
                </div>

                <div class="form-group">
                    <InputLabel for="email" value="Email Address" class="label" />
                    <TextInput
                        id="email"
                        type="email"
                        class="input"
                        v-model="form.email"
                        required
                    />
                    <InputError class="error-text" :message="form.errors.email" />
                </div>

                <div class="form-group">
                    <InputLabel for="message" value="Your Message" class="label" />
                    <textarea
                        id="message"
                        class="input"
                        v-model="form.message"
                        rows="5"
                        required
                    ></textarea>
                    <InputError class="error-text" :message="form.errors.message" />
                </div>

                <div class="submit-button">
                    <PrimaryButton
                        class="contact-button"
                        :class="{ 'disabled': form.processing }"
                        :disabled="form.processing"
                    >
                        Send Message
                    </PrimaryButton>
                </div>
            </form>

            <div class="contact-info">
                <h3>Other Ways to Reach Us</h3>
                <div class="info-container">
                    <div class="info-item">
                        <span class="icon">✉️</span>
                        <div class="info-content">
                            <h4>Email</h4>
                            <a href="mailto:knowyourmusicsupprort@gmail.com">knowyourmusicsupprort@gmail.com</a>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">📱</span>
                        <div class="info-content">
                            <h4>Social Media</h4>
                            <div class="social-links">
                                <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                                <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                                <a href="#" aria-label="Facebook"><i class="fab fa-facebook"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <Footer />
</template>

<script setup>
import { Head, useForm } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import InputLabel from '@/Components/InputLabel.vue'
import TextInput from '@/Components/TextInput.vue'
import InputError from '@/Components/InputError.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'

const form = useForm({
    name: '',
    email: '',
    message: ''
})

const submitForm = () => {
    form.post(route('contact.submit'), {
        onFinish: () => {
            if (!form.hasErrors()) {
                form.reset()
                // to do - success message
            }
        }
    })
};

</script>

<style scoped>
.contact-container {
    display: flex;
    min-height: 90vh;
    align-items: center;
    justify-content: center;
    background-image: linear-gradient(to right, #ffffff, #b3eaff);
    padding: 40px 20px;
}

.contact-box {
    width: 100%;
    max-width: 600px;
    background-color: rgb(185, 225, 255);
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    position: relative;
}

.logo-container {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.logo {
    height: 48px;
}

.contact-title {
    text-align: center;
    color: #0c4baa;
    font-size: 2rem;
    margin-bottom: 10px;
}

.contact-subtitle {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
    font-size: 1.1rem;
}

.contact-form {
    margin-bottom: 40px;
}

.form-group {
    margin-bottom: 20px;
}

.label {
    display: block;
    color: #000;
    font-size: 14px;
    margin-bottom: 6px;
}

.input {
    width: 100%;
    padding: 12px;
    background-color: #fff;
    border: 5px solid #b0ddff !important;
    border-radius: 6px;
    font-family: inherit;
    font-size: 16px;
}

.input:focus {
    outline: none;
    box-shadow: none;
}

textarea.input {
    resize: vertical;
    min-height: 120px;
}

.error-text {
    color: #ef4444;
    font-size: 12px;
    margin-top: 6px;
}

.submit-button {
    margin-top: 30px;
}

.contact-button {
    width: 100%;
    background-color: #0c4baa;
    color: #fff;
    font-weight: bold;
    padding: 12px;
    border-radius: 6px;
    transition: background 0.2s;
}

.contact-button:hover {
    background-color: #06419a;
}

.disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.contact-info {
    border-top: 1px solid rgba(0, 0, 0, 0.1);
    padding-top: 30px;
}

.contact-info h3 {
    text-align: center;
    color: #0c4baa;
    margin-bottom: 20px;
}

.info-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.info-item {
    display: flex;
    align-items: flex-start;
    gap: 15px;
}

.info-content {
    flex: 1;
}

.info-content a {
    color: #0c4baa;
    font-weight: bold;
    text-decoration: none;
}

.info-content a:hover {
    text-decoration: underline;
}

.icon {
    font-size: 24px;
    margin-top: 3px;
}

.info-item h4 {
    color: #06419a;
    margin-bottom: 5px;
}

.social-links {
    display: flex;
    gap: 15px;
}

.social-links a {
    color: #333;
    font-size: 20px;
    transition: color 0.3s;
}

.social-links a:hover {
    color: #0c4baa;
}

@media (max-width: 768px) {
    .contact-box {
        padding: 30px 20px;
    }

    .info-item {
        flex-direction: column;
        gap: 10px;
    }

    .icon {
        align-self: center;
    }
}
</style>
