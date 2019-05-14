<template>
  <div id="app">
    <h1>Dashboard</h1>
    {{ isLogged }}
  </div>
</template>

<script>
  import navbar from "../components/navBarUser.vue";
  import footer from "../components/footer.vue";

  export default {
    components: { navbar, footer },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: {
    }
  };
</script>

<style>
</style>
