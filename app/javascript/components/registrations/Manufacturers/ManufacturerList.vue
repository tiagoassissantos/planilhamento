<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Fabricantes
      </div>
      <div class="card-body">

        <manufacturer-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import ManufacturerTable from './ManufacturerTable.vue';

  export default {
    components: { ManufacturerTable },

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
          if(
            this.getCurrentUser.role == "Operador Comercial"  ||
            this.getCurrentUser.role == "Operador Marketing"  ||
            this.getCurrentUser.role == "Operador Pós-Venda / Garantia"
          ){
            this.$router.push('/')
          }
        }
      })

    },

    methods: {}
  };
</script>

<style scoped>
  .card {
    margin-top: 30px;
  }
</style>
