<template>
  <div id="app">
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
        <tr v-for='h_type in hardware_types'>
          <td>{{h_type.id}}</td>
          <td>{{h_type.name}}</td>
          <td>
            <router-link to="/lots/1" class="nav-link active text-light">
              <img src='../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>
            <button type='button' class='btn btn-link'>  </button>
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
        hardware_types: []
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getHardwareTypes();
    },

    methods: {
      async getHardwareTypes() {
        let response = null;
        await this.$http.get('/hardware_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.hardware_types = response.body;

        } else {
          this.error = true
          console.log( response.body )
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
