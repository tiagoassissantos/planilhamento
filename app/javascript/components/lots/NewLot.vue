<template>
  <div class='container'>
    <div class="card">

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

            <form class='form-inline' @submit.prevent="submit">
              <div class="form-group">
                <label class=''>Número do Pedido:</label>
                <input class="form-control ml-3" type="text" v-model='lot.order_number' placeholder="Número do Pedido" />
              </div>

              <button type='submit' class="btn btn-primary ml-3">
                {{button_text}}
              </button>
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
        lot: { order_number: '' },
        loader: null,
        edit: false,
        lotId: null,
        error: false,
        messageClass: '',
        message: '',

        header_text: '',
        button_text: ''
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id;

      if ( this.lotId != null) {
        this.edit = true
        this.getLot()
        this.header_text = 'Editar Lote'
        this.button_text = 'Editar'
      } else {
        this.header_text = 'Novo Lote'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/lots/${this.lotId}`, {lot: this.lot})
          .then((result) => {
            response = result;
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post("/lots", this.lot)
            .then(resp => {
              response = resp;
            })
            .catch(resp => {
              console.log(response);
              response = resp;
            });
        }

        if (response.status == 200) {
          this.messageClass = "success";
          this.$router.push(`/lots`)

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
      }
    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
