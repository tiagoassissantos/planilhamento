<template>
  <div id="app">
    <div class='row'>
      <div class="col-sm-8">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click=" input = null ">Limpar pesquisa</button>
          </div>
        </div>
      </div>

      <div class="col-sm-2 offset-sm-2">
        <router-link to="/users/new" class="btn btn-primary float-right" v-if="getCurrentUser.role === 'Administrador'">
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
            <th scope="col">E-mail</th>
            <th scope="col">CPF</th>
            <th scope="col">Perfil de Acesso</th>
            <th scope="col">Editar</th>
            <!--th scope="col">Excluir</th-->
          </tr>
        </thead>
        <tbody>
          <tr v-for='(user, index) in users' :key="index" v-if="regExp( user )">
            <td>{{user.id}}</td>
            <td>{{user.name}}</td>
            <td>{{user.email}}</td>
            <td>{{user.cpf}}</td>
            <td>{{user.role}}</td>
            <td>
              <router-link :to="{ name: 'user', params: {user_id: user.id}}">
                <img src='../../../../assets/images/editar.png'/>
              </router-link>
            </td>
            <!--td>
              <img @click="deleteUser(user.id)" src='../../../../assets/images/excluir.png'/>
            </td-->
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
        users: [],
        showAlert: false,
        message: '',
        messageClass: '',

        input: null
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      },

      getCurrentUser() {
        return this.$store.state.currentUser
      }

    },

    mounted() {
      this.getUsers();
    },

    methods: {
      async getUsers() {
        let response = null;
        await this.$http.get('/users')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.users = response.body;
        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async deleteUser(user_id){
        let response = null;

        await this.$http.delete(`/users/${user_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getUsers(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Fabricante excluído com sucesso."
        }else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
      },

      regExp( user ) {
        var id = user.id.toString()
        var name = user.name.toLowerCase()
        var email = user.email.toLowerCase()
        var cpf = user.cpf.toLowerCase()
        var role = user.role.toLowerCase()

        if( this.input === null){
          return true
        }else{
          this.input = this.input.toLowerCase()
          if( id.match(this.input) || name.match(this.input) || email.match(this.input)
              || cpf.match(this.input) || role.match(this.input) ){
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
