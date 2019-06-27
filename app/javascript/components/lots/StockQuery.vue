<template>
  <div class='container'>
    <div class="card response-display">

      <div class="card-header">
        <div class="row">
          <div class="col-md-8 col-sm-12">
            Consulta de Itens no Estoque
          </div>
          <div class="col-md-2 col-sm-6">
            <a :href="way" v-if="can_export()" class="btn btn-success"> Exportar XLS </a>
          </div>
          <div class="col-md-2 col-sm-6">
            <button class="btn btn-danger" @click="cleanSearch()"> Limpar Busca </button>
          </div>
        </div>
      </div>

      <div class="card-body">
        <form>
          <div class='row'>
            <div class="col-sm-4">
              <div class="form-group">
                <label> Tipo de Hardware </label>
                  <select class="form-control" type="text" v-model='search_items.h_type_id' >
                    <option value='undefined'> Selecione um tipo de hardware </option>
                    <option v-for='(hardwareType,index) in h_types' :key="index" :value='hardwareType.id' >
                      {{hardwareType.name}}
                    </option>
                  </select>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <label> Fabricante </label>
                <select class="form-control" type="text" v-model='search_items.manufacturer_id' >
                  <option value='undefined'> Selecione um fabricante </option>
                  <option v-for='(manufacturer,index) in manufacturers' :key="index" :value='manufacturer.id' >
                    {{manufacturer.name}}
                  </option>
                </select>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <label> Modelo </label>
                <select class="form-control" type="text" v-model='search_items.model_id' >
                  <option value='undefined'> Selecione um modelo </option>
                  <option v-for='(model,index) in models' :key="index" :value='model.id' >
                    {{model.name}}
                  </option>
                </select>
              </div>
            </div>

            <div class="col-sm-12 button-margin-top">
              <button type='submit' class="btn btn-primary full-width" @click="searchItems()">
                Buscar Itens
              </button>
            </div>
          </div>
        </form>

        <div><br>
          <b-alert show dismissible variant="danger" v-if="errorSelected">
            Selecione um dos itens para realizar a pesquisa.
          </b-alert>
        </div>

        <div class="table-scroll mt-5">
          <table class="table table-hover table-bordered">
            <thead>
              <tr>
                <th scope="col"> Tipo </th>
                <th scope="col"> Fabricante </th>
                <th scope="col"> Modelo </th>
                <th scope="col"> Número de Série </th>
                <th scope="col"> Cód. Barras </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(lot_item, index) in lot_items" :key="index">
                <td> {{ lot_item.hardware_type }}</td>
                <td> {{ lot_item.model.manufacturer.name }}</td>
                <td> {{ lot_item.model.name }} </td>
                <td> {{ lot_item.serial_number }} </td>
                <td> {{ lot_item.bar_code }} </td>
              </tr>
            </tbody>
          </table>

          <b-alert show v-if="showAlertNullItem" variant="warning">
            <center>
              Nenhum item encontrado.
            </center>
          </b-alert>

        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>

  export default {

    components: {},

    data() {
      return {
        search_items: { h_type_id: undefined, manufacturer_id: undefined, model_id: undefined },
        lot_items: [],
        h_types: [],
        manufacturers: [],
        models: [],
        errorSelected: false,
        way: '',
        show_export: false,
        showAlertNullItem: false
      }
    },

    computed: { },

    mounted() {
      this.getAllHardwareType()
      this.getAllManufacturers()
      this.getAllModels()
    },

    methods: {
      async getAllHardwareType() {
        let response = null

        await this.$http.get('/hardware_types')
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.h_types = response.body
        }
      },

      async getAllManufacturers() {
        let response = null

        await this.$http.get('/manufacturers')
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.manufacturers = response.body
        }
      },

      async getAllModels() {
        let response = null

        await this.$http.get('/models')
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.models = response.body
        }
      },

      async searchItems() {
        this.showLoading()
        if(
            this.search_items.model_id == undefined &&
            this.search_items.manufacturer_id == undefined &&
            this.search_items.h_type_id == undefined
          ) {
          this.errorSelected = true
          this.loader.hide()
          return
        } else {
          this.errorSelected = false
        }

        this.lot_items = []
        let response = null
        let way = null

        way = `/get_stock/${this.search_items.h_type_id}/${this.search_items.manufacturer_id}/${this.search_items.model_id}`
        await this.$http.get( way )
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.lot_items = response.body
          let items_id = []

          this.lot_items.forEach(lot_item => {
            items_id.push(lot_item.id)
          })
          this.way = `/report_xls?lot_items=${items_id}`
          this.show_export = true

          if ( this.lot_items.length === 0 ) {
            this.showAlertNullItem = true
          } else {
            this.showAlertNullItem = false
          }
        }
        this.loader.hide()
      },

      cleanSearch() {
        this.search_items = { h_type_id: undefined, manufacturer_id: undefined, model_id: undefined }
        this.lot_items = []
        this.showAlertNullItem = false
      },

      showLoading() {
        this.loader = this.$loading.show({
          container: this.fullPage ? null : this.$refs.formContainer,
          canCancel: false,
          backgroundColor: '#000',
          opacity: 0.75
        });
      },

      can_export() {
        if ( this.show_export && this.lot_items.length > 0 ) {
          return true
        } else {
          return false
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

  .style-select {
    cursor: pointer;
  }
</style>
