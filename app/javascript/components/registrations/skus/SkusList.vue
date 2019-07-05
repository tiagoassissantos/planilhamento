<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header">
        Skus
      </div>
      <div class="card-body">

        <skus-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import SkusTable from './SkusTable.vue';

  export default {
    components: { SkusTable },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: { }
  };
</script>

<style scoped>
  .card {
    margin-top: 30px;
  }
</style>
