<script setup>
import { Head } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import { onMounted } from 'vue'

// onMounted funkcija ritināšanas aktivizētm animācijām
// onMounted gaida, kad komponents tiek pievienots DOM
onMounted(() => {
    // izveidot Intersection Observer'u, lai noteiktu, kad elementi nonāk skatvietā
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            // pārbaudīt, vai elements ir redzams
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                // pārtraukt šī elementa novērošanu, lai animācija tiktu palaista tikai vienreiz
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.2 });  // kad ir redzami 20% elementa

    document.querySelectorAll('.animate-on-scroll').forEach(el => {
        observer.observe(el);
    });
});

</script>

<template>
    <Head title="About Us" />
    <Navbar />
    <main class="flex-1">
        <div class="about-container">
            <!-- Hero sadaļa -->
            <div class="about-hero animate-on-scroll">
                <div class="hero-badge">Welcome to</div>
                <h1 class="hero-title">Know Your Music</h1>
                <p class="hero-subtitle">
                    Your ultimate destination for exploring music like never before
                </p>
                <div class="hero-decoration"></div>
            </div>

            <!-- Informācijas sadaļa -->
            <section class="about-section intro-section animate-on-scroll">
                <p class="intro-text">
                    We're more than just a music database - we're a passionate community where fans, artists,
                    and curious listeners come together to discover, share, and celebrate the world of music.
                </p>
            </section>

            <!-- Iespēju sadaļa -->
            <section class="about-section animate-on-scroll">
                <h2 class="section-title">What We Offer</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🎤</div>
                        <h3>Music Encyclopedia</h3>
                        <p>Dive deep into artist biographies, discographies, lyrics, and fascinating facts about your favorite musicians and bands.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">🎧</div>
                        <h3>Seamless Playback</h3>
                        <p>Preview tracks via integrated streaming to discover new sounds effortlessly.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">💾</div>
                        <h3>Your Music, Your Way</h3>
                        <p>Save songs, create playlists, comment, and connect with fellow music lovers.</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">👥</div>
                        <h3>Community-Driven Accuracy</h3>
                        <p>Users can suggest edits via comments, while admins ensure content stays up-to-date and reliable.</p>
                    </div>

                    <div class="feature-card coming-soon">
                        <div class="feature-icon">✨</div>
                        <h3>And even more to come!</h3>
                        <p>Stay tuned for exciting new features and improvements.</p>
                    </div>
                </div>
            </section>

            <!-- Misijas nodaļa -->
            <section class="about-section mission-section animate-on-scroll">
                <h2 class="section-title">Our Mission</h2>
                <p class="mission-text">
                    At Know Your Music, we believe every song has a story. Whether you're a casual listener
                    or a die-hard fan, our platform helps you uncover the details behind the music you love - and
                    find your next favorite artist along the way.
                </p>
                <div class="mission-cta">
                    <span class="cta-text">Join us and deepen your musical journey today!</span>
                    <span class="cta-emoji">🎵</span>
                </div>
            </section>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.about-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1.5rem 4rem;
}

.about-hero {
    text-align: center;
    margin-bottom: 3rem;
    padding: 3rem 1rem;
    position: relative;
}

.hero-badge {
    display: inline-block;
    font-size: 0.85rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 2px;
    color: #0c4baa;
    background: rgba(12, 75, 170, 0.1);
    padding: 0.4rem 1rem;
    border-radius: 40px;
    margin-bottom: 1rem;
}

.hero-title {
    font-size: 3.5rem;
    font-weight: 700;
    color: #0c4baa;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.hero-subtitle {
    font-size: 1.25rem;
    color: #475569;
    max-width: 600px;
    margin: 0 auto;
}

.hero-decoration {
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 3px;
    background: linear-gradient(90deg, #0c4baa, #20c1f7);
    border-radius: 3px;
}

.intro-section {
    margin-bottom: 4rem;
}

.intro-text {
    font-size: 1.2rem;
    line-height: 1.7;
    text-align: center;
    max-width: 800px;
    margin: 0 auto;
    color: #334155;
}

.section-title {
    font-size: 2rem;
    font-weight: 600;
    color: #0c4baa;
    text-align: center;
    margin-bottom: 2rem;
    position: relative;
    padding-bottom: 0.75rem;
}

.section-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: linear-gradient(90deg, #0c4baa, #20c1f7);
    border-radius: 3px;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-top: 1rem;
}

.feature-card {
    background: white;
    padding: 1.75rem;
    border-radius: 20px;
    box-shadow: 0 4px 20px rgba(12, 75, 170, 0.08);
    transition: all 0.3s ease;
    border: 1px solid rgba(12, 75, 170, 0.08);
}

.feature-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 30px rgba(12, 75, 170, 0.12);
    border-color: rgba(12, 75, 170, 0.15);
}

.feature-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.feature-card h3 {
    font-size: 1.2rem;
    font-weight: 600;
    color: #0c4baa;
    margin-bottom: 0.75rem;
}

.feature-card p {
    color: #475569;
    line-height: 1.5;
    font-size: 0.95rem;
}

.feature-card.coming-soon {
    background: linear-gradient(135deg, #f8fbff, #ffffff);
    border: 2px dashed rgba(12, 75, 170, 0.2);
}

.mission-section {
    margin-top: 3rem;
    padding: 3rem 2rem;
    background: linear-gradient(135deg, rgba(12, 75, 170, 0.04), rgba(32, 193, 247, 0.04));
    border-radius: 24px;
    text-align: center;
}

.mission-text {
    font-size: 1.1rem;
    line-height: 1.7;
    max-width: 700px;
    margin: 0 auto 2rem;
    color: #334155;
}

.mission-cta {
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    padding: 0.75rem 1.5rem;
    border-radius: 40px;
    color: white;
}

.cta-text {
    font-size: 1rem;
    font-weight: 500;
}

.cta-emoji {
    font-size: 1.2rem;
}

/* Animācijas */
.animate-on-scroll {
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.7s ease;
}

.animate-on-scroll.visible {
    opacity: 1;
    transform: translateY(0);
}

/* Responsivitāte */
@media (max-width: 768px) {
    .about-container {
        padding: 1.5rem 1rem 3rem;
    }

    .hero-title {
        font-size: 2.5rem;
    }

    .hero-subtitle {
        font-size: 1rem;
    }

    .intro-text {
        font-size: 1rem;
    }

    .section-title {
        font-size: 1.75rem;
    }

    .features-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
    }

    .mission-section {
        padding: 2rem 1rem;
    }

    .mission-text {
        font-size: 1rem;
    }
}

@media (max-width: 480px) {
    .hero-title {
        font-size: 2rem;
    }

    .feature-card {
        padding: 1.25rem;
    }
}
</style>
