<template>
  <div id="app">
    <h1>Dashboard</h1>
  </div>
</template>

<script>
  import navbar from "../components/navbar.vue";
  import footer from "../components/footer.vue";

  export default {
    components: { navbar, footer },

    mounted() {
      //this.$store.dispatch('isLogged');
    },
  };
</script>

<style>
</style>
