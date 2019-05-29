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

            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="text" v-model='user.name' placeholder="Nome do Usuário" />
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="text" v-model='user.email' placeholder="E-mail do Usuário" />
              </div>
            </div>
          </div>

          <div class='row'>
            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="password" v-model='user.password' placeholder="Senha" />
              </div>
            </div>

            <div class="col-sm-4">
              <div class="form-group">
                <input class="form-control" type="repeat_password" v-model='user.password_confirmation' placeholder="Repita a senha" />
              </div>
            </div>

            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                {{button_text}}
              </button>
            </div>
          </div>
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
          name: ''
        },
        loader: null,
        edit: false,
        user_id: null,
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
      this.$store.dispatch('isLogged');

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

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/users/${this.user_id}`,
          JSON.stringify({user: this.user}))
          .then((result) => {
            response = result;
          }).catch((err) => {
            response = err
          });

        } else {

          await this.$http.post("/users", {user: this.user })
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
          //this.$router.push('/users')

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

      async getUser(){
        let response = null;

        await this.$http.get(`/users/${this.user_id}`)
        .then((result) => {
          this.user = result.body
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
