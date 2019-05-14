<template>
  <div id="app">
    <div v-if="!isLogged"> 
      <navbar/>
    </div>

    <div v-if="isLogged">
      <nav-bar-user></nav-bar-user>
    </div>
    <router-view></router-view>
    <footer/>
  </div>
</template>

<script>
  import navbar from "../components/navbar.vue";
  import navBarUser from '../components/navBarUser.vue'
  import footer from "../components/footer.vue";

  export default {
    components: { navbar, footer, navBarUser },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    }
    
  };
</script>

<style>
</style>
