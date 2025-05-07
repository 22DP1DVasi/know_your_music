<template>
    <Head title="Privacy Policy" />
    <Navbar />
    <main class="flex-1">
        <div class="privacy-container">
            <div class="privacy-header">
                <h1>Privacy Policy</h1>
                <p class="policy-update">
                    <em>Last updated: May 2024</em>
                </p>
            </div>

            <div class="privacy-content">
                <section class="privacy-section">
                    <p class="intro-text">
                        Your privacy matters to us at <b>Know Your Music</b>. This policy explains what information we collect,
                        how we use it, and your rights regarding your personal data.
                    </p>
                </section>

                <section class="privacy-section">
                    <h2>What We Collect</h2>
                    <p style="margin-bottom: 10px;">We only gather the info needed to make Know Your Music work smoothly:</p>
                    <ul class="policy-list">
                        <li><strong>Basic account data:</strong> Username, email, and password (hashed for security).</li>
                        <li><strong>Music preferences:</strong> Artists you follow, tracks you save, and searches to improve recommendations.</li>
                        <li><strong>Cookies:</strong> To remember your login and settings (you can disable these in your browser).</li>
                    </ul>
                </section>

                <section class="privacy-section">
                    <h2>How We Use It</h2>
                    <ul class="policy-list">
                        <li>To personalize your experience (e.g., recommend music you might like).</li>
                        <li>To let you comment, create collections, and interact with others.</li>
                        <li>To fix bugs and improve the site (we use anonymized analytics).</li>
                    </ul>
                </section>

                <section class="privacy-section">
                    <h2>What We Don't Do</h2>
                    <ul class="policy-list">
                        <li>Sell your data to third parties.</li>
                        <li>Spam you — we'll only email you for important updates (like password resets).</li>
                    </ul>
                </section>

                <section class="privacy-section">
                    <h2>Your Rights</h2>
                    <ul class="policy-list">
                        <li>Delete your account anytime.</li>
                        <li>Opt out of cookies (though some features might break).</li>
                        <li>Request your data (we'll send you a copy).</li>
                    </ul>
                </section>

                <section class="privacy-section contact-section">
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
.privacy-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 40px 20px;
    color: #333;
}

.privacy-header {
    text-align: center;
    margin-bottom: 30px;
}

.privacy-header h1 {
    font-size: 2.5rem;
    color: #0c4baa;
    margin-bottom: 10px;
}

.privacy-header .policy-update {
    text-align: left;
    font-size: 0.9rem;
    color: #666;
}

.privacy-section {
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
}

.policy-list {
    list-style-type: none;
    padding-left: 0;
    font-size: 1.1rem;
    line-height: 1.6;
}

.policy-list li {
    margin-bottom: 15px;
    padding-left: 25px;
    position: relative;
}

.policy-list li:before {
    content: "•";
    color: #0c4baa;
    font-size: 1.5rem;
    position: absolute;
    left: 0;
    top: -3px;
}

.contact-section {
    background-color: rgba(100, 183, 255, 0.3);
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
    .privacy-header h1 {
        font-size: 2rem;
    }

    .privacy-container {
        padding: 30px 15px;
    }

    .privacy-section {
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
