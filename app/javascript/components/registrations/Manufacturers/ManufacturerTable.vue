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
        <tr v-for='(manufacturer, index) in manufacturers' :key="index">
          <td>{{manufacturer.id}}</td>
          <td>{{manufacturer.name}}</td>
          <td>
            <router-link :to="{ name: 'manufacturer', params: {manufacturer_id: manufacturer.id}}">
              <img src='../../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>
            <img @click="deleteManufacturer(manufacturer.id)" src='../../../../assets/images/excluir.png'/>
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
        manufacturers: [],
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
      this.getManufacturers();
    },

    methods: {
      async getManufacturers() {
        let response = null;
        await this.$http.get('/manufacturers')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.manufacturers = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async deleteManufacturer(manufacturer_id){
        let response = null;

        await this.$http.delete(`/manufacturers/${manufacturer_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getManufacturers(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Fabricante excluido com sucesso."
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
