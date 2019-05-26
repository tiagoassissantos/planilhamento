<template>
  <div id="app" class='container'>
    <h1>Dashboard</h1>
    {{ isLogged }}
  </div>
</template>

<script>
  import navbar from "../components/navBarUser.vue";

  export default {
    components: { navbar },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: {
    }
  };
</script>

<style scoped>
</style>
