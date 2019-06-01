<template>
  <div id="app">

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
          <th scope="col">E-mail</th>
          <th scope="col">CPF</th>
          <th scope="col">Perfil de Acesso</th>
          <th scope="col">Editar</th>
          <!--th scope="col">Excluir</th-->
        </tr>
      </thead>
      <tbody>
        <tr v-for='(user, index) in users' :key="index">
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
</template>

<script>
  export default {
    components: { },

    data() {
      return {
        users: [],
        showAlert: false,
        message: '',
        messageClass: ''

      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
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
