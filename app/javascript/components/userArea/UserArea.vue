<template>
  <v-app>
    <div id="app">
      <nav-bar/>
      <router-view></router-view>
    </div>
  </v-app>
</template>

<script>
  import navBar from './navBarUser'

  export default {
    components: { navBar },

    computed:{

      isLogged() {
        return this.$store
      }

    },

    mounted() {
    }
  }
</script>

<style scoped>

</style>
