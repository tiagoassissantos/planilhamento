<template>
  <div id="app">
    <v-container>
      <h1 class="margin-top mb-5 text-md-center"> {{header_text}} </h1>

      <form>
        <v-alert v-if="error" type="error">
          {{alertMessage}}
        </v-alert>

        <v-card class="padding-card">
          <v-text-field
            v-model="name"
            :error-messages="nameErrors"
            label="Nome"
            required
            type="text"
            @input="$v.name.$touch()"
            @blur="$v.name.$touch()"
          ></v-text-field>

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

          <v-text-field
            v-model="password_confirmation"
            :error-messages="passwordConfirmationErrors"
            label="Confirmar Senha"
            required
            type="password"
            @input="$v.password_confirmation.$touch()"
            @blur="$v.password_confirmation.$touch()"
          ></v-text-field>

          <v-text-field
            v-model="cpf"
            :error-messages="cpfErrors"
            label="CPF"
            required
            type="number"
            @input="$v.cpf.$touch()"
            @blur="$v.cpf.$touch()"
          ></v-text-field>

          <v-btn class="mr-4 mt-5 full-width" @click="validateSubmit" color="primary" > {{button_text}} </v-btn>
        </v-card>
      </form>

    </v-container>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'

  export default {
    mixins: [validationMixin],
    validations: {
      email: { required, email },
      password: { required },
      cpf: { required },
      password_confirmation: { required },
      name: { required }
    },

    data () {
      return {
        email: null,
        password: null,
        cpf: null,
        password_confirmation: null,
        name: null,
        edit: false,
        user_id: null,
        header_text: null,
        button_text: null,
        alertMessage: null,
        error: false

      }
    },

    mounted () {
      this.user_id = this.$route.params.id
      if ( this.user_id != null ) {
        this.edit = true
        this.getUser()
        this.header_text = 'Editar Usuário'
        this.button_text = 'Editar'

      } else{
        this.header_text = 'Novo Usuário'
        this.button_text = 'Cadastrar'
      }
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

      cpfErrors () {
        const errors = []
        if (!this.$v.cpf.$dirty) return errors
        !this.$v.cpf.required && errors.push('CPF é Obrigatório')
        return errors
      },

      passwordConfirmationErrors () {
        const errors = []
        if (!this.$v.password_confirmation.$dirty) return errors
        !this.$v.password_confirmation.required && errors.push('Senha é obrigatória')
        return errors
      },

      nameErrors () {
        const errors = []
        if (!this.$v.name.$dirty) return errors
        !this.$v.name.required && errors.push('Nome é obrigatório')
        return errors
      }
    },

    methods: {
      async validateSubmit() {
        this.$v.$touch()
        if ( this.$v.$invalid ) {
          return
        } else {
          this.submit()
        }
      },

      async submit () {
        let response = null
        let data = {
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation,
          cpf: this.cpf,
          name: this.name
        }

        if ( this.edit ) {
          await this.$http.put(`/users/${this.user_id}`, {user: data})
            .then((result) => {
              response = result;
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post("/users", { user: data })
            .then(resp => {
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });
        }

        if ( response.status == 200 ) {
          this.$router.push('/users')
        } else {
          this.alertMessage = response.body.message
          this.error = true
        }
      },

      async getUser () {
        let response = null;
        await this.$http.get(`/users/${this.user_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.email = response.body.email
          this.name = response.body.name
          this.cpf = response.body.cpf
        }
      },

    }
  }
</script>

<style scoped>

  .margin-top{
    margin-top: 50px;
  }


  .full-width {
    width: 100%;
  }

  .padding-card {
    padding: 20px;
  }

</style>