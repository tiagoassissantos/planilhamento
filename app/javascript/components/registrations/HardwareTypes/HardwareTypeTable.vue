<template>
  <div id="app">
    <div class="row">
      <div class="col-md-8 col-sm-12">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click=" input = null">Limpar pesquisa</button>
          </div>
        </div>
      </div>

      <div class="col-md-2 offset-md-2 col-sm-12">
        <router-link to="/hardware-types/new" class="btn btn-primary full-width-button float-right">Novo</router-link>
      </div>
    </div>

    <div class="margin-alert">
      <b-alert show dismissible v-if="showAlert" :variant="messageClass">{{ message }}</b-alert>
    </div>

    <div class="table-scroll">
      <table class="table table-hover table-bordered">
        <thead>
          <tr>
            <th scope="col">ID</th>
            <th scope="col">Tipo</th>
            <th scope="col">Editar</th>
            <th scope="col">Excluir</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(h_type, index) in hardware_types" :key="index" v-if="regExp( h_type )">
            <td>{{h_type.id}}</td>
            <td>{{h_type.name}}</td>
            <td>
              <router-link :to="{ name: 'hardware-type', params: {hardware_id: h_type.id}}">
                <img src="../../../../assets/images/editar.png">
              </router-link>
            </td>
            <td>
              <img
                v-if="h_type.can_delete"
                @click="deleteHardWare(h_type.id)"
                src="../../../../assets/images/excluir.png"
              >
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  components: {},

  data() {
    return {
      hardware_types: [],
      showAlert: false,
      message: "",
      messageClass: "",

      input: null
    };
  },

  computed: {
    isLogged() {
      return this.$store.state.logged;
    }
  },

  mounted() {
    this.getHardwareTypes();
  },

  methods: {
    async getHardwareTypes() {
      let response = null;
      await this.$http
        .get("/hardware_types")
        .then(resp => {
          response = resp;
        })
        .catch(resp => {
          response = resp;
        });

      if (response.status == 200) {
        this.hardware_types = response.body;
      } else {
        this.showAlert = true;
        this.messageClass = "danger";
        this.message = "Erro ao carregar os dados.";
      }

      this.loading = false;
    },

    async deleteHardWare(h_type_id) {
      let response = null;

      await this.$http
        .delete(`/hardware_types/${h_type_id}`)
        .then(result => {
          response = result;
        })
        .catch(err => {
          response = err;
        });

      if (response.status == 200) {
        this.getHardwareTypes(), (this.showAlert = true);
        this.messageClass = "success";
        this.message = "Item excluído com sucesso.";
      } else {
        this.showAlert = true;
        this.messageClass = "danger";
        this.message = "Erro ao carregar os dados.";
      }
    },

    regExp(h_type) {
      var id = h_type.id.toString();
      var name = h_type.name.toLowerCase();

      if (this.input === null) {
        return true;
      } else {
        this.input = this.input.toLowerCase();
        if (id.match(this.input) || name.match(this.input)) {
          return true;
        } else {
          return false;
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
  font-size: 30px;
}
</style>
