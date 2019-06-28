<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Pedido de Vendas
      </div>
      <div class="card-body">

         <sales-order-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import SalesOrderTable from './SalesOrderTable.vue';

  export default {
    components: { SalesOrderTable },

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

<style scoped>
  .card {
    margin-top: 30px;
  }
</style>
