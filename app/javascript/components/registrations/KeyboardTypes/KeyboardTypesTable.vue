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
          <th scope="col">Editar</th>
          <th scope="col">Excluir</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='(type, index) in keyboardTypes' :key="index">
          <td>{{type.id}}</td>
          <td>{{type.name}}</td>
          <td>
            <router-link :to="{ name: 'keyboard_type', params: {keyboard_type_id: type.id}}">
              <img src='../../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>
            <img @click="deleteKeyboardType(type.id)" src='../../../../assets/images/excluir.png'/>
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
        keyboardTypes: [],
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
      this.getKeyboardTypes();
    },

    methods: {
      async getKeyboardTypes() {
        let response = null;
        await this.$http.get('/keyboard_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.keyboardTypes = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async deleteKeyboardType(keyboard_type_id){
        let response = null;

        await this.$http.delete(`/keyboard_types/${keyboard_type_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getKeyboardTypes(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Tipo de teclado excluído com sucesso."
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
