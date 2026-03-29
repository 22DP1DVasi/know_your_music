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
    <Head title="Privacy Policy" />
    <Navbar />
    <main class="flex-1">
        <div class="privacy-container">
            <div class="privacy-header animate-on-scroll">
                <div class="hero-badge">{{ t('info_pages.privacy_pol.hero_badge') }}</div>
                <h1>{{ t('info_pages.privacy_pol.hero_title') }}</h1>
                <p class="update-date">
                    <em>{{ t('info_pages.privacy_pol.last_updated') }} {{ t('info_pages.privacy_pol.last_updated_date') }}</em>
                </p>
                <div class="hero-decoration"></div>
            </div>

            <div class="privacy-content">
                <section class="privacy-section intro-section animate-on-scroll">
                    <p class="intro-text">
                        {{ t('info_pages.privacy_pol.intro_text_start') }} <b>Know Your Music</b>. {{ t('info_pages.privacy_pol.intro_text_end') }}
                    </p>
                </section>

                <section class="privacy-section animate-on-scroll">
                    <h2>{{ t('info_pages.privacy_pol.what_we_collect_title') }}</h2>
                    <p class="section-subtitle">{{ t('info_pages.privacy_pol.what_we_collect_subtitle') }}</p>
                    <ul class="policy-list">
                        <li><strong>{{ t('info_pages.privacy_pol.basic_account_data_title') }}</strong> {{ t('info_pages.privacy_pol.basic_account_data_desc') }}</li>
                        <li><strong>{{ t('info_pages.privacy_pol.music_preferences_title') }}</strong> {{ t('info_pages.privacy_pol.music_preferences_desc') }}</li>
                        <li><strong>{{ t('info_pages.privacy_pol.cookies_title') }}</strong> {{ t('info_pages.privacy_pol.cookies_desc') }}</li>
                    </ul>
                </section>

                <section class="privacy-section animate-on-scroll">
                    <h2>{{ t('info_pages.privacy_pol.how_we_use_title') }}</h2>
                    <ul class="policy-list">
                        <li>{{ t('info_pages.privacy_pol.how_we_use_item1') }}</li>
                        <li>{{ t('info_pages.privacy_pol.how_we_use_item2') }}</li>
                        <li>{{ t('info_pages.privacy_pol.how_we_use_item3') }}</li>
                    </ul>
                </section>

                <section class="privacy-section animate-on-scroll">
                    <h2>{{ t('info_pages.privacy_pol.what_we_dont_title') }}</h2>
                    <ul class="policy-list">
                        <li>{{ t('info_pages.privacy_pol.what_we_dont_item1') }}</li>
                        <li>{{ t('info_pages.privacy_pol.what_we_dont_item2') }}</li>
                    </ul>
                </section>

                <section class="privacy-section animate-on-scroll">
                    <h2>{{ t('info_pages.privacy_pol.your_rights_title') }}</h2>
                    <ul class="policy-list">
                        <li>{{ t('info_pages.privacy_pol.your_rights_item1') }}</li>
                        <li>{{ t('info_pages.privacy_pol.your_rights_item2') }}</li>
                        <li>{{ t('info_pages.privacy_pol.your_rights_item3') }}</li>
                    </ul>
                </section>

                <section class="privacy-section contact-section animate-on-scroll">
                    <h2>{{ t('info_pages.privacy_pol.questions_title') }}</h2>
                    <p>
                        {{ t('info_pages.privacy_pol.questions_text_start') }}
                        <a href="/contact">{{ t('info_pages.privacy_pol.contact_us_link') }}</a>
                        {{ t('info_pages.privacy_pol.questions_text_middle') }}
                        <a href="mailto:kymsupport@gmail.com">kymsupport@gmail.com</a>
                        {{ t('info_pages.privacy_pol.questions_text_end') }}
                    </p>
                </section>
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.privacy-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1.5rem 4rem;
}

.privacy-header {
    text-align: center;
    margin-bottom: 3rem;
    padding: 2rem 1rem;
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

.privacy-header h1 {
    font-size: 2.5rem;
    font-weight: 700;
    color: #0c4baa;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.update-date {
    font-size: 0.9rem;
    font-style: italic;
    color: #64748b;
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
    margin-bottom: 2rem;
}

.intro-text {
    font-size: 1.1rem;
    line-height: 1.7;
    text-align: center;
    max-width: 700px;
    margin: 0 auto;
    color: #334155;
}

.privacy-section {
    margin-bottom: 2.5rem;
}

h2 {
    font-size: 1.6rem;
    font-weight: 600;
    color: #0c4baa;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid rgba(12, 75, 170, 0.2);
}

.section-subtitle {
    margin-bottom: 1rem;
    color: #475569;
}

.policy-list {
    list-style-type: none;
    padding-left: 0;
    line-height: 1.6;
}

.policy-list li {
    margin-bottom: 0.75rem;
    padding-left: 1.5rem;
    position: relative;
    color: #334155;
}

.policy-list li:before {
    content: "•";
    color: #0c4baa;
    font-size: 1.2rem;
    position: absolute;
    left: 0;
    top: -2px;
}

.contact-section {
    margin-top: 2rem;
    padding: 2rem;
    background: linear-gradient(135deg, rgba(12, 75, 170, 0.04), rgba(32, 193, 247, 0.04));
    border-radius: 20px;
    text-align: center;
}

.contact-section a {
    color: #0c4baa;
    font-weight: 600;
    text-decoration: none;
    transition: color 0.2s ease;
}

.contact-section a:hover {
    color: #20c1f7;
    text-decoration: underline;
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
    .privacy-container {
        padding: 1.5rem 1rem 3rem;
    }

    .privacy-header h1 {
        font-size: 2rem;
    }

    .intro-text {
        font-size: 1rem;
    }

    h2 {
        font-size: 1.4rem;
    }

    .contact-section {
        padding: 1.5rem;
    }
}

@media (max-width: 480px) {
    .privacy-header h1 {
        font-size: 1.75rem;
    }

    .policy-list li {
        font-size: 0.95rem;
    }
}

</style>
