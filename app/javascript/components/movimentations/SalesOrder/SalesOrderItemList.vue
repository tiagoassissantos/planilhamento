<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        <div class="row">
          <div class="col-sm-9">
            Itens do Pedido
          </div>
          <div class="col-sm-3">
            Número do Pedido: {{sales_orders.order_number}}
          </div>
        </div>

      </div>
      <div class="card-body">

        <sales-order-item-list-table/>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import SalesOrderItemListTable from '../SalesOrder/SalesOrderItemListTable.vue'
  export default {
    components: { SalesOrderItemListTable },

    data(){
      return{
        sales_orders: {},
        sales_order_id: null
      }
    },

    computed: {},

    mounted() {
      this.sales_order_id = this.$route.params.sales_order_id
      this.getSalesOrder()
    },

    methods: {

      async getSalesOrder() {
        let response = null

        await this.$http.get(`/sales_orders/${this.sales_order_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.sales_orders = response.body;
        }
      }

    }
  };
</script>

<style scoped>
  .card {
    margin-top: 30px;
  }
</style>
