<template>
    <Head title="Community Guidelines" />
    <Navbar />
    <main class="flex-1">
        <div class="guidelines-container">
            <div class="guidelines-header">
                <h1>Community Guidelines</h1>
                <p class="update-date">Last Updated: May 2024</p>
            </div>

            <div class="guidelines-content">
                <section class="intro-section">
                    <p>
                        <b>Know Your Music</b> is a space for music lovers to share knowledge, discuss artists,
                        and build a collaborative music database. To keep things fun and respectful, we have a few simple rules:
                    </p>
                </section>

                <section class="guideline-section">
                    <h2><span class="section-number">1.</span> Be Kind & Respectful</h2>
                    <ul class="guidelines-list">
                        <li>No hate speech, harassment, or personal attacks.</li>
                        <li>Disagree with someone? Debate the music, not the person.</li>
                        <li>Respect diverse tastes — what's "bad music" to you might be someone else's favorite.</li>
                    </ul>
                </section>

                <section class="guideline-section">
                    <h2><span class="section-number">2.</span> Keep It Accurate</h2>
                    <ul class="guidelines-list">
                        <li>Fact-check before suggesting changes or new information (cite sources if possible).</li>
                        <li>Admins may correct or revert incorrect changes.</li>
                        <li>No intentional misinformation or spam (e.g., fake album releases).</li>
                    </ul>
                </section>

                <section class="guideline-section">
                    <h2><span class="section-number">3.</span> Contribute Meaningfully</h2>
                    <ul class="guidelines-list">
                        <li>Comments/edits should add value — no off-topic rants or self-promotion.</li>
                        <li>Found an error? Suggest a fix politely.</li>
                    </ul>
                </section>

                <section class="guideline-section">
                    <h2><span class="section-number">4.</span> No Illegal or NSFW Content</h2>
                    <ul class="guidelines-list">
                        <li>Don't share pirated music, leaks, or explicit material without warning.</li>
                        <li>Report inappropriate content visiting the <a href="/contact">Contact Us</a> page or emailing
                            <a href="mailto:knowyourmusicsupprort@gmail.com">knowyourmusicsupprort@gmail.com</a>.
                        </li>
                    </ul>
                </section>

                <section class="guideline-section">
                    <h2><span class="section-number">5.</span> Consequences</h2>
                    <p>Breaking these rules may lead to:</p>
                    <ul class="consequences-list">
                        <li><strong>Warnings</strong> (for minor issues)</li>
                        <li><strong>Temporary suspensions</strong> (repeat offenses)</li>
                        <li><strong>Permanent bans</strong> (severe violations like hate speech)</li>
                    </ul>
                </section>

                <section class="admin-section">
                    <h3>Want to Become an Admin?</h3>
                    <p>
                        Helpful, active users may be invited to join our moderation team!
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
.guidelines-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 40px 20px;
    color: #333;
}

.guidelines-header {
    text-align: center;
    margin-bottom: 20px;
}

.guidelines-header h1 {
    font-size: 2.5rem;
    color: #0c4baa;
    margin-bottom: 10px;
}

.guidelines-header .update-date {
    text-align: left;
    font-size: 0.9rem;
    font-style: italic;
    margin-left: 30px;
    color: #666;
}

.intro-section {
    padding: 25px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    font-size: 1.2rem;
    line-height: 1.6;
}

.guideline-section {
    margin-bottom: 35px;
}

h2 {
    color: #0c4baa;
    font-size: 1.8rem;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
}

.section-number {
    margin-right: 10px;
    color: #06419a;
    font-weight: bold;
}

.guidelines-list {
    list-style-type: none;
    padding-left: 0;
    font-size: 1.1rem;
    line-height: 1.6;
}

.guidelines-list li {
    margin-bottom: 12px;
    padding-left: 30px;
    position: relative;
}

.guidelines-list li:before {
    content: "•";
    color: #0c4baa;
    font-size: 1.2rem;
    position: absolute;
    left: 0;
}

.consequences-list {
    list-style-type: none;
    padding-left: 20px;
    font-size: 1.1rem;
    margin-top: 10px;
}

.consequences-list li {
    margin-bottom: 10px;
    padding-left: 30px;
    position: relative;
}

.consequences-list li:before {
    content: "→";
    color: #0c4baa;
    position: absolute;
    left: 0;
}

.admin-section {
    background-color: rgba(12, 75, 170, 0.1);
    padding: 25px;
    border-radius: 10px;
    text-align: center;
    margin-top: 40px;
}

.admin-section h3 {
    color: #0c4baa;
    font-size: 1.5rem;
    margin-bottom: 15px;
}

.admin-section p {
    font-size: 1.1rem;
    line-height: 1.6;
}

a {
    color: #0c4baa;
    font-weight: bold;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

@media (max-width: 768px) {
    .guidelines-header h1 {
        font-size: 2rem;
    }

    .guidelines-container {
        padding: 30px 15px;
    }

    h2 {
        font-size: 1.5rem;
    }

    .intro-section {
        padding: 20px;
        font-size: 1.1rem;
    }
}

</style>
