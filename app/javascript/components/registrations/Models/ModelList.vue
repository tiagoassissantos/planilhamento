<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Modelos
      </div>
      <div class="card-body">

        <model-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import ModelTable from './ModelTable.vue';

  export default {
    components: { ModelTable },

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
