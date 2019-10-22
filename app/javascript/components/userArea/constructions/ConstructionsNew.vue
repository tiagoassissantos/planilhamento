<template>
  <div id="app">
    <v-container>
      <v-card>
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <h4> {{header_text}} </h4>
            </v-col>
            <v-col cols="2">
              <v-btn class="float-right" to="/constructions" color="primary"> Voltar </v-btn>
            </v-col>
          </v-row>
        </v-card-title>

        <v-card-text class="mt-3 mb-3 padding-card">
          <form>

            <v-select
              v-model="customer_id"
              :items="customers"
              item-text="name"
              item-value="id"
              label="Cliente"
              persistent-hint
              return-object
              single-line
              required
              @input="$v.construction.name.$touch()"
              @blur="$v.construction.name.$touch()"
              :error-messages="customerErrors"
            ></v-select>

            <v-row cols-12 justify="space-between">
              <v-text-field
                v-model="construction.name"
                :error-messages="nameErrors"
                label="Nome da Obra"
                required
                type="text"
                @input="$v.construction.name.$touch()"
                @blur="$v.construction.name.$touch()"
                class="ma-1 pa-3"
              ></v-text-field>

              <v-text-field
                v-model="construction.email"
                :error-messages="emailErrors"
                label="E-mail"
                required
                type="email"
                @input="$v.construction.email.$touch()"
                @blur="$v.construction.email.$touch()"
                class="ma-1 pa-3"
              ></v-text-field>

              <v-text-field
                v-model="construction.contact"
                :error-messages="contactErrors"
                label="Contato"
                type="text"
                required
                @input="$v.construction.contact.$touch()"
                @blur="$v.construction.contact.$touch()"
                class="ma-1 pa-3"
              ></v-text-field>
            </v-row>

            <v-row cols-12 justify="space-between">
              <v-text-field
                v-model="construction.contact_number"
                :error-messages="contactNumberErrors"
                label="Telefone para contato"
                required
                type="number"
                @input="$v.construction.contact_number.$touch()"
                @blur="$v.construction.contact_number.$touch()"
                class="ma-1 pa-3"
              ></v-text-field>

              <v-text-field
                v-model="construction.cpf_cnpj"
                :error-messages="cpfCnpjErrors"
                label="CPF / CNPJ"
                required
                @input="$v.construction.cpf_cnpj.$touch()"
                @blur="$v.construction.cpf_cnpj.$touch()"
                class="ma-1 pa-3"
              ></v-text-field>
            </v-row>

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
      construction: {
        email: { required, email },
        name: { required },
        contact: { required },
        contact_number: { required },
        cpf_cnpj: { required }
      },
      customer_id: { required },
    },

    data () {
      return {
        construction: {
          name: null,
          contact: null,
          contact_number: null,
          email: null,
          cpf_cnpj: null
        },
        customer_id: null,

        customers: [],
        edit: false,
        construction_id: null,
        header_text: null,
        button_text: null,

        dialog: false,

        construction_stage:{
          name: null,
          quantity: null,
          pavement: null
        },

        construction_stage_id: [],
        construction_stages: []
      }
    },

    mounted () {
      this.getCustomers()

      this.construction_id = this.$route.params.id
      if ( this.construction_id != null){
        this.getConstruction()
        this.getConstructionStageUpdate()
        this.edit = true
        this.header_text = 'Editar Obra'
        this.button_text = 'Editar'

      } else {
        this.header_text = 'Nova Obra'
        this.button_text = 'Cadastrar'
      }
    },

    computed: {
      emailErrors () {
        const errors = []
        if (!this.$v.construction.email.$dirty) return errors
        !this.$v.construction.email.email && errors.push('E-mail inválido')
        !this.$v.construction.email.required && errors.push('E-mail é obrigatório')
        return errors
      },

      nameErrors () {
        const errors = []
        if (!this.$v.construction.name.$dirty) return errors
        !this.$v.construction.name.required && errors.push('Nome é obrigatório')
        return errors
      },

      contactErrors () {
        const errors = []
        if (!this.$v.construction.contact.$dirty) return errors
        !this.$v.construction.contact.required && errors.push('Contato é obrigatório')
        return errors
      },

      contactNumberErrors () {
        const errors = []
        if (!this.$v.construction.contact_number.$dirty) return errors
        !this.$v.construction.contact_number.required && errors.push('Telefone para contato é obrigatório')
        return errors
      },

      cpfCnpjErrors () {
        const errors = []
        if (!this.$v.construction.cpf_cnpj.$dirty) return errors
        !this.$v.construction.cpf_cnpj.required && errors.push('Dado é obrigatório')
        return errors
      },

      customerErrors () {
        const errors = []
        if (!this.$v.customer_id.$dirty) return errors
        !this.$v.customer_id.required && errors.push('Cliente é obrigatório')
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

        if ( this.edit ) {
          await this.$http.put(`/constructions/${this.construction.id}`,
          { construction: this.construction, customer_id: this.customer_id, construction_stage_id: this.construction_stage_id })
            .then((result) => {
              response = result;
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post("/constructions", { construction: this.construction, customer_id: this.customer_id, construction_stage_id: this.construction_stage_id })
            .then(resp => {
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });
        }

        if ( response.status == 200 ) {
          this.$router.push('/constructions')
        }
      },

      async getCustomers() {
        let response = null

        await this.$http.get(`/customers`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.customers = response.body
        }
      },

      async getConstruction() {
        let response = null

        await this.$http.get(`/constructions/${this.construction_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.construction = response.body
        }
      },

      async submitConstructionStage() {
        let response = null

        await this.$http.post(`/construction_stages`, { construction_stage: this.construction_stage} )
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.dialog = false
          this.construction_stage.name = null,
          this.construction_stage.pavement = null,
          this.construction_stage_id.push( response.body )
          this.getConstructionStage()
        }
      },

      async getConstructionStage () {
        let response = null

        await this.$http.post(`/get_stage_by_construction`, {construction_stage_id: this.construction_stage_id })
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.construction_stages = response.body
        }
      },

      async deleteConstructionStage ( id ) {
        let response = null

        await this.$http.delete(`construction_stages/${id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          var index = this.construction_stage_id.indexOf(id)
          this.construction_stage_id.splice(index, 1)
          this.construction_stage = []
          this.getConstructionStage()
        }
      },

      async getConstructionStageUpdate () {
        let response = null

        await this.$http.get(`/construction_stages/${this.construction_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.construction_stages = response.body
        }
      }

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