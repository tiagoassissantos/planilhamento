<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Processadores
      </div>
      <div class="card-body">

        <processors-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import ProcessorsTable from './ProcessorsTable.vue';

  export default {
    components: { ProcessorsTable },

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
