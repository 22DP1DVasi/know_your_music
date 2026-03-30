<script setup>
import { Head, useForm } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import InputLabel from '@/Components/InputLabel.vue'
import TextInput from '@/Components/TextInput.vue'
import InputError from '@/Components/InputError.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'
import { route } from "ziggy-js";
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

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

<template>
    <Head :title="t('info_pages.contactus.page_title')" />
    <Navbar />
    <div class="contact-container">
        <div class="contact-card">
            <div class="contact-header">
                <div class="logo-container">
                    <img src="/images/mini-logo.png" alt="Know Your Music Logo" class="logo">
                </div>
                <h1 class="contact-title">{{ t('info_pages.contactus.title') }}</h1>
                <p class="contact-subtitle">{{ t('info_pages.contactus.subtitle') }}</p>
                <div class="hero-decoration"></div>
            </div>

            <form @submit.prevent="submitForm" class="contact-form">
                <div class="form-group">
                    <InputLabel for="name" :value="t('info_pages.contactus.name_label')" class="label" />
                    <TextInput
                        id="name"
                        type="text"
                        class="input"
                        v-model="form.name"
                        required
                        :placeholder="t('info_pages.contactus.name_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.name" />
                </div>

                <div class="form-group">
                    <InputLabel for="email" :value="t('info_pages.contactus.email_label')" class="label" />
                    <TextInput
                        id="email"
                        type="email"
                        class="input"
                        v-model="form.email"
                        required
                        :placeholder="t('info_pages.contactus.email_placeholder')"
                    />
                    <InputError class="error-text" :message="form.errors.email" />
                </div>

                <div class="form-group">
                    <InputLabel for="message" :value="t('info_pages.contactus.message_label')" class="label" />
                    <textarea
                        id="message"
                        class="input textarea"
                        v-model="form.message"
                        rows="5"
                        required
                        :placeholder="t('info_pages.contactus.message_placeholder')"
                    ></textarea>
                    <InputError class="error-text" :message="form.errors.message" />
                </div>

                <PrimaryButton
                    class="contact-button"
                    :class="{ 'disabled': form.processing }"
                    :disabled="form.processing"
                >
                    <span v-if="!form.processing">{{ t('info_pages.contactus.send_button') }}</span>
                    <span v-else class="loading-spinner"></span>
                </PrimaryButton>
            </form>

            <div class="contact-info">
                <h3>{{ t('info_pages.contactus.other_ways_title') }}</h3>
                <div class="info-grid">
                    <div class="info-card">
                        <div class="info-icon">✉️</div>
                        <div class="info-content">
                            <h4>{{ t('info_pages.contactus.email_title') }}</h4>
                            <a href="mailto:kymsupport@gmail.com">kymsupport@gmail.com</a>
                        </div>
                    </div>
                    <div class="info-card">
                        <div class="info-icon">📱</div>
                        <div class="info-content">
                            <h4>{{ t('info_pages.contactus.social_title') }}</h4>
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

<style scoped>
.contact-container {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    background: linear-gradient(135deg, #ffffff 0%, #b3eaff 100%);
    padding: 2rem;
}

.contact-card {
    width: 100%;
    max-width: 600px;
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

.contact-header {
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
}

.contact-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #0c4baa;
    margin-bottom: 0.5rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.contact-subtitle {
    font-size: 0.9rem;
    color: #64748b;
    margin: 0;
}

.hero-decoration {
    margin-top: 1rem;
    width: 60px;
    height: 3px;
    background: linear-gradient(90deg, #0c4baa, #20c1f7);
    border-radius: 3px;
    margin-left: auto;
    margin-right: auto;
}

.contact-form {
    margin-bottom: 2rem;
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
    font-family: inherit;
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

.textarea {
    resize: vertical;
    min-height: 120px;
}

.error-text {
    color: #ef4444;
    font-size: 0.75rem;
    margin-top: 0.5rem;
    display: block;
}

.contact-button {
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
    margin-top: 0.5rem;
}

.contact-button:hover:not(.disabled) {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(12, 75, 170, 0.25);
}

.contact-button.disabled {
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

.contact-info {
    border-top: 1px solid #eef2f6;
    padding-top: 1.5rem;
}

.contact-info h3 {
    text-align: center;
    font-size: 1rem;
    font-weight: 600;
    color: #0c4baa;
    margin-bottom: 1.25rem;
}

.info-grid {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.info-card {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem;
    background: #f8fafc;
    border-radius: 16px;
    transition: all 0.2s ease;
}

.info-card:hover {
    background: #f1f5f9;
    transform: translateX(4px);
}

.info-icon {
    font-size: 1.75rem;
    flex-shrink: 0;
}

.info-content {
    flex: 1;
}

.info-content h4 {
    font-size: 0.85rem;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 0.25rem;
}

.info-content a {
    color: #0c4baa;
    font-size: 0.9rem;
    text-decoration: none;
    transition: color 0.2s;
    word-break: break-all;
}

.info-content a:hover {
    color: #20c1f7;
    text-decoration: underline;
}

.social-links {
    display: flex;
    gap: 1rem;
    margin-top: 0.25rem;
}

.social-links a {
    color: #64748b;
    font-size: 1.25rem;
    transition: all 0.2s ease;
}

.social-links a:hover {
    color: #0c4baa;
    transform: translateY(-2px);
}

/* Responsivitāte */
@media (max-width: 640px) {
    .contact-container {
        padding: 1rem;
    }

    .contact-card {
        padding: 1.75rem;
        border-radius: 24px;
    }

    .contact-title {
        font-size: 1.5rem;
    }

    .logo {
        height: 52px;
    }

    .info-card {
        padding: 0.875rem;
    }

    .info-icon {
        font-size: 1.5rem;
    }
}

@media (max-width: 480px) {
    .contact-card {
        padding: 1.5rem;
    }

    .form-group {
        margin-bottom: 1rem;
    }

    .input {
        padding: 0.65rem 0.875rem;
    }

    .info-card {
        flex-direction: column;
        text-align: center;
        gap: 0.5rem;
    }

    .info-icon {
        font-size: 1.75rem;
    }

    .social-links {
        justify-content: center;
    }
}

</style>
