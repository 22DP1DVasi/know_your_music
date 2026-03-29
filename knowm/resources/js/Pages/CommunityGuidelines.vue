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
    <Head title="Community Guidelines" />
    <Navbar />
    <main class="flex-1">
        <div class="guidelines-container">
            <div class="guidelines-header animate-on-scroll">
                <div class="hero-badge">{{ t('info_pages.comguidelines.hero_badge') }}</div>
                <h1>{{ t('info_pages.comguidelines.hero_title') }}</h1>
                <p class="update-date">
                    <em>{{ t('info_pages.comguidelines.last_updated') }} {{ t('info_pages.comguidelines.last_updated_date') }}</em>
                </p>
                <div class="hero-decoration"></div>
            </div>

            <div class="guidelines-content">
                <section class="intro-section animate-on-scroll">
                    <p>
                        <b>{{ t('info_pages.comguidelines.brand_name') }}</b> {{ t('info_pages.comguidelines.intro_text') }}
                    </p>
                </section>

                <section class="guideline-section animate-on-scroll">
                    <h2><span class="section-number">1.</span> {{ t('info_pages.comguidelines.be_kind_title') }}</h2>
                    <ul class="guidelines-list">
                        <li>{{ t('info_pages.comguidelines.be_kind_item1') }}</li>
                        <li>{{ t('info_pages.comguidelines.be_kind_item2') }}</li>
                        <li>{{ t('info_pages.comguidelines.be_kind_item3') }}</li>
                    </ul>
                </section>

                <section class="guideline-section animate-on-scroll">
                    <h2><span class="section-number">2.</span> {{ t('info_pages.comguidelines.keep_accurate_title') }}</h2>
                    <ul class="guidelines-list">
                        <li>{{ t('info_pages.comguidelines.keep_accurate_item1') }}</li>
                        <li>{{ t('info_pages.comguidelines.keep_accurate_item2') }}</li>
                        <li>{{ t('info_pages.comguidelines.keep_accurate_item3') }}</li>
                    </ul>
                </section>

                <section class="guideline-section animate-on-scroll">
                    <h2><span class="section-number">3.</span> {{ t('info_pages.comguidelines.contribute_title') }}</h2>
                    <ul class="guidelines-list">
                        <li>{{ t('info_pages.comguidelines.contribute_item1') }}</li>
                        <li>{{ t('info_pages.comguidelines.contribute_item2') }}</li>
                    </ul>
                </section>

                <section class="guideline-section animate-on-scroll">
                    <h2><span class="section-number">4.</span> {{ t('info_pages.comguidelines.no_illegal_title') }}</h2>
                    <ul class="guidelines-list">
                        <li>{{ t('info_pages.comguidelines.no_illegal_item1') }}</li>
                        <li>
                            {{ t('info_pages.comguidelines.no_illegal_item2_start') }}
                            <a href="/contact">{{ t('info_pages.comguidelines.contact_us_link') }}</a>
                            {{ t('info_pages.comguidelines.no_illegal_item2_middle') }}
                            <a href="mailto:kymsupport@gmail.com">kymsupport@gmail.com</a>.
                        </li>
                    </ul>
                </section>

                <section class="guideline-section animate-on-scroll">
                    <h2><span class="section-number">5.</span> {{ t('info_pages.comguidelines.consequences_title') }}</h2>
                    <p>{{ t('info_pages.comguidelines.consequences_subtitle') }}</p>
                    <ul class="consequences-list">
                        <li><strong>{{ t('info_pages.comguidelines.consequences_item1_title') }}</strong> {{ t('info_pages.comguidelines.consequences_item1_desc') }}</li>
                        <li><strong>{{ t('info_pages.comguidelines.consequences_item2_title') }}</strong> {{ t('info_pages.comguidelines.consequences_item2_desc') }}</li>
                        <li><strong>{{ t('info_pages.comguidelines.consequences_item3_title') }}</strong> {{ t('info_pages.comguidelines.consequences_item3_desc') }}</li>
                    </ul>
                </section>

                <section class="admin-section animate-on-scroll">
                    <h3>{{ t('info_pages.comguidelines.admin_section_title') }}</h3>
                    <p>
                        {{ t('info_pages.comguidelines.admin_section_text') }}
                    </p>
                </section>
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.guidelines-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1.5rem 4rem;
}

.guidelines-header {
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

.guidelines-header h1 {
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
    padding: 1.5rem;
    background: linear-gradient(135deg, rgba(12, 75, 170, 0.04), rgba(32, 193, 247, 0.04));
    border-radius: 16px;
    text-align: center;
}

.intro-section p {
    font-size: 1.1rem;
    line-height: 1.7;
    color: #334155;
    margin: 0;
}

.guideline-section {
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

.guidelines-list {
    list-style-type: none;
    padding-left: 0;
    line-height: 1.6;
}

.guidelines-list li {
    margin-bottom: 0.75rem;
    padding-left: 1.5rem;
    position: relative;
    color: #334155;
}

.guidelines-list li:before {
    content: "•";
    color: #0c4baa;
    font-size: 1.2rem;
    position: absolute;
    left: 0;
    top: -2px;
}

.consequences-list {
    list-style-type: none;
    padding-left: 0;
    margin-top: 0.75rem;
}

.consequences-list li {
    margin-bottom: 0.75rem;
    padding-left: 1.5rem;
    position: relative;
    color: #334155;
}

.consequences-list li:before {
    content: "→";
    color: #0c4baa;
    position: absolute;
    left: 0;
}

.admin-section {
    margin-top: 2rem;
    padding: 2rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    border-radius: 20px;
    text-align: center;
    color: white;
}

.admin-section h3 {
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 1rem;
}

.admin-section p {
    font-size: 1rem;
    line-height: 1.6;
    margin: 0;
}

a {
    color: #0c4baa;
    font-weight: 600;
    text-decoration: none;
    transition: color 0.2s ease;
}

a:hover {
    color: #20c1f7;
    text-decoration: underline;
}

.admin-section a {
    color: #ffffff;
    text-decoration: underline;
}

.admin-section a:hover {
    color: #b3eaff;
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
    .guidelines-container {
        padding: 1.5rem 1rem 3rem;
    }

    .guidelines-header h1 {
        font-size: 2rem;
    }

    .intro-section p {
        font-size: 1rem;
    }

    h2 {
        font-size: 1.4rem;
    }

    .admin-section {
        padding: 1.5rem;
    }

    .admin-section h3 {
        font-size: 1.3rem;
    }
}

@media (max-width: 480px) {
    .guidelines-header h1 {
        font-size: 1.75rem;
    }

    .guidelines-list li,
    .consequences-list li {
        font-size: 0.95rem;
    }

    .admin-section h3 {
        font-size: 1.2rem;
    }
}

</style>
