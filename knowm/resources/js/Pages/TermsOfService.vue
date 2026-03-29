<script setup>
import { Head } from '@inertiajs/vue3'
import Navbar from '@/Components/Navbar.vue'
import Footer from '@/Components/Footer.vue'
import { onMounted } from 'vue'
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
    <Head title="Terms of Service" />
    <Navbar />
    <main class="flex-1">
        <div class="terms-container">
            <div class="terms-header animate-on-scroll">
                <div class="hero-badge">{{ t('info_pages.tos.hero_badge') }}</div>
                <h1>{{ t('info_pages.tos.hero_title') }}</h1>
                <p class="update-date">
                    <em>{{ t('info_pages.tos.last_updated') }} {{ t('info_pages.tos.last_updated_date') }}</em>
                </p>
                <div class="hero-decoration"></div>
            </div>

            <div class="terms-content">
                <section class="terms-section intro-section animate-on-scroll">
                    <p class="intro-text">
                        {{ t('info_pages.tos.intro_text') }}
                    </p>
                </section>

                <section class="terms-section animate-on-scroll">
                    <h2><span class="section-number">1.</span> {{ t('info_pages.tos.your_account_title') }}</h2>
                    <ul class="terms-list">
                        <li>{{ t('info_pages.tos.your_account_item1') }}</li>
                        <li>{{ t('info_pages.tos.your_account_item2') }}</li>
                        <li>{{ t('info_pages.tos.your_account_item3') }}</li>
                    </ul>
                </section>

                <section class="terms-section animate-on-scroll">
                    <h2><span class="section-number">2.</span> {{ t('info_pages.tos.your_content_title') }}</h2>
                    <ul class="terms-list">
                        <li>{{ t('info_pages.tos.your_content_item1') }}</li>
                        <li>{{ t('info_pages.tos.your_content_item2') }}</li>
                        <li>{{ t('info_pages.tos.your_content_item3') }}</li>
                    </ul>
                </section>

                <section class="terms-section animate-on-scroll">
                    <h2><span class="section-number">3.</span> {{ t('info_pages.tos.copyright_title') }}</h2>
                    <ul class="terms-list">
                        <li>{{ t('info_pages.tos.copyright_item1') }}</li>
                        <li>
                            {{ t('info_pages.tos.copyright_item2_start') }}
                            <a href="mailto:knowyourmusicsupprort@gmail.com">knowyourmusicsupprort@gmail.com</a>.
                        </li>
                    </ul>
                </section>

                <section class="terms-section animate-on-scroll">
                    <h2><span class="section-number">4.</span> {{ t('info_pages.tos.our_rules_title') }}</h2>
                    <ul class="terms-list">
                        <li>{{ t('info_pages.tos.our_rules_item1') }}</li>
                        <li>{{ t('info_pages.tos.our_rules_item2') }}</li>
                    </ul>
                </section>

                <section class="terms-section animate-on-scroll">
                    <h2><span class="section-number">5.</span> {{ t('info_pages.tos.disclaimer_title') }}</h2>
                    <ul class="terms-list">
                        <li>{{ t('info_pages.tos.disclaimer_item1') }}</li>
                    </ul>
                </section>

                <section class="terms-section contact-section animate-on-scroll">
                    <h2>{{ t('info_pages.tos.questions_title') }}</h2>
                    <p>
                        {{ t('info_pages.tos.questions_text_start') }}
                        <a href="/contact">{{ t('info_pages.tos.contact_us_link') }}</a>
                        {{ t('info_pages.tos.questions_text_middle') }}
                        <a href="mailto:kymsupprort@gmail.com">kymsupprort@gmail.com</a>
                        {{ t('info_pages.tos.questions_text_end') }}
                    </p>
                </section>
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.terms-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1.5rem 4rem;
}

.terms-header {
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

.terms-header h1 {
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

.terms-section {
    margin-bottom: 2.5rem;
}

h2 {
    font-size: 1.6rem;
    font-weight: 600;
    color: #0c4baa;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid rgba(12, 75, 170, 0.2);
    display: flex;
    align-items: center;
}

.section-number {
    margin-right: 0.5rem;
    color: #20c1f7;
}

.terms-list {
    list-style-type: none;
    padding-left: 0;
    line-height: 1.6;
}

.terms-list li {
    margin-bottom: 0.75rem;
    padding-left: 1.5rem;
    position: relative;
    color: #334155;
}

.terms-list li:before {
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
    .terms-container {
        padding: 1.5rem 1rem 3rem;
    }

    .terms-header h1 {
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
    .terms-header h1 {
        font-size: 1.75rem;
    }

    .terms-list li {
        font-size: 0.95rem;
    }
}

</style>
