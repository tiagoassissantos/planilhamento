<template>
  <div id="app" class='container'>
    <div class="card">
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
