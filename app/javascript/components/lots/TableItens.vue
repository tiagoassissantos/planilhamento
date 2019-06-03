<template>
  <div id="app">
    <table class="table table-hover table-bordered">
      <thead>
        <tr>
          <th scope="col">Código</th>
          <th scope="col">Produto</th>
          <th scope="col">Num. Série</th>
          <th scope="col">SKU</th>
          <th scope="col">Categoria</th>
          <th scope="col">Destino</th>
          <th scope="col">Código de Barras</th>
          <th scope="col">Excluir</th>
        </tr>
      </thead>
      <tbody>

        <tr v-for='(lotItem, index) in lotItems' :key="index">
          <td>{{ lotItem.id }}</td>
          <td>{{ lotItem.hardware_type }}</td>
          <td>{{ lotItem.serial_number }}</td>
          <td>{{ lotItem.asset_tag }}</td>
          <td>{{ lotItem.category }}</td>
          <td>{{ lotItem.destination }}</td>
          <td>{{ lotItem.bar_code }}</td>
          <td>
            <button class='btn btn-light'>
              <img src='../../../assets/images/excluir.png'/>
            </button>
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
        lotItems: null,
        lotId: 0,
        showAlert: '',
        messageClass: '',
        message: ''
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id;
      this.getLotItems();
    },

    methods: {
      async getLotItems() {
        let response = null;
        await this.$http.get(`/lots/${this.lotId}/lot_items`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.lotItems = response.body;

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
