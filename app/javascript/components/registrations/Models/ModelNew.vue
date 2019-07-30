<template>
  <div class='container'>

    <div class="margin-alert response-display">
      <b-alert show dismissible v-if="error" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="card response-display">
      <div class="card-header">
        {{ header_text }}
      </div>

      <div class="card-body">
        <form @submit.prevent="validationBeforeSubmit">
          <div class='row'>

            <div class="col-md-5">
              <div class="form-group">
                <select class="form-control" type="text" v-model='model.manufacturer_id' required>
                  <option value='0'>Selecione o Fabricante</option>
                  <option v-for='(manufacturer,index) in manufacturers' :key="index" :value='manufacturer.id'>
                    {{manufacturer.name}}
                  </option>
                </select>
              </div>
            </div>

            <div class="col-md-5">
              <div class="form-group">
                <input
                  class="form-control"
                  type="text"
                  v-model='model.name'
                  placeholder="Nome do Modelo"
                  name="model"
                  v-validate="'required'"
                  :class="{'input': true, 'is-danger': errors.has('model') }"
                />
                <span class="error-text" v-show="errors.first('model')"> Este campo é obrigatório  </span>
              </div>
            </div>

            <div class="col-md-2">
              <button type='submit' class="btn btn-primary">
                {{button_text}} {{modal_params}}
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
        model: {
          name: '',
          manufacturer_id: 0,
        },
        model_id: null,
        manufacturers: [],
        loader: null,
        edit: false,
        error: false,
        messageClass: '',
        message: '',
        header_text: '',
        button_text: '',

        showModal: false,
        messageModal: '',
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getManufacturers();

      this.model_id = this.$route.params.model_id
      if ( this.model_id != null) {
        this.edit = true
        this.getModel()
        this.header_text = 'Editar Modelo'
        this.button_text = 'Editar'

      } else {
        this.header_text = 'Novo Modelo'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async getManufacturers() {
        let response = null;
        await this.$http.get('/manufacturers')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.manufacturers = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },


      async getModel(){
        let response = null;

        await this.$http.get(`/models/${this.model_id}`)
        .then((result) => {
          this.model.name = result.body.name
          this.model.manufacturer_id = result.body.manufacturer.id

        }).catch((err) => {
          response = err.body
        });
      },

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
          await this.$http.put(`/models/${this.model_id}`,
            this.model)
            .then((result) => {
              response = result;
              this.messageModal = 'Modelo editado com sucesso'

            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post("/models", this.model)
            .then(resp => {
              response = resp;
              this.messageModal = 'Modelo cadastrado com sucesso'
            })
            .catch(resp => {
              response = resp;
            });
        }

        if (response.status == 200) {
          this.messageClass = "success";
          this.showModal = true

          setTimeout(function(){
            this.showModal = false
            this.$router.push('/models')
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

      async getManufacturer(){
        let response = null;

        await this.$http.get(`/manufacturers/${this.manufacturer_id}`)
        .then((result) => {
          this.manufacturer =  result.body
        }).catch((err) => {
          response = err.body
        });
      }
    },

    props: {
      modal_params: String
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
  }
</style>
