<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Tipos de Hardware
      </div>

      <div class="card-body">
        <hardware-type-table/>
      </div> <!-- card body -->

    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import HardwareTypeTable from './HardwareTypeTable.vue';

  export default {
    components: { HardwareTypeTable },

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
