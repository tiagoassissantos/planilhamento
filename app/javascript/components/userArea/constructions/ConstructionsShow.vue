<template>
  <div id="app">
    <v-container>
       <v-banner title='true' class='mt-5'>
          <h2> {{header_text}} </h2>

          <template v-slot:actions>
            <v-btn class="" to="/constructions" color="primary"> Voltar </v-btn>
          </template>
        </v-banner>
      
      <form>
        <v-card class="padding-card">

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

          <v-dialog
            v-model="dialog"
            width="500"
          >
            <template v-slot:activator="{ on }">
              <v-btn
                color="primary"
                dark
                v-on="on"
              >
                + Cadastrar etapa
              </v-btn>
            </template>

            <v-card>
              <v-card-title
                class="headline grey lighten-2"
                primary-title
              >
                Cadastro de etapa
              </v-card-title>

              <v-card-text>
                <form>
                  <v-text-field
                    v-model="stage_construction.name"
                    label="Nome da Etapa"
                    required
                    type="text"
                    class="ma-1 pa-3"
                  ></v-text-field>

                  <v-text-field
                    v-model="stage_construction.quantity"
                    :error-messages="nameErrors"
                    label="Quantidade"
                    required
                    type="number"
                    class="ma-1 pa-3"
                    readonly
                  ></v-text-field>

                  <v-text-field
                    v-model="stage_construction.pavement"
                    :error-messages="nameErrors"
                    label="Pavimento"
                    required
                    type="number"
                    class="ma-1 pa-3"
                  ></v-text-field>
                </form>
              </v-card-text>

              <v-divider></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="primary"
                  text
                  @click="submitStageConstruction()"
                >
                  Cadastrar
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Name</th>
                  <th class="text-left">Quantidade</th>
                  <th class="text-left">Pavimento</th>
                  <th class="text-left">Ações</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="sc in stage_constructions" :key="sc.id">
                  <td> {{ sc.name }} </td>
                  <td> {{ sc.quantity }} </td>
                  <td> {{ sc.pavement }} </td>
                  <td>
                    <v-btn color="success"> Editar </v-btn>
                    <v-btn color="error" @click="deleteStageConstruction(sc.id)"> Excluir </v-btn>
                  </td>
                </tr>
              </tbody>
              <tbody>

              </tbody>
            </template>
          </v-simple-table>

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

        stage_construction:{
          name: null,
          quantity: null,
          pavement: null
        },

        stage_construction_id: [],
        stage_constructions: []
      }
    },

    mounted () {
      this.getCustomers()

      this.construction_id = this.$route.params.id
      if ( this.construction_id != null){
        this.getConstruction()
        this.getStageConstructionUpdate()
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
          console.log("----------------------")
          console.log("----------------------")
          return
        } else {
          this.submit()
        }
      },

      async submit () {
        console.log("+++++++++++++++++")
        console.log("+++++++++++++++++")
        console.log("+++++++++++++++++")
        console.log("+++++++++++++++++")

        let response = null

        if ( this.edit ) {
          await this.$http.put(`/constructions/${this.construction.id}`,
          { construction: this.construction, customer_id: this.customer_id, stage_construction_id: this.stage_construction_id })
            .then((result) => {
              response = result;
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post("/constructions", { construction: this.construction, customer_id: this.customer_id, stage_construction_id: this.stage_construction_id })
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

      async submitStageConstruction() {
        let response = null

        await this.$http.post(`/stage_constructions`, { stage_construction: this.stage_construction} )
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.dialog = false
          this.stage_construction.name = null,
          this.stage_construction.pavement = null,
          this.stage_construction_id.push( response.body )
          this.getStageConstruction()
        }
      },

      async getStageConstruction () {
        let response = null

        await this.$http.post(`/get_stage_by_construction`, {stage_construction_id: this.stage_construction_id })
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.stage_constructions = response.body
        }
      },

      async deleteStageConstruction ( id ) {
        let response = null

        await this.$http.delete(`stage_constructions/${id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          var index = this.stage_construction_id.indexOf(id)
          this.stage_construction_id.splice(index, 1)
          this.stage_construction = []
          this.getStageConstruction()
        }
      },

      async getStageConstructionUpdate () {
        let response = null

        await this.$http.get(`/stage_constructions/${this.construction_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.stage_constructions = response.body
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