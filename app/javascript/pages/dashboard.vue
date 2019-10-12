<template>
<v-app>
  <div id="app" class='container'>
    <h1>Dashboard</h1>
    {{ isLogged }}
  </div>
</v-app>

</template>

<script>
  import navBar from "../components/navBarUser.vue";

  export default {
    components: { navBar },

    computed: {
      isLogged() {
        //return this.$store.state.logged
      }
    },

    mounted() {
      //this.$store.dispatch('isLogged');
    },

    methods: {
    }
  };
</script>

<style scoped>
</style>
