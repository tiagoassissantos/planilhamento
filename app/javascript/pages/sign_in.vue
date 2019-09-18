<template>
  <div id="app" class="main-page background-system">
    <navbar/>

    <div class="login-page">

      <div class="header-form"></div>
      <form class='signin_form' action="/users/sign_in" method="POST" @submit.prevent="submit">

        <div class="container">
          <center>
            <h4 class="name-form">Login</h4>
                <v-btn>Button</v-btn>

          </center>

          <b-alert v-if="error" show dismissible variant="danger"> Verifique seu Login e Senha.</b-alert>

          <div class="form-group">
            <label class="" for="login-email"> Email </label>
            <div class="input-group">
              <div class="input-group-prepend ">
                <div class="input-group-text icon-input">
                  <font-awesome-icon icon="envelope"/>
                </div>
              </div>
              <input
                type="email"
                name="auth_key"
                class="form-control input-color"
                id="login-email"
                placeholder="E-mail"
                v-model="email"
              >
            </div>
          </div>

          <div class="form-group">
            <label class="" for="login-password">Password</label>
            <div class="input-group">
              <div class="input-group-prepend ">
                <div class="input-group-text icon-input">
                  <font-awesome-icon icon="key"/>
                </div>
              </div>
              <input
                type="password"
                name="password"
                class="form-control input-color"
                id="login-password"
                placeholder="Senha"
                v-model="password"
              >
            </div>
          </div>
          <center>
            <button type="submit" class="btn btn-primary submit-form ">Entrar</button>
          </center>

          <div class="row">
            <div class="col-sm-7">
              <p class="info">
                <router-link to="forgot_password" class="link-tag text-show">Esqueceu a senha?</router-link>
              </p>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
  import navbar from "../components/navbar.vue";

  export default {
    components: { navbar},

    data: () => {
      return {
        email: '',
        password: '',
        error_text: '',
        error: false
      };
    },

    computed: { },

    mounted() {},

    methods: {

      sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
      },

      getLoggedStatus() {
        this.$http
          .get("/member/islogged")
          .then(response => {
            if (response.status == 200) {
              this.logged = response.body.logged;
            }
          })
          .catch(response => {
            this.error = true;
          });
      },

      async submit() {
        this.error = false;

        let response = null;
        let data = {user: {email: this.email, password: this.password}}


        await this.$http
          .post("/users/sign_in", JSON.stringify(data))
          .then(resp => { response = resp })
          .catch(resp => { response = resp });
        if (response.status == 200) {
          location.href = "/user-area";

        } else if (response.status == 401) {
          this.error_text = 'Usuário ou senha estão errados';
          this.error = true;

        } else {
          if (this.user.password != this.user.passwordConfirmation) {
            this.error_pwd = true
          } else {
            this.error = true;
          }
        }
      }
    }
  };
</script>

<style scoped>
  .main-page {
    /**/
  }

  .login-page {
    margin: 0 auto;
    margin-top: 35px;
    max-width: 500px;
  }
</style>
