<template>
  <div id="app">
    
    <div class='row'>
      <div class="col-sm-8">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click="input = null">Limpar pesquisa</button>
          </div>
        </div>
      </div>

      <div class="col-sm-2 offset-sm-2">
        <router-link to="/processors/new" class="btn btn-primary float-right">
          Novo
        </router-link>
      </div>
    </div>

    <div class="margin-alert">
      <b-alert show dismissible v-if="showAlert" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <table class="table table-hover table-bordered">
      <thead>
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Nome</th>
          <th scope="col">Editar</th>
          <th scope="col">Excluir</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='(processor, index) in processors' :key="index" v-if="regExp( processor )">
          <td>{{processor.id}}</td>
          <td>{{processor.name}}</td>
          <td>
            <router-link :to="{ name: 'processor', params: {processor_id: processor.id}}">
              <img src='../../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>
            <img @click="deleteProcessor(processor.id)" src='../../../../assets/images/excluir.png'/>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    components: { },

    data() {
      return {
        processors: [],
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
      this.getProcessors();
    },

    methods: {
      async getProcessors() {
        let response = null;
        await this.$http.get('/processors')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.processors = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async deleteProcessor(processor_id){
        let response = null;

        await this.$http.delete(`/processors/${processor_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getProcessors(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Processador excluído com sucesso."
        }else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
      },

      regExp( processor ) {
        var id = processor.id.toString()
        var name = processor.name.toLowerCase()

        if( this.input === null){
          return true
        }else{
          this.input = this.input.toLowerCase()
          if( id.match(this.input) || name.match(this.input) ){
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
