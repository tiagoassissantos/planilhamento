<template>
  <div class='container'>

    <div class="margin-alert">
      <b-alert show dismissible v-if="error" :variant="messageClass">
        {{message}}
      </b-alert>
    </div>

    <div class="card response-display">
      <div class="card-header">
        {{ header_text }}
      </div>

      <div class="card-body">
        <div class='row'>
          <div class="col-sm-12">
            <form @submit.prevent="validationBeforeSubmit">
              <div class="form-group row">
                <label class='col-sm-2 col-form-label'>Número do Pedido:</label>
                <div class="col-sm-4">
                  <input
                    class="form-control ml-3"
                    type="text"
                    name="sales_number"
                    v-model='sales_order.order_number'
                    placeholder="Número do Pedido"
                    v-validate="'required'"
                    :class="{'input': true, 'is-danger': errors.has('sales_number') }"
                  />
                  <span class="error-text" v-show="errors.first('sales_number')">  Este campo é obrigatório  </span>
                </div>
              </div>

              <button type='submit' class="btn btn-primary">
                {{button_text}}
              </button>

              <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
                <center>
                  <img  class="size-img-modal" src="../../../../assets/images/checked.png"/>
                </center>
                <p class="my-1"> {{ messageModal }} </p>
              </b-modal>

            </form>
          </div>
        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  export default {
    components: {  },

    data() {
      return {
        sales_order: {
          order_number: null
        },
        sales_order_id: null,

        loader: null,
        edit: false,
        error: false,
        messageClass: '',
        message: '',

        header_text: '',
        button_text: '',

        button_text_status: '',
        user_admin: false,

        showModal: false,
        messageModal: '',
      }
    },

    computed: {
    },

    mounted() {
      this.sales_order_id = this.$route.params.sales_order_id
      if( this.sales_order_id != null) {
        this.edit = true
        this.header_text = 'Editar Pedido'
        this.button_text = 'Editar'
        this.getSalesOrder()
      }else {
        this.header_text = 'Novo Pedido'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {

      validationBeforeSubmit() {
        this.$validator.validateAll().then((result) => {
          if (result) {
            this.submit()
            return;
          }
       });
      },

      async submit() {
        this.showLoading()
        let response = null;

        if (this.edit) {
          await this.$http.put(`/sales_orders/${this.sales_order_id}`, {sales_order: this.sales_order})
          .then((result) => {
            response = result;
            this.messageModal = 'Pedido editado com sucesso'
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post("/sales_orders", this.sales_order)
            .then(resp => {
              response = resp;
              this.messageModal = 'Pedido cadastrado com sucesso'
            })
            .catch(resp => {
              response = resp;
            });
        }

        if (response.status == 200) {
          this.error = false
          this.showModal = true

            setTimeout(function(){
            this.showModal = false
            this.$router.push('/sales-order')
          }.bind(this), 2000);

        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = response.body.message;
        }
        this.loader.hide()
      },

      async getSalesOrder() {
        let response = null

        await this.$http.get(`/sales_orders/${this.sales_order_id}`)
          .then((result) => {
            response = result
        }).catch((err) => {
          response = err
        });

        if( response.status === 200 ) {
          this.sales_order = response.body
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

  .error-text {
    color: red;
    font-size: 12px;
    font-weight: bold;
    margin-left: 20px;
  }
</style>
