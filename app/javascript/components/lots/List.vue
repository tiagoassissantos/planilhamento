<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Lista de Lotes
      </div>
      <div class="card-body">
          <table-lots/>
      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import TableLots from './TableLots.vue';

  export default {
    components: { TableLots },

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
