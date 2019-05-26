<template>
  <div id="app">
    <div v-if="isLogged">
      <navbar-user/>
    </div>

    <div class='left-panel'>
      <side-menu/>
    </div>

    <div class='right-panel'>
      <div class="status-panel">
        <status-bar/>
      </div>

      <div class="">
        <router-view></router-view>
      </div>
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
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: {
    }
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

  .container {
    padding-left: 100px;
    margin-right: 30px;
  }

  .status-panel {
    padding-left: 200px;
  }
</style>
