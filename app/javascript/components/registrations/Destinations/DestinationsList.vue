<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Destinos
      </div>
      <div class="card-body">
      
        <destinations-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import DestinationsTable from './DestinationsTable.vue';

  export default {
    components: { DestinationsTable },

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
