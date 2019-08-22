<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Tipo de Disco
      </div>
      <div class="card-body">

        <div class='row'>
          <div class="col-sm-12">
            <disk-types-table/>
          </div>
        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import DiskTypesTable from './DiskTypesTable.vue';

  export default {
    components: { DiskTypesTable },

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
            this.getCurrentUser.role == "Operador N2"         ||
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
