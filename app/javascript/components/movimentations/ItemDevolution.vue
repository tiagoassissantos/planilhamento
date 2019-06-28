<template>
  <div class='container'>
    <div class="card response-display">
      <div class="card-header">
        Devolução de Item
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

        <form v-if="showDevolution"><br>
          <button type="submit" class="btn btn-success full-width" @click="itemDevolution()">
            Devolver Item
          </button>
        </form>

        <div><br>
          <b-alert show dismissible variant="danger" v-if="errorSelected">
            Selecione um item antes de devolver.
          </b-alert>
        </div>

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
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(lot_item,index) in lot_items"
                :key="index" @click="selectItem( lot_item.destination , lot_item.id, index )"
                class="style-select"
                :class="{active: filterItem( index ) }"
              >
                <td> {{lot_item.hardware_type}} </td>
                <td v-if="lot_item.model != null"> {{lot_item.model.manufacturer.name}} </td>
                <td v-if="lot_item.model != null"> {{lot_item.model.name}}</td>
                <td> {{lot_item.serial_number}}</td>
                <td> {{lot_item.bar_code}}</td>
                <td> {{lot_item.destination}} </td>
              </tr>
            </tbody>
          </table>
        </div>

        <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
          <center>
            <img  class="size-img-modal" src="../../../assets/images/checked.png"/>
          </center>
          <p class="my-1"> {{ messageModal }} </p>
        </b-modal>

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
        way = `/search_lot/${this.search_lot.bar_code}/${this.search_lot.lot_number}/${this.search_lot.serial_number}/devolution`

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
        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = "Erro ao cadastrar novo usuário.";
        }
      },

      selectItem( lot_item_destination , lot_item_id, index ) {
        this.lot_destionation = lot_item_destination
        this.lot_item_id = lot_item_id
        this.index = index
      },

      filterItem( id ) {
        if( this.index  === id ) {
          return true
        } else {
          return false
        }
      },

      async itemDevolution () {
        if( this.lot_item_id === null) {
          this.errorSelected = true
          return
        }

        let response = null

        await this.$http.delete(`/sales_orders/${this.lot_item_id}/item_devolution`, {lot_item_id: this.lot_item_id})
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.showModal = true
          this.messageModal = response.body.message
          this.lot_items = []
          this.index = null
          this.lot_item_id = null

          setTimeout(function() {
            this.showModal = false
          }.bind(this), 2000);
        }
      }
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
