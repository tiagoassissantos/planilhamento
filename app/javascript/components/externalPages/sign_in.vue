<template>
  <v-app>
    <navbar/>

    <v-container>
      <v-row no-gutters>
        <v-col sm="12" md="3"></v-col>

        <v-col sm="12" md="6">
          <form>
            <v-card class="padding-card">

              <h2 class="margin-top">
                <center> Efetue Login </center>
              </h2>

              <v-alert type="error" v-if="error">
                Verifique e-mail ou senha.
              </v-alert>

              <v-text-field
                v-model="email"
                :error-messages="emailErrors"
                label="E-mail"
                required
                @input="$v.email.$touch()"
                @blur="$v.email.$touch()"
              ></v-text-field>

              <v-text-field
                v-model="password"
                :error-messages="passwordErrors"
                label="Senha"
                required
                type="password"
                @input="$v.password.$touch()"
                @blur="$v.password.$touch()"
              ></v-text-field>

              <v-btn class="mr-4 mt-5 full-width" @click="validateSubmit" color="primary" > Entrar </v-btn>
            </v-card>
          </form>
        </v-col>

        <v-col sm="12" md="3"></v-col>
      </v-row>
    </v-container>

  </v-app>
</template>

<script>
  import navbar from "./navbar.vue";
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'

  export default {
    mixins: [validationMixin],
    validations: {
      email: { required, email },
      password: { required },
    },

    components: { navbar },

    data: () => {
      return {
        email: '',
        password: '',
        error_text: '',
        error: false,
      };
    },

    computed: {
      emailErrors () {
        const errors = []
        if (!this.$v.email.$dirty) return errors
        !this.$v.email.email && errors.push('E-mail inválido')
        !this.$v.email.required && errors.push('E-mail é obrigatório')
        return errors
      },

      passwordErrors () {
        const errors = []
        if (!this.$v.password.$dirty) return errors
        !this.$v.password.required && errors.push('Senha é obrigatória')

        return errors
      },
    },

    mounted() {
    },

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

      async validateSubmit() {
        this.$v.$touch()
        if ( this.$v.$invalid ) {
          return
        } else {
          this.submit()
        }
      },

      async submit () {
        this.error = false;
        let response = null;
        let data = {user: { email: this.email, password: this.password }}

        await this.$http
          .post("/users/sign_in", JSON.stringify(data))
          .then(resp => { response = resp })
          .catch(resp => { response = resp });

        if ( response.status == 200 ) {
          this.getCurrentUser()

        } else if ( response.status == 401 ) {
          this.error = true;
        }
      },

      async getCurrentUser () {
        let response = null;

        await this.$http.get(`/get_user`)
        .then((result) => {
          response = result

        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.user = response.body
          location.href = "/user-area";
        }
      }

    }
  };
</script>

<style scoped>
  .login-page {
    margin: 0 auto;
    margin-top: 35px;
    max-width: 500px;
  }

  .margin-top {
    margin-top: 30px;
    margin-bottom: 50px;
    color: #363636;
  }

  .full-width {
    width: 100%;
  }

  .padding-card {
    padding: 20px;
    margin-top: 100px;
  }
</style>
