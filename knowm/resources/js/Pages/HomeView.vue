<template>
  
  <Navbar/>
  <HomeTitle/>
  <HomeRecomCards/>
  <Footer/>
  
</template>

<script>
import Footer from '@/components/Footer.vue';
import HomeRecomCards from '@/components/HomeRecomCards.vue';
import HomeTitle from '@/components/HomeTitle.vue';
import Navbar from '@/components/Navbar.vue';

export default {
  components: {
    Navbar,
    HomeTitle,
    HomeRecomCards,
    Footer
  }
}
</script>

<style scoped>

</style>
