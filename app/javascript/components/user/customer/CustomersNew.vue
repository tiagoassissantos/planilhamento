<template>
  <div id="app">
    <v-container>
      <h1 class="margin-top mb-5 text-md-center"> {{header_text}} </h1>

      <form>
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
      name: { required }
    },

    data () {
      return {
        email: null,
        name: null,
        edit: false,
        customer_id: null,
        header_text: null,
        button_text: null
      }
    },

    mounted () {
      this.customer_id = this.$route.params.id
      if ( this.customer_id != null){
        this.edit = true
        this.getCustomer()
        this.header_text = 'Editar Cliente'
        this.button_text = 'Editar'

      } else{
        this.header_text = 'Novo Cliente'
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
          name: this.name
        }

        if ( this.edit ) {
          await this.$http.put(`/customers/${this.customer_id}`, {customer: data})
            .then((result) => {
              response = result;
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post("/customers", { customer: data })
            .then(resp => {
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });
        }

        if ( response.status == 200 ) {
          this.$router.push('/customers')
        }
      },

      async getCustomer () {
        let response = null;
        await this.$http.get(`/customers/${this.customer_id}`)
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