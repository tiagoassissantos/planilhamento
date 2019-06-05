<template>
  <div id="app" class='container'>
    <div class="row mt-4">
      <div class="col-sm-5">
        <h2>Lote Número: {{lotId}}</h2>
      </div>
      <div class="col-sm-5">
        <h5>Número Pedido: {{lot.order_number}}</h5>
      </div>
    </div>

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
        lot: {id: 0, order_number: 0},
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
      this.lotId = this.$route.params.lot_id;
      this.getLot();
    },

    methods: {
      async getLot() {
        let response = null;
        await this.$http.get(`lots/${this.lotId}`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.lot = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      }
    }
  }
</script>

<style scoped>
  .card {
    margin-top: 30px;
  }
</style>
