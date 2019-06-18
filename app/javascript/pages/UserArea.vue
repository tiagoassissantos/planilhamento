<template>
  <div id="app">
    <div v-if="isLogged">
      <navbar-user/>
    </div>

    <div class="margin-body">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  import navbarUser from '../components/navBarUser.vue';
  import SideMenu from '../components/SideMenu.vue';
  import StatusBar from '../components/StatusBar.vue';

  export default {
    components: { navbarUser, SideMenu, StatusBar },

    computed: {
      isLogged() {
        return this.$store.state.logged
      },

      getCurrentUser() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
      this.$store.dispatch('getCurrentUser');
    },

    methods: {}
  };
</script>

<style scoped lang="scss">
  .left-panel {
    position: absolute;
    float: left;
    padding-right: 30px;
    height: 100%;
  }

  .right-panel {
    padding-left: 0px;
    padding-right: 0px;
  }

  .container {}

  .margin-body {
    padding-top: 100px;
  }
</style>
