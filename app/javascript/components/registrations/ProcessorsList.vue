<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Fabricantes
      </div>
      <div class="card-body">

        <div class='row'>
          <div class="col-sm-8">
            <div class="input-group">
              <input type="text" class="form-control" aria-describedby="button-addon4">
              <div class="input-group-append" id="button-addon4">
                <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
                <button class="btn btn-danger" type="button">Limpar pesquisa</button>
              </div>
            </div>
          </div>

          <div class="col-sm-2 offset-sm-2">
            <router-link to="/processor/new" class="btn btn-primary float-right">
                Novo
            </router-link>
          </div>
        </div>

        <div class='row'>
          <div class="col-sm-12">
            <manufacturer-table/>
          </div>
        </div>

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
