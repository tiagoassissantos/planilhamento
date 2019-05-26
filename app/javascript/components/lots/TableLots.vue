<template>
  <div id="app">
    <table class="table table-hover table-bordered">
      <thead>
        <tr>
          <th scope="col">Editar</th>
          <th scope="col">Núm. Lote</th>
          <th scope="col">Cliente</th>
          <th scope="col">Transportadora</th>
          <th scope="col">Nota Fiscal</th>
          <th scope="col">Recebimento</th>
          <th scope="col">Responsável</th>
          <th scope="col">Peso Liquido (Kg)</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <router-link to="/lots/1" class="nav-link active text-light">
              <img src='../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>1233</td>
          <td>CONDOMINIO DO EDIFICIO LINNEO DE PAULA MACHADO</td>
          <td>DIGGO</td>
          <td>456321</td>
          <td>17/05/2019</td>
          <td>Marcus Rocha</td>
          <td>254,000</td>
        </tr>
        <tr>
          <td>
            <router-link to="/lots/2" class="nav-link active text-light">
              <img src='../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>1233</td>
          <td>CONDOMINIO DO EDIFICIO LINNEO DE PAULA MACHADO</td>
          <td>DIGGO</td>
          <td>456321</td>
          <td>17/05/2019</td>
          <td>Marcus Rocha</td>
          <td>254,000</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    components: { },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: {
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
