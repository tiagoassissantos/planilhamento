<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Usuários
      </div>
      <div class="card-body">

        <users-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import UsersTable from './UsersTable.vue';

  export default {
    components: { UsersTable },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: { }
  };
</script>

<style scoped>
  .card {
    margin-top: 30px;
  }
</style>

<style>
  @media only screen and (max-width: 855px) {
    .response-display {
      margin-top: 100px !important;
    }
  }

  @media only screen and (max-width: 765px) {
    .full-width-button {
      margin-top: 20px;
      width: 100% !important;
    }
  }

</style>
