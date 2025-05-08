<template>
    <Head title="Know Your Music" />
    <Navbar/>
    <!-- main element contains the primary content and also positions Footer properly -->
    <main class="flex-1">
        <div class="home-title">
            <p>Enhance your music experience.</p>
            <p>Make new discoveries, learn the background of your favorite music and share your tastes.</p>
        </div>
        <HomeRecomCards/>
    </main>
    <Footer/>

</template>

<script>
import Footer from '@/Components/Footer.vue';
import HomeRecomCards from '@/Components/HomeRecomCards.vue';
import Navbar from '@/Components/Navbar.vue';
import {Head} from "@inertiajs/vue3";

export default {
  components: {
      Head,
      Navbar,
      HomeRecomCards,
      Footer
  }
}
</script>

<style scoped>

.home-title {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 60%;
    margin: auto;
    font-size: 2.9rem;
    text-align: center;
    font-family: 'Montserrat', sans-serif;
    color: black;
    padding-top: 5%;
}

.home-title p {
    margin: 2%;
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
}

@media (max-width: 480px) {
    .home-title {
        font-size: 1.5rem;
        width: 85%;
    }
}

</style>
