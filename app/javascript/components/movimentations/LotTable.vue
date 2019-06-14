<template>
  <div id="app">
    <div class="table-scroll">
      <table class="table table-hover table-bordered">
        <thead>
          {{lot_items}}
          <tr>
            <th scope="col">ID </th>
            <th scope="col">Tipo </th>
            <th scope="col">Fabricante </th>
            <th scope="col">Modelo </th>
            <th scope="col">Número de Série</th>
            <th scope="col">Cód. Barras</th>
          </tr>
        </thead>
        <tbody>

        </tbody>
      </table>
    </div>

  </div>
</template>

<script>
  export default {
    components: { },

    data() {
      return {

      }
    },

    computed: {},

    mounted() {},

    methods: {},

    props: {
      lot_items: Array
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
