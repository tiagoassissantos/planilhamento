<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Categorias
      </div>
      <div class="card-body">

        <categories-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import CategoriesTable from './CategoriesTable.vue';

  export default {
    components: { CategoriesTable },

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
