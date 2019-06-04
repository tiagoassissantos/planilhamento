<template>
  <div class='container'>
    <div class="card">

      <div class="card-header">
        Novo Lote
      </div>

      <div class="card-body">
        <div class='row'>
          <div class="col-sm-8">
            <div class="form-group">
              <input class="form-control" type="email" v-model='lot.order_number' placeholder="Número do Pedido" />
            </div>
          </div>

          <div class="col-sm-2">
            <button type='button' v-on:click='submit()' class="btn btn-primary">
              Criar
            </button>
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
        lot_id: null,
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

    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/lots/${this.lot_id}`, {lot: this.lot})
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

      showLoading() {
        this.loader = this.$loading.show({
          container: this.fullPage ? null : this.$refs.formContainer,
          canCancel: false,
          backgroundColor: '#000',
          opacity: 0.75
        });
      },

      async getCategory(){
        let response = null;

        await this.$http.get(`/categories/${this.category_id}`)
        .then((result) => {
          this.category =  result.body
        }).catch((err) => {
          response = err.body
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
