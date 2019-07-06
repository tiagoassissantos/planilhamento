<template>
  <div class='container'>

    <div class="margin-alert response-display">
      <b-alert show dismissible v-if="error" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="card response-display">
      <div class="card-header">
        Arquivo SKU
      </div>
      <div class="container mt-3">
        <strong> Descrição do SKU  </strong>
        <div class="row mt-3 mb-3">
          <div class="col-sm-6 col-md-3">
            <strong>Código: </strong>{{ sku.code }}
          </div>

          <div class="col-sm-6 col-md-3">
            <strong> Tipo de Hardware: </strong> {{ sku.hardware_type}}
          </div>

          <div class="col-sm-6 col-md-3">
            <strong> Fabricante: </strong> {{ sku.manufacturer}}
          </div>

          <div class="col-sm-6 col-md-3">
            <strong> Modelo: </strong> {{ sku.model}}
          </div>
        </div>
      </div>

      <div class="card-body">
        <form @submit.prevent="submit">
          <div class='row'>
            <div class="col-sm-8">
              <div class="form-group">
                <b-form-file
                  required
                  ref="archive_file"
                  placeholder='Escolha ou arraste o arquivo.'
                  drop-placeholder="Arraste o arquivo aqui..."
                />
              </div>
            </div>

            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                Upload
              </button>
            </div>
          </div>

          <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
            <center>
              <img  class="size-img-modal" src="../../../../assets/images/checked.png"/>
            </center>
            <p class="my-1"> {{ messageModal }} </p>
          </b-modal>

        </form>
      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  export default {
    components: {  },

    data() {
      return {
        loader: null,
        error: false,
        messageClass: '',
        message: '',
        sku_id: null,
        showModal: false,
        messageModal: '',
        sku: {}
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
      this.sku_id = this.$route.params.sku_id
      this.getSku()
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;
        let formData = new FormData();
        formData.append("archive_file", this.$refs.archive_file.$refs.input.files[0]);

          await this.$http.patch(`/skus/${this.sku_id}`, formData, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          })
          .then((result) => {
            response = result;
            this.messageModal = 'Arquivo enviado com sucesso.'
          }).catch((err) => {
            response = err
          });

        if (response.status == 200) {
          this.messageClass = "success";
          this.showModal = true

          setTimeout(function(){
            this.showModal = false
            this.$router.push('/skus');

          }.bind(this), 2000);

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

      getSku() {
        this.$http.get(`/skus/${this.sku_id}`)
        .then((result) => {
          this.sku = result.body
        })
      }
    },
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }

  .outline-style {
    border: 1px solid black;
  }
</style>
