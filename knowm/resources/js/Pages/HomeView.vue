<template>
    <Head title="Know Your Music" />
    <Navbar/>
    <HomeTitle/>
    <HomeRecomCards/>
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
