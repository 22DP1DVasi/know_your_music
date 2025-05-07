<template>
    <Head title="Terms of Service" />
    <Navbar />
    <main class="flex-1">
        <div class="terms-container">
            <div class="terms-header">
                <h1>Terms of Service</h1>
                <p class="terms-update">Last Updated: May 2024</p>
            </div>

            <div class="terms-content">
                <section class="terms-section">
                    <p class="intro-text">
                        These terms outline the rules for using our service. By accessing our site, you agree to these conditions.
                    </p>
                </section>

                <section class="terms-section">
                    <h2><span class="section-number">1.</span> Your Account</h2>
                    <ul class="terms-list">
                        <li>You're responsible for keeping your login info secure.</li>
                        <li>No fake names, spam, or impersonation — keep it real.</li>
                        <li>We can suspend accounts that break these rules.</li>
                    </ul>
                </section>

                <section class="terms-section">
                    <h2><span class="section-number">2.</span> Your Content</h2>
                    <ul class="terms-list">
                        <li>Comments/edits must be respectful and accurate. No hate speech or misinformation.</li>
                        <li>By posting, you allow us to display it on Know Your Music (but you still own your words).</li>
                        <li>Don't upload illegal content (we'll remove it).</li>
                    </ul>
                </section>

                <section class="terms-section">
                    <h2><span class="section-number">3.</span> Copyright</h2>
                    <ul class="terms-list">
                        <li>We don't host actual music files — just info about music (lyrics, artist details, etc.).</li>
                        <li>If you think something violates copyright, email us at
                            <a href="mailto:knowyourmusicsupprort@gmail.com">knowyourmusicsupprort@gmail.com</a>.
                        </li>
                    </ul>
                </section>

                <section class="terms-section">
                    <h2><span class="section-number">4.</span> Our Rules</h2>
                    <ul class="terms-list">
                        <li>Don't break the site (no hacking, scraping, or bots).</li>
                        <li>Admins can edit/remove content to keep things accurate.</li>
                    </ul>
                </section>

                <section class="terms-section">
                    <h2><span class="section-number">5.</span> Disclaimer</h2>
                    <ul class="terms-list">
                        <li>Music data comes from users and APIs. We try our best to keep information accurate and up to date.</li>
                    </ul>
                </section>

                <section class="terms-section contact-section">
                    <h2>Questions?</h2>
                    <p>
                        Visit our <a href="/contact">Contact Us</a> page or email us at <a href="mailto:knowyourmusicsupprort@gmail.com">knowyourmusicsupprort@gmail.com</a> — we're happy to explain anything!
                    </p>
                </section>
            </div>
        </div>
    </main>
    <Footer />
</template>

<script setup>
import { Head } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
</script>

<style scoped>
.terms-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 40px 20px;
    color: #333;
}

.terms-header {
    text-align: center;
    margin-bottom: 30px;
}

.terms-header h1 {
    font-size: 2.5rem;
    color: #0c4baa;
    margin-bottom: 10px;
}

.terms-header .terms-update {
    text-align: left;
    font-size: 0.9rem;
    color: #666;
}

.terms-section {
    margin-bottom: 40px;
}

.intro-text {
    font-size: 1.2rem;
    line-height: 1.6;
    text-align: center;
    max-width: 800px;
    margin: 0 auto 30px;
}

h2 {
    color: #0c4baa;
    font-size: 1.8rem;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 2px solid #b0ddff;
    display: flex;
    align-items: center;
}

.section-number {
    margin-right: 10px;
    color: #06419a;
}

.terms-list {
    list-style-type: none;
    padding-left: 0;
    font-size: 1.1rem;
    line-height: 1.6;
}

.terms-list li {
    margin-bottom: 15px;
    padding-left: 25px;
    position: relative;
}

.terms-list li:before {
    content: "•";
    color: #0c4baa;
    font-size: 1.5rem;
    position: absolute;
    left: 0;
    top: -3px;
}

.contact-section {
    background-color: rgba(185, 225, 255, 0.3);
    padding: 30px;
    border-radius: 10px;
    text-align: center;
}

.contact-section a {
    color: #0c4baa;
    font-weight: bold;
    text-decoration: none;
    word-break: break-word;
}

.contact-section a:hover {
    text-decoration: underline;
}

@media (max-width: 768px) {
    .terms-header h1 {
        font-size: 2rem;
    }

    .terms-container {
        padding: 30px 15px;
    }

    .terms-section {
        margin-bottom: 30px;
    }

    h2 {
        font-size: 1.5rem;
    }
}

@media (max-width: 360px) {
    .contact-section {
        font-size: 0.8rem;
    }
}

</style>
