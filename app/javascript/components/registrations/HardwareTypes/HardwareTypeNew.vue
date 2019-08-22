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
            <div class="col-sm-8">
              <div class="form-group">
                <input
                  class="form-control"
                  type="text"
                  v-model='hardware_type.name'
                  placeholder="Tipo de Hardware"
                  name="h_type"
                  v-validate="'required'"
                  :class="{'input': true, 'is-danger': errors.has('h_type') }"
                />
                <span class="error-text" v-show="errors.first('h_type')">  Este campo é obrigatório  </span>
              </div>
            </div>

            <div class="col-sm-2">
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
        hardware_type: {
          name: ''
        },
        loader: null,
        edit: false,
        hardware_id: null,
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

      this.hardware_id = this.$route.params.hardware_id
      if( this.hardware_id != null){
        this.edit = true
        this.getHardwareType()
        this.header_text = 'Editar dados do Hardware'
        this.button_text = 'Editar'
      }else{
        this.header_text = 'Novo Tipo de Hardware'
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
          await this.$http.put(`/hardware_types/${this.hardware_id}`, JSON.stringify({hardware_type: this.hardware_type}))
          .then((result) => {
            response = result;
            this.messageModal = 'Tipo de hardware editado com sucesso.'

          }).catch((err) => {
            response = err
          });

        }else{

          await this.$http.post("/hardware_types", this.hardware_type)
            .then(resp => {
              response = resp;
              this.messageModal = 'Tipo de hardware cadastrado com sucesso.'
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
            this.$router.push('/hardware-types')
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

      async getHardwareType(){
        let response = null;

        await this.$http.get(`/hardware_types/${this.hardware_id}`)
        .then((result) => {
          this.hardware_type =  result.body
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
