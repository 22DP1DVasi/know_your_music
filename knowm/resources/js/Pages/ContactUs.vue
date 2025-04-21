<template>
    <Head title="Contact Us" />
    <Navbar />
    <div class="contact-container">
        <div class="contact-box">
            <!-- Go-back arrow -->
            <div class="go-back-arrow" @click="goBack">
                <span class="arrow-icon">←</span>
            </div>

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
                <div class="info-grid">
                    <div class="info-item">
                        <span class="icon">✉️</span>
                        <div>
                            <h4>Email</h4>
                            <p>knowyourmusicsupprort@gmail.com</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="icon">📱</span>
                        <div>
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
                // Add success message here
            }
        }
    })
};

const goBack = () => {
    window.history.back()
}
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
    font-size: 24px;
    color: #0c4baa;
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

select.input {
    appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 1em;
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

.info-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
}

.info-item {
    display: flex;
    align-items: center;
    gap: 15px;
}

.icon {
    font-size: 24px;
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

    .info-grid {
        grid-template-columns: 1fr;
    }
}
</style>
