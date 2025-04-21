<template>
    <Head title="About Us" />
    <Navbar />
    <!-- main element contains the primary content and also positions Footer properly -->
    <main class="flex-1">
    <div class="about-container">
        <div class="about-header">
            <h1>About Us</h1>
        </div>

        <div class="about-content">
            <section class="about-section">
                <p class="intro-text">
                    Welcome to <b>Know Your Music</b>, your ultimate destination for exploring music like never before!
                    We're more than just a music database — we're a passionate community where fans, artists,
                    and curious listeners come together to discover, share, and celebrate the world of music.
                </p>
            </section>

            <section class="about-section">
                <h2>What We Offer</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <h3>🎤 Music Encyclopedia</h3>
                        <p>Dive deep into artist biographies, discographies, lyrics, and fascinating facts about your favorite musicians and bands.</p>
                    </div>

<!--                    <div class="feature-card">-->
<!--                        <h3>🔍 Smart Recommendations</h3>-->
<!--                        <p>Get personalized music suggestions based on your listening habits and preferences.</p>-->
<!--                    </div>-->

                    <div class="feature-card">
                        <h3>🎧 Seamless Playback</h3>
                        <p>Preview tracks via integrated streaming to discover new sounds effortlessly.</p>
                    </div>

                    <div class="feature-card">
                        <h3>💾 Your Music, Your Way</h3>
                        <p>Save songs, create playlists, comment, and connect with fellow music lovers.</p>
                    </div>

                    <div class="feature-card">
                        <h3>👥 Community-Driven Accuracy</h3>
                        <p>Users can suggest edits via comments, while admins (experienced contributors) ensure content stays up-to-date and reliable.</p>
                    </div>

                    <div class="feature-card" style="align-content: center">
                        <h3 style="font-size: 1.8rem; text-align: center">And even more to come!</h3>
                    </div>
                </div>
            </section>

            <section class="about-section mission-section">
                <h2>Our Mission</h2>
                <p>
                    At Know Your Music, we believe every song has a story. Whether you're a casual listener
                    or a die-hard fan, our platform helps you uncover the details behind the music you love — and
                    find your next favorite artist along the way.
                </p>
                <p class="cta">
                    Join us and deepen your musical journey today! 🎵
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
.about-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    color: #333;
}

.about-header {
    text-align: center;
    margin-bottom: 40px;
}

.about-header h1 {
    font-size: 2.5rem;
    color: #0c4baa;
    margin-bottom: 20px;
}

.about-section {
    margin-bottom: 50px;
}

.intro-text {
    font-size: 1.2rem;
    line-height: 1.6;
    text-align: center;
    max-width: 800px;
    margin: 0 auto;
}

h2 {
    color: #0c4baa;
    font-size: 2rem;
    margin-bottom: 20px;
    text-align: center;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    margin-top: 30px;
}

.feature-card {
    background-color: rgb(185, 225, 255);
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.feature-card:hover {
    transform: translateY(-5px);
}

.feature-card h3 {
    color: #06419a;
    margin-bottom: 15px;
    font-size: 1.3rem;
}

.mission-section {
    background-color: rgba(185, 225, 255, 0.3);
    padding: 40px;
    border-radius: 10px;
    text-align: center;
}

.mission-section p {
    font-size: 1.1rem;
    line-height: 1.6;
    max-width: 800px;
    margin: 0 auto 20px;
}

.cta {
    font-size: 1.3rem;
    font-weight: bold;
    color: #0c4baa;
    margin-top: 30px;
}

@media (max-width: 768px) {
    .about-header h1 {
        font-size: 2rem;
    }

    .features-grid {
        grid-template-columns: 1fr;
    }

    .mission-section {
        padding: 30px 20px;
    }
}
</style>
