<template>
  <div id="app">
    <table class="table table-hover table-bordered">
      <thead>
        <tr>
          <th scope="col">Código</th>
          <th scope="col">Produto</th>
          <th scope="col">IMEI</th>
          <th scope="col">Patrimônio</th>
          <th scope="col">Num. Série</th>
          <th scope="col">Destino</th>
          <th scope="col">Etiqueta</th>
          <th scope="col">Excluir</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Desk92</td>
          <td>Desk, DELL, mod.: OPTIPLEX 790, proc.: I5 com processador(es), mem.: DDR 3, HD:</td>
          <td>321564987</td>
          <td>3242</td>
          <td>5MS09S1</td>
          <td>Processo</td>
          <td>32165498</td>
          <td>
            <button class='btn btn-light'>
              <img src='../../../assets/images/excluir.png'/>
            </button>
          </td>
        </tr>
        <tr>
          <td>Desk92</td>
          <td>Desk, DELL, mod.: OPTIPLEX 790, proc.: I5 com processador(es), mem.: DDR 3, HD:</td>
          <td>321564987</td>
          <td>3242</td>
          <td>5MS09S1</td>
          <td>Processo</td>
          <td>32165498</td>
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
