<template>
  <div class='container'>
    <div class="card response-display">
      <div class="card-header">
        Manutenção de Item
      </div>

      <div class="card-body">
        <form>
          <div class='row'>
            <div class="col-sm-4">
              <div class="form-group">
                <label> Código de barras </label>
                <input class="form-control" type="number" v-model="search_lot.bar_code" placeholder="Código de Barras"/>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <label> Número da Série  </label>
                <input class="form-control" type="number" v-model="search_lot.serial_number" placeholder="Número de Série"/>
              </div>
            </div>

            <div class="col-sm-4 button-margin-top">
              <button type='submit' class="btn btn-primary full-width" @click="searchLot()">
                Buscar Item
              </button>
            </div>
          </div>
        </form>

        <div class="table-scroll mt-5">
          <table class="table table-hover table-bordered">
            <thead>
              <tr>
                <th scope="col"> Tipo </th>
                <th scope="col"> Fabricante </th>
                <th scope="col"> Modelo </th>
                <th scope="col"> Número de Série</th>
                <th scope="col"> Cód. Barras</th>
                <th scope="col"> Destino </th>
                <th scope="col"> Editar </th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(lot_item,index) in lot_items"
                :key="index" class="style-select"
              >
                <td> {{lot_item.hardware_type}} </td>
                <td v-if="lot_item.model != null"> {{lot_item.model.manufacturer.name}} </td>
                <td v-if="lot_item.model != null"> {{lot_item.model.name}}</td>
                <td> {{lot_item.serial_number}}</td>
                <td> {{lot_item.bar_code}}</td>
                <td> {{lot_item.destination}} </td>
                <td> <img src='../../../assets/images/editar.png'/> </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  export default {
    components: { },

    data() {
      return {
        search_lot: {
          bar_code: undefined,
          lot_number: undefined,
          serial_number: undefined
        },

        lot_items: [],
        lot_destionation: null,
        lot_item_id: null,
        destinations: [],
        lot_item_destination: null,
        showDevolution: false,

        showModal: false,
        messageModal: '',
        index: null,

        errorSelected: false
      }
    },

    computed: { },

    mounted() { },

    methods: {

      async searchLot() {
        this.lot_items = []
        this.index = null
        let response = null;
        if ( this.search_lot.bar_code == '') { this.search_lot.bar_code = undefined }
        if ( this.search_lot.lot_number == '') { this.search_lot.lot_number = undefined }
        if ( this.search_lot.serial_number == '') { this.search_lot.serial_number = undefined }

        let way = null
        way = `/search_lot/${this.search_lot.bar_code}/${this.search_lot.lot_number}/${this.search_lot.serial_number}/false`

        await this.$http.get( way )
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if (response.status == 200) {
          this.lot_items = response.body
          this.lot_destionation = this.lot_items.destination
          this.showDevolution = true
        }
      },

    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }

  .is-danger {
    border-color: red !important;
  }

  .button-margin-top {
    margin-top: 30px;
  }

  .full-width {
    width: 100%
  }

  .error-text {
    color: red;
  }

  .style-select {
    cursor: pointer;
  }

  .active {
    background-color: rgba(172, 238, 178, 0.959);
  }
</style>
