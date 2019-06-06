<template>
  <div id="app" class='container'>
    <div class="row mt-4">
      <div class="col-sm-5">
        <h2>Lote Número: {{lotId}}</h2>
      </div>
      <div class="col-sm-5">
        <h5>Número Pedido: {{lot.order_number}}</h5>
      </div>
      <div class="col-sm-2" v-if="lot.status != 'closed'">
        <button class="btn btn-danger space-left" @click="closeLot(lotId)"> Fechar Lote </button>
      </div>
    </div>

    <div class="card">
      <div class="card-header">
        <div class="row">
          <div class="col-sm-6">
            Relação de Itens
          </div>

          <div class="col-sm-6" v-show="lot.status != 'closed'">
            <router-link :to='newItemUrl' class="btn btn-primary float-right">
              Novo Item
            </router-link>
          </div>
        </div>
      </div>
      

      <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
        <center>
          <img  class="size-img-modal" src="../../../assets/images/checked.png"/>
        </center>
        <p class="my-1"> {{ messageModal }} </p>
      </b-modal>


      <div class="card-body">

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
        lot: {id: 0, order_number: 0, status: 0},
        lotId: 0,

        showModal: false,
        messageModal: '',

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
      },

      async closeLot(lotId) {
        this.lot.status = 1 
        let response = null;

        await this.$http.put(`/lots/${this.lotId}`, {lot: this.lot})
          .then((result) => {
            response = result;
          }).catch((err) => {
            response = err
          });


        if (response.status == 200) {
          this.messageModal = 'Lote fechado com sucesso'
          this.showModal = true     

          setTimeout(function(){ 
            this.showModal = false     
            this.$router.push('/inventory/closed')
          }.bind(this), 2000);    

        } 

      }
    }
  }
</script>

<style scoped>
  .card {
    margin-top: 30px;
  }

  .space-left{
    margin-left: 35px;
  }
</style>
