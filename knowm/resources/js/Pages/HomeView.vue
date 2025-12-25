<script setup>
import Footer from '@/Components/Footer.vue';
import Navbar from '@/Components/Navbar.vue';
// import HomeRecomCards from '@/Components/HomeRecomCards.vue';
import { Head, Link } from "@inertiajs/vue3";

const ADMIN_ROLE_ID = 1;

</script>

<template>
    <Head title="Know Your Music" />
    <Navbar/>
    <main class="flex-1">
        <div class="adm-button-container">
            <Link
                v-if="$page.props.isAdmin"
                :href="route('admin-dashboard')"
                class="adm-button"
            >
                Admin Panel
            </Link>
        </div>
        <div class="home-title">
            <p>{{ $t('home.enhance_experience') }}</p>
            <p>Make new discoveries, learn the background of your favorite music and share your tastes.</p>
        </div>

        <section class="features-section">
            <div class="features-container">
                <div class="feature-card">
                    <div class="feature-icon">🎵</div>
                    <h3>Deep Music Knowledge</h3>
                    <p>Explore artist backgrounds, song meanings, and hidden connections between musicians.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔍</div>
                    <h3>Track Exploration</h3>
                    <p>Discover lyrics, production credits, and interesting facts about your favorite songs.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">💾</div>
                    <h3>Save & Organize</h3>
                    <p>Create collections of tracks you love and share them with the community.</p>
                </div>
            </div>
        </section>

        <!--        will be added later when recommendation system is created -->
        <!--        <HomeRecomCards/>-->

        <section class="cta-section">
            <div class="cta-container">
                <h2>Ready to dive deeper into music?</h2>
                <div class="cta-buttons">
                    <a href="#" class="cta-button primary">Browse Tracks</a>
                    <a href="/register" class="cta-button secondary">Join Community</a>
                </div>
            </div>
        </section>
    </main>
    <Footer/>
</template>

<style scoped>
.home-title {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 60%;
    margin: auto auto 20px;
    font-size: 2.9rem;
    text-align: center;
    font-family: 'Montserrat', sans-serif;
    font-weight: bold;
    color: black;
    padding-top: 5%;
}

.home-title p {
    margin: 2%;
}

.adm-button-container {
    margin-top: 5px;
    position: absolute;
    right: 50px;
}

.features-section {
    padding: 60px 5%;
}

.features-container {
    display: flex;
    justify-content: center;
    gap: 30px;
    max-width: 1200px;
    margin: 0 auto;
    flex-wrap: wrap;
}

.feature-card {
    flex: 1;
    min-width: 300px;
    max-width: 350px;
    padding: 30px;
    background-color: rgb(193, 228, 248);
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    text-align: center;
    transition: transform 0.3s ease;
}

.feature-icon {
    font-size: 2.5rem;
    margin-bottom: 15px;
}

.feature-card h3 {
    color: #0c4baa;
    font-size: 1.5rem;
    margin-bottom: 15px;
}

.feature-card p {
    color: #555;
    line-height: 1.6;
}

.cta-section {
    padding: 60px 5%;
    background-color: rgb(4, 117, 182);
    color: white;
    text-align: center;
}

.cta-container {
    max-width: 800px;
    margin: 0 auto;
}

.cta-section h2 {
    font-size: 2rem;
    margin-bottom: 30px;
}

.cta-buttons {
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
}

.cta-button {
    padding: 12px 24px;
    border-radius: 6px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.cta-button.primary {
    background-color: white;
    color: #0c4baa;
}

.cta-button.primary:hover {
    background-color: #f0f0f0;
    transform: translateY(-2px);
}

.cta-button.secondary {
    border: 2px solid white;
    color: white;
    background: transparent;
}

.cta-button.secondary:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

@media (max-width: 1363px) {
    .home-title {
        width: 85%;
        font-size: 2.3rem;
    }
}

@media (max-width: 768px) {
    .home-title {
        font-size: 2rem;
    }

    .feature-card {
        min-width: 100%;
    }

    .cta-buttons {
        flex-direction: column;
        align-items: center;
    }

    .cta-button {
        width: 100%;
        text-align: center;
    }
}

@media (max-width: 480px) {
    .home-title {
        font-size: 1.5rem;
        width: 85%;
    }

    .cta-section h2 {
        font-size: 1.5rem;
    }
}
</style>
