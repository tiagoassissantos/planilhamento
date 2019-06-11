<template>
  <div class='container'>

    <div class="margin-alert">
      <b-alert show dismissible v-if="error" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="card">
      <div class="card-header">
        {{ header_text }}
      </div>

      <div class="card-body">
        <form @submit.prevent="submit">
          <div class='row'>
            <div class="col-sm-8">
              <div class="form-group">
                <input class="form-control" type="text" v-model='keyboard_type.name' placeholder="Tipo de Teclado" />
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
        keyboard_type: {
          name: ''
        },
        loader: null,
        edit: false,
        keyboardTypeId: null,
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
      this.keyboardTypeId = this.$route.params.keyboard_type_id

      if ( this.keyboardTypeId != null) {
        this.edit = true
        this.getCategory()
        this.header_text = 'Editar Categoria'
        this.button_text = 'Editar'
      } else {
        this.header_text = 'Novo Categoria'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/keyboard_types/${this.keyboardTypeId}`, this.keyboard_type)
          .then((result) => {
            response = result;
            this.messageModal = 'Tipo de teclado editado com sucesso'

          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post("/keyboard_types", this.keyboard_type)
            .then(resp => {
              response = resp;
              this.messageModal = 'Tipo de teclado cadastrado com sucesso'
            })
            .catch(resp => {
              console.log(response);
              response = resp;
            });
        }


        if (response.status == 200) {
          this.messageClass = "success";
          this.showModal = true     

          setTimeout(function(){ 
            this.showModal = false     
            this.$router.push('/keyboard-types');     
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

      async getCategory(){
        let response = null;

        await this.$http.get(`/keyboard_type/${this.keyboard_type}`)
        .then((result) => {
          this.keyboard_type =  result.body
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
</style>
