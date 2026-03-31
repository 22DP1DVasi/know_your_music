<script setup>
import { Head } from "@inertiajs/vue3";
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';
import { useI18n } from 'vue-i18n';
import { ref, onMounted } from 'vue';

const { t } = useI18n();

const faqs = ref([
    { key: 'create_account', show: false },
    { key: 'search_music', show: false },
    { key: 'save_favorites', show: false },
    { key: 'recommendations', show: false },
    { key: 'free_service', show: false }
]);

const toggleAnswer = (index) => {
    faqs.value[index].show = !faqs.value[index].show;
};

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
    }, { threshold: 0.1 });  // kad ir redzami 10% elementa

    document.querySelectorAll('.animate-on-scroll').forEach(el => {
        observer.observe(el);
    });
});

</script>

<template>
    <Head :title="t('info_pages.faq.page_title')" />
    <Navbar />
    <main class="flex-1">
        <div class="faq-container">
            <div class="faq-header animate-on-scroll">
                <div class="hero-badge">{{ t('info_pages.faq.hero_badge') }}</div>
                <h1>{{ t('info_pages.faq.hero_title') }}</h1>
                <p class="faq-subtitle">{{ t('info_pages.faq.hero_subtitle') }}</p>
                <div class="hero-decoration"></div>
            </div>

            <div class="faq-grid">
                <div
                    v-for="(faq, index) in faqs"
                    :key="index"
                    class="faq-item animate-on-scroll"
                    :style="{ transitionDelay: `${index * 0.05}s` }"
                >
                    <div
                        class="faq-question"
                        @click="toggleAnswer(index)"
                        :class="{ 'expanded': faq.show }"
                    >
                        <span class="question-text">{{ t(`info_pages.faq.questions.${faq.key}.question`) }}</span>
                        <i class="fa-solid fa-chevron-down" :class="{ 'rotated': faq.show }"></i>
                    </div>
                    <transition name="faq-slide">
                        <div v-if="faq.show" class="faq-answer">
                            <p>{{ t(`info_pages.faq.questions.${faq.key}.answer`) }}</p>
                        </div>
                    </transition>
                </div>
            </div>
        </div>
    </main>
    <Footer />
</template>

<style scoped>
.faq-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1.5rem 4rem;
}

.faq-header {
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

.faq-header h1 {
    font-size: 2.5rem;
    font-weight: 700;
    color: #0c4baa;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.faq-subtitle {
    font-size: 1rem;
    color: #64748b;
    margin: 0;
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

.faq-grid {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.faq-item {
    background: white;
    border-radius: 16px;
    border: 1px solid rgba(12, 75, 170, 0.1);
    overflow: hidden;
    transition: all 0.3s ease;
}

.faq-item:hover {
    border-color: rgba(12, 75, 170, 0.2);
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.08);
}

.faq-question {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.25rem 1.5rem;
    cursor: pointer;
    transition: all 0.2s ease;
    user-select: none;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
}

.faq-question:hover {
    background: rgba(12, 75, 170, 0.02);
}

.question-text {
    font-size: 1rem;
    font-weight: 600;
    color: #1e293b;
    transition: color 0.2s ease;
}

.faq-question:hover .question-text {
    color: #0c4baa;
}

.faq-question i {
    font-size: 0.9rem;
    color: #94a3b8;
    transition: transform 0.3s ease, color 0.2s ease;
}

.faq-question:hover i {
    color: #0c4baa;
}

.faq-question i.rotated {
    transform: rotate(180deg);
}

.faq-answer {
    padding: 0 1.5rem 1.25rem 1.5rem;
    border-top: 1px solid rgba(12, 75, 170, 0.08);
    background: rgba(12, 75, 170, 0.01);
}

.faq-answer p {
    margin: 0;
    font-size: 0.95rem;
    line-height: 1.6;
    color: #475569;
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

.faq-slide-enter-active,
.faq-slide-leave-active {
    transition: all 0.3s ease;
}

.faq-slide-enter-from,
.faq-slide-leave-to {
    opacity: 0;
    transform: translateY(-10px);
}

/* Responsivitāte */
@media (max-width: 768px) {
    .faq-container {
        padding: 1.5rem 1rem 3rem;
    }

    .faq-header h1 {
        font-size: 2rem;
    }

    .faq-subtitle {
        font-size: 0.9rem;
    }

    .faq-question {
        padding: 1rem 1.25rem;
    }

    .question-text {
        font-size: 0.95rem;
        padding-right: 0.75rem;
    }

    .faq-answer {
        padding: 0 1.25rem 1rem 1.25rem;
    }

    .faq-answer p {
        font-size: 0.9rem;
    }
}

@media (max-width: 480px) {
    .faq-header h1 {
        font-size: 1.75rem;
    }

    .hero-badge {
        font-size: 0.75rem;
    }

    .faq-question {
        padding: 0.875rem 1rem;
    }

    .question-text {
        font-size: 0.9rem;
    }

    .faq-answer {
        padding: 0 1rem 0.875rem 1rem;
    }
}

</style>
