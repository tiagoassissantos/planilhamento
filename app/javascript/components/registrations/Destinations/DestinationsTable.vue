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
        <router-link to="/destinations/new" class="btn btn-primary float-right">
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
            <th scope="col">Editar</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for='(destination, index) in destinations' :key="index" v-if="regExp( destination )">
            <td>{{destination.id}}</td>
            <td>{{destination.name}}</td>
            <td>
              <router-link :to="{ name: 'destination', params: {destination_id: destination.id}}">
                <img src='../../../../assets/images/editar.png'/>
              </router-link>
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
        destinations: [],
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
      this.getDestinations();
    },

    methods: {
      async getDestinations() {
        let response = null;
        await this.$http.get('/destinations')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.destinations = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      regExp( destination ) {
        var id = destination.id.toString()
        var name = destination.name.toLowerCase()

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
