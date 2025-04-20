<template>
    <Head title="FAQ" />
        <Navbar/>
        <!-- main element contains the primary content and also positions Footer properly -->
        <main class="flex-1">
            <div class="faq-page-wrapper">
                <div class="faq-container">
                    <h2>Frequently Asked Questions</h2>
                    <div v-for="(faq, index) in faqs" :key="index" class="faq-item"> <!-- v-for is list rendering (for loop)-->
                        <div class="faq-question" @click="toggleAnswer(index)">
                            {{ faq.question }}
                        </div>
                        <div v-if="faq.show" class="faq-answer">    <!-- show only if faq.show is true -->
                            {{ faq.answer }}
                        </div>
                    </div>
                </div>
            </div>
        </main>
    <Footer/>
</template>

<script>
import {Head} from "@inertiajs/vue3";
import Navbar from '@/Components/Navbar.vue';
import Footer from '@/Components/Footer.vue';

export default {
    components: {Footer, Head, Navbar},
    data() {
        return {
            faqs: [
                { question: "How do I create an account?", answer: "To create an account, click on the 'Sign Up' button at the top of the page and follow the instructions.", show: false },
                { question: "How can I search for music and artists?", answer: "Use the search bar at the top of the page to find music by artist name, album title, or genre.", show: false },
                { question: "Can I save my favorite tracks and artists?", answer: "Yes! Registered users can create personal collections and save their favorite songs and artists.", show: false },
                { question: "How do I get personalized recommendations?", answer: "Our system analyzes your listening preferences and suggests music based on your taste.", show: false },
                { question: "Is the service free to use?", answer: "Yes, our platform is free, but we may introduce premium features in the future.", show: false }
            ]
        };
    },
    methods: {
        toggleAnswer(index) {
            this.faqs[index].show = !this.faqs[index].show;
        }
    }
};
</script>

<style scoped>
.faq-page-wrapper {
    display: flex;
    justify-content: center;
    padding: 20px;
}

.faq-container {
    width: 60%;
    background: white;
    padding: 20px;
    margin-top: 20px;
    margin-bottom: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
.faq-item {
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
}

.faq-question {
    font-size: 18px;
    font-weight: bold;
    transition: color 0.3s ease;
    /* remove text select when clicking multiple times */
    user-select: none;   /* standard property */
    -webkit-user-select: none;   /* Safari */
    -moz-user-select: none;      /* Firefox */
    -ms-user-select: none;      /* IE/Edge */
    cursor: pointer;
}

.faq-question:hover {
    color: #06419a; /* Darker shade on hover */
}

.faq-answer {
    padding: 10px 0;
    font-size: 16px;
}

</style>
