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
        <tr v-for='(destination, index) in destinations' :key="index">
          <td>{{destination.id}}</td>
          <td>{{destination.name}}</td>
          <td>
            <router-link :to="{ name: 'destination', params: {destination_id: destination.id}}">
              <img src='../../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>
            <img @click="deleteDestination(destination.id)" src='../../../../assets/images/excluir.png'/>
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
        destinations: [],
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

      async deleteDestination(destination_id){
        let response = null;

        await this.$http.delete(`/destinations/${destination_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getDestinations(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Destino excluído com sucesso."
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
