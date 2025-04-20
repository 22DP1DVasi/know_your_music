<template>
    <Head title="Know Your Music" />
    <Navbar/>
    <!-- main element contains the primary content and also positions Footer properly -->
    <main class="flex-1">
        <HomeTitle/>
        <HomeRecomCards/>
    </main>
    <Footer/>

</template>

<script>
import Footer from '@/Components/Footer.vue';
import HomeRecomCards from '@/Components/HomeRecomCards.vue';
import HomeTitle from '@/Components/HomeTitle.vue';
import Navbar from '@/Components/Navbar.vue';
import {Head} from "@inertiajs/vue3";

export default {
  components: {
      Head,
      Navbar,
      HomeTitle,
      HomeRecomCards,
      Footer
  }
}
</script>

<style scoped>

</style>
