<script setup>
import { Head } from '@inertiajs/vue3';
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';
import { onMounted } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

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
                <div class="hero-badge">{{ t('info_pages.aboutus.hero_badge') }}</div>
                <h1 class="hero-title">{{ t('info_pages.aboutus.hero_title') }}</h1>
                <p class="hero-subtitle">{{ t('info_pages.aboutus.hero_subtitle') }}</p>
                <div class="hero-decoration"></div>
            </div>

            <!-- Informācijas sadaļa -->
            <section class="about-section intro-section animate-on-scroll">
                <p class="intro-text">{{ t('info_pages.aboutus.intro_text') }}</p>
            </section>

            <!-- Iespēju sadaļa -->
            <section class="about-section animate-on-scroll">
                <h2 class="section-title">{{ t('info_pages.aboutus.what_we_offer') }}</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🎤</div>
                        <h3>{{ t('info_pages.aboutus.feature_music_encyclopedia_title') }}</h3>
                        <p>{{ t('info_pages.aboutus.feature_music_encyclopedia_desc') }}</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">💾</div>
                        <h3>{{ t('info_pages.aboutus.feature_your_music_title') }}</h3>
                        <p>{{ t('info_pages.aboutus.feature_your_music_desc') }}</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">👥</div>
                        <h3>{{ t('info_pages.aboutus.feature_community_title') }}</h3>
                        <p>{{ t('info_pages.aboutus.feature_community_desc') }}</p>
                    </div>

                    <div class="feature-card coming-soon">
                        <div class="feature-icon">✨</div>
                        <h3>{{ t('info_pages.aboutus.feature_coming_soon_title') }}</h3>
                        <p>{{ t('info_pages.aboutus.feature_coming_soon_desc') }}</p>
                    </div>
                </div>
            </section>

            <!-- Misijas nodaļa -->
            <section class="about-section mission-section animate-on-scroll">
                <h2 class="section-title">{{ t('info_pages.aboutus.our_mission') }}</h2>
                <p class="mission-text">{{ t('info_pages.aboutus.mission_text') }}</p>
                <div class="mission-cta">
                    <span class="cta-text">{{ t('info_pages.aboutus.mission_cta') }}</span>
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
