<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
  export default {
    data() {
      return {

      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');

      this.$store.subscribe((mutation, state) => {
        if (mutation.type == 'SET_LOGGED') {
          if (this.isLogged) window.location.href = '/user-area';
        }
      })
    }

  };
</script>

<style scoped>

</style>
