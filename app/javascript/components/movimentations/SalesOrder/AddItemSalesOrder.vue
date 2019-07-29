<template>
  <b-modal id="newItem"  ref="my-modal" hide-footer title="Adicionar Item" size='xl'>
    <form>
      <div class='row'>
        <div class="col-sm-3">
          <div class="form-group">
            <label> Código de barras </label>
            <input class="form-control" type="text" v-model="search_lot.bar_code" placeholder="Código de Barras"/>
          </div>
        </div>

        <div class="col-sm-3">
          <div class="form-group">
            <label> Número do Lote </label>
            <input class="form-control" type="text" v-model="search_lot.lot_number" placeholder="Número do Lote" />
          </div>
        </div>

        <div class="col-sm-3">
          <div class="form-group">
            <label> Número da Série  </label>
            <input class="form-control" type="text" v-model="search_lot.serial_number" placeholder="Número de Série"/>
          </div>
        </div>

        <div class="col-sm-3 button-margin-top">
          <button type='submit' class="btn btn-primary full-width" @click="searchLot()">
            Buscar Item
          </button>
        </div>
      </div>
    </form>

    <form @submit.prevent="submit" v-if="showDestiny && !props_data.add_item">
      <div class='row'>
        <div class="col-sm-4">
          <div class="form-group">
            <label> Antigo Destino </label>
            <input class="form-control" type="text" :value="this.lot_destionation" disabled/>
          </div>
        </div>

        <div class="col-sm-5">
          <div class="form-group">
            <label> Novo Destino </label>
            <select
              class="form-control"
              name="destinations"
              type="text"
              v-validate.disabled="'required|min_value:1'"
              :class="{'input': true, 'is-danger': errors.has('destinations') }"
              v-model="lot_item_destination"
            >
              <option value='null'> Selecione o Destino </option>
              <option v-for='(destination, index) in destinations' :key="index" :value='destination.id'>
                {{destination.name}}
              </option>
            </select>
            <span class="error-text" v-show="errors.first('destinations')"> Selecione um item </span>
          </div>
        </div>

        <div class="col-sm-3 button-margin-top">
          <button type='submit' class="btn btn-success full-width">
            Alterar Destino
          </button>
        </div>
      </div>
    </form>

    <div><br>
      <b-alert show dismissible variant="danger" v-if="errorSelected">
        Selecione um item antes de adicionar.
      </b-alert>
    </div>


    <div class="table-scroll mt-5">
      <table class="table table-hover table-bordered">
        <thead>
          <tr>
            <th scope="col">Tipo </th>
            <th scope="col">Fabricante </th>
            <th scope="col">Modelo </th>
            <th scope="col">Número de Série</th>
            <th scope="col">Cód. Barras</th>
            <th scope="col">Destino </th>
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

      <b-alert show v-if="showAlertNullItem" variant="warning">
        <center>
          Nenhum item encontrado.
        </center>
      </b-alert>
    </div>

    <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
      <center>
        <img  class="size-img-modal" src="../../../../assets/images/checked.png"/>
      </center>
      <p class="my-1"> {{ messageModal }} </p>
    </b-modal>

    <b-button class="mt-3" variant="success" block @click="addItem"> Adcionar item</b-button>

  </b-modal>
</template>

<script>
  export default {
    components: { },

    props: ['props_data'],

    data() {
      return {
        search_lot: {
          bar_code:      undefined,
          lot_number:    undefined,
          serial_number: undefined
        },

        lot_items: [],
        lot_destionation: null,
        lot_item_id: null,
        destinations: [],
        lot_item_destination: null,
        showDestiny: false,

        showModal: false,
        messageModal: '',
        index: null,
        add_item: false,
        errorSelected: false,
        showAlertNullItem: false
      }
    },

    computed: { },

    mounted() {},

    methods: {

      async searchLot() {
        this.showLoading()
        this.lot_items = []
        this.index = null
        let response = null;
        if ( this.search_lot.bar_code == '') { this.search_lot.bar_code = undefined }
        if ( this.search_lot.lot_number == '') { this.search_lot.lot_number = undefined }
        if ( this.search_lot.serial_number == '') { this.search_lot.serial_number = undefined }

        let way = null

        if( this.props_data.add_item === true) {
          way = `/search_lot/${this.search_lot.bar_code}/${this.search_lot.lot_number}/${this.search_lot.serial_number}/${this.props_data.add_item}`
        } else {
          way = `/search_lot/${this.search_lot.bar_code}/${this.search_lot.lot_number}/${this.search_lot.serial_number}/${this.add_item}`
        }

        await this.$http.get( way )
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if (response.status == 200) {
          this.lot_items = response.body
          this.lot_destionation = this.lot_items.destination
          this.showDestiny = true
        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = "Erro ao cadastrar novo usuário.";
        }

        if ( this.lot_items.length === 0 ) {
          this.showAlertNullItem = true
        } else {
          this.showAlertNullItem = false
        }

        this.loader.hide()
      },

      async getDestinations() {
        let response = null;
        await this.$http.get('/transfer_destinations')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.destinations = response.body;
        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
        this.loading = false
      },

      async submit() {
        this.$validator.validate().then((result) => {
          if( result ) {
            this.updateDestination()
          }
        });
      },

      async updateDestination() {
        let response = null
        let data = {
          id: this.lot_item_id,
          destination: this.lot_item_destination
        }

        await this.$http.post(`/change_destination`, {lot_item_destination: data})
          .then(resp => {
            response = resp;
          })
          .catch(resp => {
            response = resp;
          });

        if (response.status == 200) {
          this.showModal = true;
          this.messageModal = response.body.message;
          this.lot_items = [];
          this.showDestiny = false;
          this.lot_destionation = null;
          this.search_lot.bar_code = undefined;
          this.search_lot.lot_number = undefined;
          this.search_lot.serial_number = undefined;

          setTimeout(function(){
            this.showModal = false
          }.bind(this), 2000);

        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = response.body.message;
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

      async addItem () {
        if(this.lot_item_id === null ) {
          this.errorSelected = true
          return
        }

        let response = null
        this.errorSelected = false

        await this.$http.post(`/sales_orders/${this.props_data.sales_order_id}/add_item`, {lot_id: this.lot_item_id})
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.messageModal = response.body.message
          this.showModal = true
          this.lot_items = []
          this.index = null
          this.$emit('callComponente');

          setTimeout(function(){
            this.showModal = false
            this.$refs['my-modal'].hide()
          }.bind(this), 2000);
        }
      },

      showLoading() {
        this.loader = this.$loading.show({
          container: this.fullPage ? null : this.$refs.formContainer,
          canCancel: false,
          backgroundColor: '#000',
          opacity: 0.75
        });
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
