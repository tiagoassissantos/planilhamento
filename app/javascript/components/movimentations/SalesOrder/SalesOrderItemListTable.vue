<template>
  <div id="app">
    <div class='row'>
      <div class="col-md-8 col-sm-12">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click="input = null">Limpar pesquisa</button>
          </div>
        </div>
      </div>

      <div class="col-md-2 offset-md-2 col-sm-12">
        <b-button v-b-modal.newItem variant='primary'> Adicionar Item </b-button>
      </div>
    </div>

    <div class="margin-alert">
      <b-alert show dismissible v-if="showAlert" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="table-scroll">
      <table class="table table-hover table-bordered">
        <thead>
          <tr>
            <th scope="col"> Código </th>
            <th scope="col"> Produto </th>
            <th scope="col"> Num. Série </th>
            <th scope="col"> SKU </th>
            <th scope="col"> Categoria </th>
            <th scope="col"> Destino </th>
            <th scope="col"> Código de Barras </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(sales_orders_item, index) in sales_orders_items" :key="index" v-if="regExp( sales_orders_item )">
            <td>
              {{ sales_orders_item.id }}
            </td>

            <td>
              <span v-if="sales_orders_item.hardware_type != null" >
                {{ sales_orders_item.hardware_type }}
              </span>
            </td>

            <td>
              <span v-if="sales_orders_item.serial_number != null" >
                {{ sales_orders_item.serial_number }}
              </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sales_orders_item.sku_id != null" >
                {{ sales_orders_item.sku_id}}
              </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sales_orders_item.category != null" >
                {{ sales_orders_item.category }}
              </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sales_orders_item.destination != null" >
                {{ sales_orders_item.destination }}
              </span>
            </td>

            <td>
              {{ sales_orders_item.bar_code}}
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <new-item />
  </div>
</template>

<script>
  import newItem from './AddItemSalesOrder.vue';

  export default {
    components: { newItem },

    data() {
      return {
        showAlert: false,
        message: '',
        messageClass: '',
        input: null,

        sales_orders_items: [],
        sales_order_id: null
      }
    },

    computed: {},

    mounted() {
      this.sales_order_id = this.$route.params.sales_order_id
      this.getSalesOrdersItems()
    },

    methods: {
      async getSalesOrdersItems () {
        let response = null

        await this.$http.get(`/sales_orders/${this.sales_order_id}/sales_orders_items`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.sales_orders_items = response.body
        }
      },

      regExp( lotItem ) {
        var lotItem_id = lotItem.id.toString()
        var hardware_type = lotItem.hardware_type.toLowerCase()
        var destination = lotItem.destination.toLowerCase()
        var bar_code = lotItem.bar_code.toLowerCase()
        var category = lotItem.category.toLowerCase()
        var sku = lotItem.sku_id.toLowerCase()

        if( this.input === null) {
          return true
        }else {
          this.input = this.input.toLowerCase()

          if( lotItem_id.match(this.input) || hardware_type.match(this.input)
              ||  destination.match(this.input) || bar_code.match(this.input)
              || category.match(this.input) || sku.match(this.input) ) {
            return true
          }else {
            return false
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

  .plus {
    width: 30px;
  }
</style>
