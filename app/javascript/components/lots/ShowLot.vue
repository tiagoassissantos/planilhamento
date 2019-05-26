<template>
  <div id="app" class='container'>
    <h2>Lote Número: {{lotId}}</h2>

    <div class="card">

      <div class="card-header">
        <div class="row">
          <div class="col-sm-6">
            Relação de Itens
          </div>

          <div class="col-sm-6">
            <router-link :to='newItemUrl' class="btn btn-primary float-right">
                Novo Item
            </router-link>
          </div>
        </div>
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
        </div>

        <div class='row'>
          <div class="col-sm-12">
            <table-itens/>
          </div>
        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import TableItens from './TableItens.vue';
  import NewItem from './NewItem.vue';

  export default {
    components: { TableItens, NewItem },

    data() {
      return {
        lotId: 0
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      },

      newItemUrl() {
        return `/lots/${this.lotId}/new-item`
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id
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
