<script setup>
import Footer from '@/Components/Footer.vue';
import Navbar from '@/Components/Navbar.vue';
// import HomeRecomCards from '@/Components/HomeRecomCards.vue';
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useI18n } from 'vue-i18n';
import { route } from "ziggy-js";
import { onMounted, computed } from 'vue';

const { t } = useI18n();

const page = usePage();

const isLoggedIn = computed(() => !!page.props.auth?.user)
const roles = computed(() => page.props.auth?.user?.roles ?? []);
const isAdmin = computed(() => roles.value.includes('super_admin'));

const secondaryButton = computed(() => {
    return isLoggedIn.value
        ? { text: t('home.tune_profile'), href: '/dashboard' }
        : { text: t('home.join_now'), href: '/login' }
})

const features = [
    { icon: '🎵', key: 'deep_knowledge' },
    { icon: '🔍', key: 'track_exploration' },
    { icon: '💾', key: 'save_organize' }
];

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

const getBarStyle = (index) => {
    const delay = (index % 10) * 0.2; // pseido-randoms
    const duration = 2.5 + (index % 5) * 0.3;

    return {
        animationDelay: `${delay}s`,
        animationDuration: `${duration}s`
    };
};

</script>

<template>
    <Head title="Know Your Music" />
    <Navbar/>
    <main class="home-main">
        <div class="adm-button-container">
            <Link
                v-if="isAdmin"
                :href="route('admin-dashboard')"
                class="adm-button"
            >
                {{ t('home.admin_panel') }}
            </Link>
        </div>
        <!-- Hero sadaļa -->
        <section class="hero-section">
            <!-- Ekvalaizera fons -->
            <div class="equalizer">
                <div
                    v-for="n in 40"
                    :key="n"
                    class="bar"
                    :style="getBarStyle(n)"
                ></div>
            </div>

            <div class="hero-overlay"></div>

            <!-- Saturs -->
            <div class="hero-content">
                <h1 class="hero-title animate-fade-up">{{ t('home.page_title') }}</h1>
                <p class="hero-subtitle animate-fade-up-delay">{{ t('home.page_subtitle') }}</p>

                <div class="hero-buttons animate-fade-up-delay-2">
                    <a href="/explore/artists" class="hero-button primary">{{ t('home.explore_music') }}</a>
                    <a :href="secondaryButton.href" class="hero-button secondary">
                        {{ secondaryButton.text }}
                    </a>
                </div>
            </div>
        </section>

        <!-- Iespēju (feature) sadaļa -->
        <section class="features-section">
            <!-- Atspoguļots ekvalaizers -->
            <div class="equalizer inverted">
                <div
                    v-for="n in 40"
                    :key="n"
                    class="bar dark"
                    :style="getBarStyle(n)"
                ></div>
            </div>

            <div class="features-overlay"></div>

            <div class="container">
                <h2 class="section-title animate-on-scroll">{{ t('home.why_choose_us') }}</h2>
                <div class="features-grid">
                    <div v-for="(feature, index) in features" :key="index" class="feature-card animate-on-scroll" :style="{ transitionDelay: `${index * 0.1}s` }">
                        <div class="feature-icon">{{ feature.icon }}</div>
                        <h3>{{ t(`home.features.${feature.key}.title`) }}</h3>
                        <p>{{ t(`home.features.${feature.key}.description`) }}</p>
                    </div>
                </div>
            </div>
        </section>

        <div class="polygon-divider"></div>

        <!-- Viettura sadaļa (WIP, būs kartes vai kaut kas līdzīgs) -->
        <section class="trending-section">
            <div class="container">
                <h2 class="section-title animate-on-scroll">{{ t('home.trending_now') }}</h2>
                <p class="section-subtitle animate-on-scroll">{{ t('home.trending_subtitle') }}</p>
                <div class="placeholder-grid">
                    <div v-for="n in 4" :key="n" class="placeholder-card animate-on-scroll" :style="{ transitionDelay: `${n * 0.05}s` }">
                        <div class="placeholder-image"></div>
                        <div class="placeholder-text">
                            <div class="placeholder-title"></div>
                            <div class="placeholder-subtitle"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="polygon-divider reverse"></div>

        <!-- "Aicinājums uz darbību" sadaļa -->
        <section class="cta-section">
            <div class="container">
                <div class="cta-content animate-on-scroll">
                    <h2>{{ t('home.start_discovering') }}</h2>
                    <div class="cta-buttons">
                        <a href="/explore/artists" class="cta-button primary">{{ t('home.browse_artists') }}</a>
                        <a :href="secondaryButton.href" class="cta-button secondary">
                            {{ secondaryButton.text }}
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <Footer/>
</template>

<style scoped>
.home-main {
    overflow-x: hidden;
}

.adm-button-container {
    margin-top: 5px;
    position: absolute;
    right: 50px;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1.5rem;
}

.hero-content,
.features-section .container {
    position: relative;
    z-index: 3;
}

.features-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(
        to bottom,
        rgba(255, 255, 255, 0.9),
        rgba(255, 255, 255, 0.6)
    );
    z-index: 2;
}

.hero-section {
    position: relative;
    z-index: 0;
    min-height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    overflow: hidden;
    padding: 4rem 2rem;
}

.equalizer {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: flex-end;
    justify-content: space-between; /* izstiepties pāri */
    padding: 0 40px;
    pointer-events: none;
    gap: 4px;
    filter: blur(1px);
    z-index: 0;
}

.equalizer.inverted {
    top: 0;
    bottom: auto;
    transform: rotate(180deg);
}

.bar {
    flex: 1;
    margin: 0 2px;
    background: rgb(255, 255, 255);
    height: 60px;
    border-radius: 6px;
    animation: equalizerAnim ease-in-out infinite;
}

.bar.dark {
    background: rgba(12, 75, 170, 0.25);
}

@keyframes equalizerAnim {
    0%, 100% {
        height: 60px;
    }
    50% {
        height: 300px;
    }
}

@media (prefers-reduced-motion: reduce) {
    .bar {
        animation: none;
    }
}

.hero-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(
        to bottom,
        rgba(12, 75, 170, 0.75) 0%,
        rgba(12, 75, 170, 0.85) 60%,
        rgba(12, 75, 170, 0.95) 100%
    );
    z-index: 1;
}

.hero-content {
    position: relative;
    z-index: 2;
    max-width: 800px;
}

.hero-title {
    font-size: 3.5rem;
    font-weight: 700;
    color: #ffffff;
    text-shadow: 0 4px 20px rgba(0,0,0,0.4);
    margin-bottom: 1rem;
    line-height: 1.2;
}

.hero-subtitle {
    font-size: 1.25rem;
    color: rgba(255,255,255,0.85);
    margin-bottom: 2rem;
}

.hero-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
}

.hero-button {
    padding: 0.75rem 2rem;
    border-radius: 40px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    display: inline-block;
}

.hero-button.primary {
    background: white;
    color: #0c4baa;
    box-shadow: 0 4px 15px rgba(12, 75, 170, 0.3);
    border: 2px solid #0c4baa;
}

.hero-button.primary:hover {
    background: #042350;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(12, 75, 170, 0.4);
}

.hero-button.secondary {
    background: white;
    color: #0c4baa;
    box-shadow: 0 4px 15px rgba(12, 75, 170, 0.3);
    border: 2px solid #0c4baa;
}

.hero-button.secondary:hover {
    background: #130583;
    color: white;
    transform: translateY(-2px);
}

.features-section {
    padding: 5rem 0;
    background: linear-gradient(135deg, #ffffff, #e6f7ff);
    position: relative;
    overflow: hidden;
}

.section-title {
    text-align: center;
    font-size: 2.5rem;
    font-weight: 600;
    color: #0c4baa;
    margin-bottom: 1rem;
    text-shadow: 0 4px 20px rgba(0,0,0,0.4);
}

.section-subtitle {
    text-align: center;
    color: #666;
    margin-bottom: 3rem;
    font-size: 1.1rem;
}

.features-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 2rem;
}

.feature-card {
    flex: 1;
    min-width: 280px;
    max-width: 350px;
    padding: 2rem;
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(12, 75, 170, 0.1);
    text-align: center;
    transition: all 0.3s ease;
    border: 1px solid rgba(12, 75, 170, 0.1);
}

.feature-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 30px rgba(12, 75, 170, 0.15);
}

.feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.feature-card h3 {
    font-size: 1.5rem;
    color: #0c4baa;
    margin-bottom: 1rem;
}

.feature-card p {
    color: #666;
    line-height: 1.5;
}

.polygon-divider {
    height: 120px;
    background: #ffffff;
    clip-path: polygon(0 40%, 100% 0%, 100% 100%, 0% 100%);
}

.polygon-divider::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100px;
    background-size: cover;
}

.polygon-divider.reverse::before {
    bottom: auto;
    top: 0;
    transform: rotate(180deg);
    background-position: top;
}

.trending-section {
    padding: 5rem 0;
    background: linear-gradient(135deg, #ffffff, #e6f7ff);
}

.placeholder-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
}

.placeholder-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(12, 75, 170, 0.1);
    transition: all 0.3s ease;
    cursor: pointer;
}

.placeholder-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(12, 75, 170, 0.15);
}

.placeholder-image {
    background: linear-gradient(135deg, #b3eaff, #0c4baa);
    height: 200px;
    border-radius: 16px 16px 0 0;
}

.placeholder-text {
    padding: 1rem;
}

.placeholder-title {
    height: 20px;
    background: #e0e0e0;
    border-radius: 4px;
    margin-bottom: 0.5rem;
    width: 80%;
}

.placeholder-subtitle {
    height: 15px;
    background: #e0e0e0;
    border-radius: 4px;
    width: 60%;
}

.cta-section {
    padding: 5rem 0;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    position: relative;
    overflow: hidden;
}

.cta-section::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
    pointer-events: none;
}

.cta-content {
    text-align: center;
    color: white;
    position: relative;
    z-index: 1;
}

.cta-content h2 {
    font-size: 2rem;
    margin-bottom: 2rem;
}

.cta-buttons {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    flex-wrap: wrap;
}

.cta-button {
    padding: 0.8rem 2rem;
    border-radius: 40px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.cta-button.primary {
    background: white;
    color: #0c4baa;
}

.cta-button.primary:hover {
    background: #f0f0f0;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.cta-button.secondary {
    border: 2px solid white;
    color: white;
}

.cta-button.secondary:hover {
    background: rgba(255,255,255,0.1);
    transform: translateY(-2px);
}

/* Animācijas */
.animate-fade-up {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeUp 0.8s ease forwards;
}

.animate-fade-up-delay {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeUp 0.8s ease 0.2s forwards;
}

.animate-fade-up-delay-2 {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeUp 0.8s ease 0.4s forwards;
}

@keyframes fadeUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-on-scroll {
    opacity: 0;
    transform: translateY(40px);
    transition: all 0.8s ease;
}

.animate-on-scroll.visible {
    opacity: 1;
    transform: translateY(0);
}

/* Responsivitāte */
@media (max-width: 1024px) {
    .hero-title {
        font-size: 2.5rem;
    }

    .hero-subtitle {
        font-size: 1.1rem;
    }

    .section-title {
        font-size: 2rem;
    }
}

@media (max-width: 768px) {
    .hero-section {
        min-height: 70vh;
    }

    .hero-title {
        font-size: 2rem;
    }

    .hero-subtitle {
        font-size: 1rem;
    }

    .hero-buttons {
        flex-direction: column;
        align-items: center;
    }

    .hero-button {
        width: 100%;
        text-align: center;
    }

    .features-grid {
        flex-direction: column;
        align-items: center;
    }

    .feature-card {
        width: 100%;
    }

    .cta-content h2 {
        font-size: 1.5rem;
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

</style>
