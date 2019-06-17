<template>
  <div id="app">
    <div class='row'>
      <div class="col-sm-8">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click="input = null">Limpar pesquisa</button>
          </div>
        </div>
      </div>

      <div class="col-sm-2 offset-sm-2">
        <router-link to="/sales-order/new" class="btn btn-primary float-right">
          Novo Pedido
        </router-link>
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
            <th scope="col">Editar</th>
            <th scope="col">Código</th>
            <th scope="col">Núm. do Pedido</th>
            <th scope="col"> Adc. Item </th>
            <th scope="col"> Visualizar Itens </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(sales_order,index) in sales_orders" :key="index" v-if="regExp( sales_order )">
            <td>
              <router-link :to="{ path: `/sales-order/${sales_order.id}/edit`}">
                <img src='../../../../assets/images/editar.png'/>
              </router-link>
            </td>
            <td>
              {{ sales_order.id }}
            </td>
            <td>
              {{ sales_order.order_number }}
            </td>
            <td>
              <router-link :to="{ path:`/sales-order/${sales_order.id}/item` }">
                <img src='../../../../assets/images/plus.png' class="plus"/>
              </router-link>
            </td>
            <td>
              <img src='../../../../assets/images/view.png' class="plus"/>
            </td>
          </tr>
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
        showAlert: false,
        message: '',
        messageClass: '',
        input: null,

        sales_orders: []

      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getSalesOrders()
    },

    methods: {
      async getSalesOrders() {
        let response = null

        await this.$http.get('/sales_orders')
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.sales_orders = response.body
        }
      },

      regExp( sales_order ) {
        var id = sales_order.id.toString()
        var order_number = sales_order.order_number.toString()

        if( this.input === null){
          return true
        }else {
          this.input = this.input.toLowerCase()
          if( id.match(this.input) || order_number.match(this.input) ){
            return true
          }else{
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
