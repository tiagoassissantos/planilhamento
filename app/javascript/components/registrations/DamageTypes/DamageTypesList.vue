<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Tipos de Avaria
      </div>
      <div class="card-body">

        <damage-types-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import DamageTypesTable from './DamageTypesTable.vue';

  export default {
    components: { DamageTypesTable },

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
