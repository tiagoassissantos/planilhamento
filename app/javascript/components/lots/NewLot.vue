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
        <div class='row mb-3' v-if='edit'>
          <div class="col-sm-8">
            <h5>Número do lote: {{lot.id}}</h5>
          </div>
        </div>

        <div class='row'>
          <div class="col-sm-12">
            <form @submit.prevent.once="validationBeforeSubmit">
              <div class="form-group row">
                <label class='col-sm-2 col-form-label'>Número do Pedido:</label>
                <div class="col-sm-4">
                  <input
                    class="form-control ml-3"
                    type="text"
                    v-model='lot.order_number'
                    placeholder="Número do Pedido"
                    name="lot"
                    v-validate="'required'"
                    :class="{'input': true, 'is-danger': errors.has('lot') }"
                  />
                  <span class="error-text" v-show="errors.first('lot')"> Este campo é obrigatório  </span>
                </div>
              </div>

              <button type='submit' class="btn btn-primary">
                {{button_text}}
              </button>

              <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
                <center>
                  <img  class="size-img-modal" src="../../../assets/images/checked.png"/>
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
        lot: { order_number: '', status: 0 },
        loader: null,
        edit: false,
        lotId: null,
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
      getCurrentUser() {
        return this.$store.state.currentUser
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id;

      if ( this.lotId != null) {
        this.edit = true
        this.getLot()
        this.header_text = 'Editar Lote'
        this.button_text = ' Salvar edição de lote'

      } else {
        this.header_text = 'Novo Lote'
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
          await this.$http.put(`/lots/${this.lotId}`, {lot: this.lot})
          .then((result) => {
            response = result;
            this.messageModal = 'Lote editado com sucesso'
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post("/lots", this.lot)
            .then(resp => {
              response = resp;
              this.messageModal = 'Lote cadastrado com sucesso'
            })
            .catch(resp => {
              response = resp;
            });
        }

        if (response.status == 200) {
          this.error = false
          this.showModal = true

          setTimeout(function() {
            this.showModal = false
            this.$router.push('/lots')
          }.bind(this), 2000);

        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = response.body.message;
        }
        this.loader.hide()
      },

      async getLot() {
        let response = null;
        await this.$http.get(`lots/${this.lotId}`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.lot = response.body;
        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      showLoading() {
        this.loader = this.$loading.show({
          container: this.fullPage ? null : this.$refs.formContainer,
          canCancel: false,
          backgroundColor: '#000',
          opacity: 0.75
        });
      },

      updateStatus( status ) {
        if (status === 'Aberto') { this.lot.status = 'Fechado', this.button_text_status = 'Fechar lote'}
        if( status === 'Fechado') { this.lot.status = 'Reaberto', this.button_text_status = 'Reabrir lote' }
        if( status === 'Reaberto') { this.lot.status = 'Fechado', this.button_text_status = 'Fechar lote' }
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
