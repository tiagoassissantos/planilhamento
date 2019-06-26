<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Tamanhos de Discos
      </div>
      <div class="card-body">

        <div class='row'>
          <div class="col-sm-12">
            <disk-sizes-table/>
          </div>
        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import DiskSizesTable from './DiskSizesTable.vue';

  export default {
    components: { DiskSizesTable },

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
