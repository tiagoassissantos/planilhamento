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
        <form @submit.prevent="submit">
          <div class='row'>

            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="text" v-model='user.name' placeholder="Nome do Usuário" required/>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="text" v-model='user.email' placeholder="E-mail do Usuário" required/>
              </div>
            </div>
          </div>

          <div class='row'>
            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="text" v-model='user.cpf' placeholder="CPF do Usuário" />
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <select class="form-control" type="text" v-model='user.role' required>
                  <option value=''>Selecione o Perfil do Usuário</option>
                  <option value='admin'>Administrador</option>
                  <option value='operator_n1'>Operador N1</option>
                  <option value='operator_n2'>Operador N2</option>
                  <option value='operator_comercial'>Operador Comercial</option>
                  <option value='operator_marketing'> Operador Marketing </option>
                  <option value='operator_warranty'>Operador Pós venda & Garantia </option>
                </select>
              </div>
            </div>
          </div>

          <div class='row'>
            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="password" v-model='user.password' placeholder="Senha" required/>
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="password" v-model='user.password_confirmation' placeholder="Repita a senha" required/>
              </div>
            </div>
          </div>
          <div class='row'>
            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                {{button_text}}
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
        user: {
          name: '',
          email: '',
          cpf: '',
          role: '',
          password: '',
          password_confirmation: ''
        },

        loader: null,
        edit: false,
        user_id: null,
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
      this.$store.dispatch('getCurrentUser');
      this.$store.subscribe((mutation, state) => {
        if (mutation.type == 'SET_CURRENT_USER') {
          if(this.getCurrentUser.role != "Administrador"){
            this.$router.push('/')
          }
        }
      }),

      this.user_id = this.$route.params.user_id
      if( this.user_id != null){
        this.edit = true
        this.getUser()
        this.header_text = 'Editar Usuário'
        this.button_text = 'Editar'
      }else{
        this.header_text = 'Novo Usuário'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;

        let data = {
          email: this.user.email,
          password: this.user.password,
          password_confirmation: this.user.password_confirmation,
          name: this.user.name
        }

        if( this.user.password != this.user.password_confirmation){
          this.messageClass = "danger";
          this.error = true;
          this.message = "Erro, as senhas devem ser iguais.";

        }else {
          if (this.edit) {
            await this.$http.put(`/users/${this.user_id}`, {user: this.user})
            .then((result) => {
              response = result;
              this.messageModal = 'Usuário editado com sucesso'
            }).catch((err) => {
              response = err
            });

          } else {

            await this.$http.post("/users", {user: this.user })
              .then(resp => {
                response = resp;
                this.messageModal = 'Usuário cadastrado com sucesso'

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
              this.$router.push('/users')
            }.bind(this), 2000);

          } else {
            this.messageClass = "danger";
            this.error = true;
            this.message = "Erro ao cadastrar novo usuário.";
          }
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

      async getUser(){
        let response = null;
        await this.$http.get(`/users/${this.user_id}`)
        .then((result) => {
          this.user = result.body
        }).catch((err) => {
          response = err.body
        });
      },
    }
  };

</script>

<style scoped>
  .card {
    margin-top: 50px;
  }


</style>
