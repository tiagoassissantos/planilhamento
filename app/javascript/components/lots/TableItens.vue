<template>
  <div id="app">
    <div class='row'>
      <div class="col-sm-8">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button">Limpar pesquisa</button>
          </div>
        </div>
      </div>
    </div>

    <div>
      <b-alert show dismissible class="mt-4" v-if="showAlert" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="table-scroll">
      <table class="table table-hover table-bordered">
        <thead>
          <tr>
            <th scope="col">Código</th>
            <th scope="col">Produto</th>
            <th scope="col">Num. Série</th>
            <th scope="col">SKU</th>
            <th scope="col">Categoria</th>
            <th scope="col">Destino</th>
            <th scope="col">Código de Barras</th>
            <th scope="col" v-if="lot.status != 'closed'">Excluir</th>
          </tr>
        </thead>
      <tbody>
        <tr v-for='(lotItem, index) in lotItems' :key="index" v-if="regExp( lotItem )">
          <td>{{ lotItem.id }}</td>
          <td>{{ lotItem.hardware_type }}</td>
          <td>{{ lotItem.serial_number }}</td>
          <td>{{ lotItem.asset_tag }}</td>
          <td>{{ lotItem.category }}</td>
          <td>{{ lotItem.destination }}</td>
          <td>{{ lotItem.bar_code }}</td>
          <td v-if="lot.status != 'closed'" @click="deleteItem( lotItem.id )">
            <button class='btn btn-light'>
              <img src='../../../assets/images/excluir.png'/>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    </div>
    
  </div>
</template>

<script>
  export default {
    components: { },

    data() {
      return {
        lotItems: null,
        lotId: 0,
        showAlert: false,
        messageClass: '',
        message: '',
        lot: null,

        input: null
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id;
      this.getLotItems();
      this.getLot();
    },

    methods: {
      async getLotItems() {
        let response = null;
        await this.$http.get(`/lots/${this.lotId}/lot_items`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.lotItems = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

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
        }
      },

      async deleteItem( itemId) {
        let response = null
        await this.$http.delete(`/lots/${this.lot.id}/lot_items/${itemId}`)
        .then((result) => {
          response = result;  
        }).catch((err) => {
          response = err;
        });

        if (response.status == 200){
          this.getLotItems();
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Lote excluído com sucesso."
          
          setTimeout(function(){ 
            this.showAlert = false     
          }.bind(this), 4000);    

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao excluir "
        }
      },


      regExp( lotItem ) {
        var lotItem_id = lotItem.id.toString()
        var hardware_type = lotItem.hardware_type.toLowerCase()
        var serial_number = lotItem.serial_number.toLowerCase()
        var category = lotItem.category.toLowerCase()
        var destination = lotItem.destination.toLowerCase()
        var bar_code = lotItem.bar_code.toLowerCase()


        if( this.input === null){
          return true
        }else{
          this.input = this.input.toLowerCase()
          if( lotItem_id.match(this.input) || hardware_type.match(this.input) || serial_number.match(this.input)
              || category.match(this.input) || destination.match(this.input) || bar_code.match(this.input) ){
            return true
          }else{
            return false
          }
        }
      }

    },


  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
    margin-right: 50px;
  }

  table {
    margin-top: 20px;
  }

  .edit-icon {
    font-size: 30px
  }
</style>
