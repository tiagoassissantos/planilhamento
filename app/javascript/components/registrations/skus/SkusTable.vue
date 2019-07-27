<template>
  <div id="app">

    <div class='row'>
      <div class="col-md-8 col-sm-12">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click="input = null">Limpar pesquisa</button>
          </div>
        </div>
      </div>

      <div class="col-md-2 offset-md-2 col-sm-12">
        <router-link to="/processors/new" class="btn btn-primary full-width-button float-right">
          Novo
        </router-link>
      </div>
    </div>

    <div class="margin-alert">
      <b-alert show dismissible v-if="showAlert" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="table-scroll">
      <table class="table table-hover table-bordered">
        <thead>
          <tr>
            <th scope="col">  SKU </th>
            <th scope="col">  Tipo de Hardware  </th>
            <th scope="col">  Fabricante </th>
            <th scope="col">  Modelo </th>
            <th scope="col">  Mem. RAM </th>
            <th scope="col">  Categoria </th>
            <th scope="col">  Avarias </th>
            <th scope="col">  Processador </th>
            <th scope="col">  Armazenamento </th>
            <th scope="col">  Tipo </th>
            <th scope="col">  Webcam </th>
            <th scope="col">  Teclado </th>
            <th scope="col">  Bluetooth </th>
            <th scope="col">  Teclado Luminoso </th>
            <th scope="col">  Leitor Biométrico </th>
            <th scope="col">  Placa Vídeo </th>
            <th scope="col">  Cor </th>
            <th scope="col"> Arquivo </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for='(sku, index) in skus' :key="index" v-if="regExp( sku )">
            <td> {{ sku.code }} </td>
            <td> {{ sku.hardware_type }} </td>
            <td> {{ sku.manufacturer }} </td>
            <td> {{ sku.model }} </td>
            <td>
              <span v-if="sku.ram_memory != null"> {{ sku.ram_memory }} </span>
              <span v-else>  </span>
            </td>
            <td>
              <span v-if="sku.category != null"> {{ sku.category }} </span>
              <span v-else>  </span>
            </td>
            <td> damage </td>
            <td>
              <span v-if="sku.processor != null"> {{ sku.processor }} </span>
              <span v-else>  </span>
            </td>
            <td>
              <span v-if="sku.disk_size != null"> {{ sku.disk_size }} </span>
              <span v-else>  </span>
            </td>
            <td>
              <span v-if="sku.disk_type != null"> {{ sku.disk_type }} </span>
              <span v-else>  </span>
            </td>
            <td> {{ sku.webcam }} </td>
            <td>
              <span v-if="sku.keyboard_type != null"> {{ sku.keyboard_type }} </span>
              <span v-else>  </span>
            </td>
            <td>
              <router-link :to="{ path:`/skus/${sku.id}/archive`}" class="btn btn-success" v-if="sku.archive == 'false'">
                Upload
              </router-link>
              <a :href="sku.archive" target="_blank" class="btn btn-info" v-if="sku.archive != 'false'">
                Download
              </a>
              <span target="_blank" class="btn btn-danger" v-if="sku.archive != 'false'" @click="deleteArchive(sku.id)">
                Excluir
              </span>
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
        skus: [],
        showAlert: false,
        message: '',
        messageClass: '',
        input: null,
        way: ''
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getSkus();
    },

    methods: {
      async getSkus() {
        let response = null;
        await this.$http.get('/skus')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.skus = response.body;
          console.log("++++++++++++++")
          console.log( this.skus )
          console.log("++++++++++++++")
        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
        this.loading = false
      },

      regExp( sku ) {
        var id = sku.id.toString()
        var code = sku.code.toLowerCase()
        var h_type = sku.hardware_type.toLowerCase()
        var model = sku.model.toLowerCase()

        if( this.input === null){
          return true
        }else{
          this.input = this.input.toLowerCase()
          if( id.match(this.input) || code.match(this.input) || h_type.match(this.input) || code.match(this.input) || model.match(this.input) ){
            return true
          }else{
            return false
          }
        }
      },

      async deleteArchive( sku_id ) {
        let response = null

        this.$http.delete(`/skus/${sku_id}/delete_archive`)
        .then((result) => {
          response = result
          this.skus = []
          this.getSkus()
        }).catch((err) => {
          response = err
        });
      }
    }
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
