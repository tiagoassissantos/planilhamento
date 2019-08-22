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
      },

      getCurrentUser() {
        return this.$store.state.currentUser
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');

      this.$store.dispatch('getCurrentUser');
      this.$store.subscribe((mutation, state) => {
        if (mutation.type == 'SET_CURRENT_USER') {
          if(this.getCurrentUser.role != "Administrador"){
            this.$router.push('/')
          }
        }
      })
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

  .cursor-item{
    cursor: pointer;
  }

</style>
