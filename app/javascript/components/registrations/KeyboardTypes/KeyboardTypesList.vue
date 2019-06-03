<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Tipos de Teclado
      </div>
      <div class="card-body">

        <keyboard-types-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import KeyboardTypesTable from './KeyboardTypesTable.vue';

  export default {
    components: { KeyboardTypesTable },

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
