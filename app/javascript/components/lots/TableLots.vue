<template>
  <div id="app">
    <table class="table table-hover table-bordered">
      <thead>
        <tr>
          <th scope="col">Editar</th>
          <th scope="col">Código</th>
          <th scope="col">Núm. Lote</th>
          <th scope="col">Data</th>
        </tr>
      </thead>
      <tbody>

        <tr v-for='(lot, index) in lots' :key="index">
          <td>
            <router-link :to="{ name: 'lot', params: {lot_id: lot.id}}">
            <!--router-link to="/lots/" class="nav-link active text-light"-->
              <img src='../../../assets/images/editar.png'/>
            </router-link>
          </td>

          <td>{{lot.id}}</td>
          <td>{{lot.order_number}}</td>
          <td>{{lot.created_at}}</td>
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
        lots: []
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getLots();
    },

    methods: {
      async getLots() {
        let response = null;
        await this.$http.get('/lots')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.lots = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
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
