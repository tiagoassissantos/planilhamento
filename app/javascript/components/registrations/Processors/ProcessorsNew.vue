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
        <form @submit.prevent.once="validationBeforeSubmit">
          <div class='row'>
            <div class="col-sm-8">
              <div class="form-group">
                <input
                  class="form-control"
                  type="text"
                  v-model='processor.name'
                  placeholder="Nome do Processador"
                  name="processor"
                  v-validate="'required'"
                  :class="{'input': true, 'is-danger': errors.has('processor') }"
                />
                <span class="error-text" v-show="errors.first('processor')"> Este campo é obrigatório  </span>
              </div>
            </div>

            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                {{button_text}} {{ modal_params }}
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
        processor: {
          name: ''
        },
        loader: null,
        edit: false,
        processor_id: null,
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
      },

      getCurrentUser() {
        return this.$store.state.currentUser
      }

    },

    mounted() {
      this.$store.dispatch('isLogged');

      this.processor_id = this.$route.params.processor_id
      if( this.processor_id != null){
        this.edit = true
        this.getProcessor()
        this.header_text = 'Editar Processador'
        this.button_text = 'Editar'
      }else{
        this.header_text = 'Novo Processador'
        this.button_text = 'Cadastrar'
      }

      this.$store.dispatch('getCurrentUser');
      this.$store.subscribe((mutation, state) => {
        if (mutation.type == 'SET_CURRENT_USER') {
          if(
            this.getCurrentUser.role == "Operador N2"         ||
            this.getCurrentUser.role == "Operador Comercial"  ||
            this.getCurrentUser.role == "Operador Marketing"  ||
            this.getCurrentUser.role == "Operador Pós-Venda / Garantia"
          ){
              this.$router.push('/')
          }
        }
      })

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

        if(this.edit){
          await this.$http.put(`/processors/${this.processor_id}`,
          JSON.stringify({processor: this.processor}))
          .then((result) => {
            response = result;
            this.messageModal = 'Processador editado com sucesso'
          }).catch((err) => {
            response = err
          });

        }else{

          await this.$http.post("/processors", this.processor)
            .then(resp => {
              response = resp;
              this.messageModal = 'Processador cadastrado com sucesso'
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
            this.$router.push('/processors');

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

      async getProcessor(){
        let response = null;

        await this.$http.get(`/processors/${this.processor_id}`)
        .then((result) => {
          this.processor = result.body
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
