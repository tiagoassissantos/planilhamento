<template>
  <div id="app">
    <v-container>
      <v-card class="mx-auto">
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1"> {{header_text}} </span>
            </v-col>
            <v-col cols="2">
              <v-btn to="/customers" color="primary" large> Voltar </v-btn>
            </v-col>
          </v-row>
        </v-card-title>

        <v-card-text class="mb-3 mt-3">
          <form>

            <v-alert v-if="error" type="error">
              {{alertMessage}}
            </v-alert>

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
              v-model="salesman"
              :error-messages="salesmanErrors"
              label="Vendedor"
              required
              @input="$v.salesman.$touch()"
              @blur="$v.salesman.$touch()"
            ></v-text-field>

            <v-text-field
              v-model="customerPhone"
              :error-messages="customerPhoneErrors"
              label="Telefone do Cliente"
              required
              @input="$v.customerPhone.$touch()"
              @blur="$v.customerPhone.$touch()"
            ></v-text-field>

            <v-text-field
              v-model="cpfCnpj"
              :error-messages="cpfCnpjErrors"
              label="CPF / CNPJ"
              required
              @input="$v.cpfCnpj.$touch()"
              @blur="$v.cpfCnpj.$touch()"
            ></v-text-field>

            <v-text-field
              v-model="contact"
              :error-messages="contactErrors"
              label="Contato"
              required
              @input="$v.contact.$touch()"
              @blur="$v.contact.$touch()"
            ></v-text-field>

            <v-btn class="mr-4 mt-5 full-width" @click="validateSubmit" color="primary" > {{button_text}} </v-btn>
          </form>
        </v-card-text>
      </v-card>
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
      name: { required },
      salesman: { required },
      customerPhone: { required },
      cpfCnpj: { required },
      contact: { required }
    },

    data () {
      return {
        email: null,
        name: null,
        salesman: null,
        customerPhone: null,
        cpfCnpj: null,
        contact: null,

        edit: false,
        customer_id: null,
        header_text: null,
        button_text: null,
        error: false,
        alertMessage: null
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
      },

      salesmanErrors () {
        const errors = []
        if (!this.$v.salesman.$dirty) return errors
        !this.$v.salesman.required && errors.push('Vendedor é obrigatório')
        return errors
      },

      customerPhoneErrors () {
        const errors = []
        if (!this.$v.customerPhone.$dirty) return errors
        !this.$v.customerPhone.required && errors.push('Número do cliente é obrigatório')
        return errors
      },

      cpfCnpjErrors () {
        const errors = []
        if (!this.$v.cpfCnpj.$dirty) return errors
        !this.$v.cpfCnpj.required && errors.push('Dado é obrigatório')
        return errors
      },

      contactErrors () {
        const errors = []
        if (!this.$v.contact.$dirty) return errors
        !this.$v.contact.required && errors.push('Contato é obrigatório')
        return errors
      },
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
          name: this.name,
          salesman: this.salesman,
          phone: this.customerPhone,
          cpf_cnpj: this.cpfCnpj,
          contact: this.contact
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
        } else {
          this.error = true
          this.alertMessage = response.body.message
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
          this.salesman = response.body.salesman
          this.cpfCnpj = response.body.cpf_cnpj
          this.customerPhone = response.body.phone
          this.contact = response.body.contact
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