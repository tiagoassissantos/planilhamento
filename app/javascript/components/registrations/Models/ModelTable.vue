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
        <router-link to="/models/new" class="btn btn-primary full-width-button float-right">
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
            <th scope="col">ID</th>
            <th scope="col">Nome</th>
            <th scope="col">Fabricante</th>
            <th scope="col">Editar</th>
            <th scope="col">Excluir</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for='(model, index) in models' :key="index" v-if="regExp( model )">
            <td>{{model.id}}</td>
            <td>{{model.name}}</td>
            <td>{{model.manufacturer.name}}</td>
            <td>
              <router-link :to="{ name: 'model', params: {model_id: model.id}}">
                <img src='../../../../assets/images/editar.png'/>
              </router-link>
            </td>
            <td>
              <img @click="deleteModel(model.id)" class="cursor-item" src='../../../../assets/images/excluir.png'/>
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
        models: [],
        showAlert: false,
        message: '',
        messageClass: '',
        input: null
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getModels();
    },

    methods: {
      async getModels() {
        let response = null;
        await this.$http.get('/models')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.models = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async deleteModel(model_id){
        let response = null;

        await this.$http.delete(`/models/${model_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getModels(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Modelo excluído com sucesso."
        }else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
      },

      regExp( model ) {
        var id = model.id.toString()
        var name = model.name.toLowerCase()
        var manufacturer_name = model.manufacturer.name.toLowerCase()


        if( this.input === null){
          return true
        }else{
          this.input = this.input.toLowerCase()
          if( id.match(this.input) || name.match(this.input) || manufacturer_name.match(this.input)  ){
            return true
          }else{
            return false
          }
        }
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
