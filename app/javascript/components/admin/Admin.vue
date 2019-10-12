<template>
  <v-app>
    <div id="app">
      <nav-bar-admin/>
      <router-view></router-view>
    </div>
  </v-app>
</template>

<script>
  import navBarAdmin from './navBarAdmin'
  export default {

    components: { navBarAdmin },

    data() {
      return {

      }
    },

    computed: {},
    mounted() {}
  }
</script>

<style scoped>

</style>
