<template>
  <div id="app">
    <v-container>
      <v-banner title='true' class='mt-5'>
        <span class='display-1'> Obra: </span> <span class='headline'> {{ construction.name }} </span>

        <template v-slot:actions>
          <v-btn class="" to="/constructions" color="primary"> Voltar </v-btn>
        </template>
      </v-banner>

      <v-card class="padding-card">
        <v-row>
          <v-col cols='3'> Vendedor </v-col>
          <v-col cols='3'> Contato </v-col>
          <v-col cols='3'> Telefone do Contato </v-col>
        </v-row>
        <v-row>
          <v-col cols='3'> {{ construction.customer.salesman }} </v-col>
          <v-col cols='3'> {{ construction.contact }} </v-col>
          <v-col cols='3'> {{ construction.contact_number }} </v-col>
        </v-row>

        <v-row>
          <v-col cols='12'> Cliente </v-col>
        </v-row>
        <v-row>
          <v-col cols='12'> {{ construction.customer.name }} </v-col>
        </v-row>

        <v-row>
          <v-col cols='3'> CPF ou CNPJ </v-col>
          <v-col cols='3'> Contato </v-col>
          <v-col cols='3'> Telefone Contato </v-col>
          <v-col cols='3'> E-mail </v-col>
        </v-row>
        <v-row>
          <v-col cols='3'> {{ construction.customer.cpf_cnpj }} </v-col>
          <v-col cols='3'> {{ construction.customer.contact }} </v-col>
          <v-col cols='3'> {{ construction.customer.phone }} </v-col>
          <v-col cols='3'> {{ construction.customer.email }} </v-col>
        </v-row>
      </v-card>
      
      
      <v-card class="padding-card">
        <!-- <v-btn color="primary" dark @click='addStage'>
          + Cadastrar etapa
        </v-btn> -->

        <v-dialog
          v-model="dialog"
          width="500"
        >
          <template v-slot:activator="{ on }">
            <h2 class="mb-5">
              Etapas
              <v-btn text icon large color="blue" dark v-on="on">
                <v-icon>mdi-plus</v-icon>
              </v-btn>
            </h2>
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

                <v-autocomplete v-model="stage_construction.pavement" label="Pavimento"
                  :items="floorItems" class="ma-1 pa-3" required>
                </v-autocomplete>
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

        <!-- <v-simple-table>
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
        </v-simple-table> -->

        <div v-for='stage in stage_constructions' v-bind:key='stage.id'>
          <construction-stage :stage='stage'></construction-stage>
        </div>

      </v-card>
      
    </v-container>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import constructionStage from './Stage'

  export default {
    components: {constructionStage},

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
          cpf_cnpj: null,
          customer: {}
        },
        customer_id: null,

        customers: [],
        edit: false,
        construction_id: null,
        header_text: null,
        button_text: null,

        dialog: false,

        stage_construction: {
          name: null,
          quantity: null,
          pavement: null
        },

        stages: [],

        stage_construction_id: [],
        stage_constructions: []
      }
    },

    mounted () {
      this.getCustomers()

      this.construction_id = this.$route.params.id

      this.getConstruction()
      this.getStageConstructionUpdate()
      this.edit = true
      this.header_text = 'Editar Obra'
      this.button_text = 'Editar'
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

      floorItems() {
        let itens = []
        for (var i = -5; i <= 50; i++) {
          itens.push( i )
        }
        return itens
      }

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

        await this.$http.post(
          `/constructions/${this.construction_id}/stage_constructions`, 
          { stage_construction: this.stage_construction} 
        
        ).then((result) => {
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

        await this.$http.get(`/constructions/${this.construction_id}/stage_constructions`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.stage_constructions = response.body
        }
      },




      addStage() {
        this.stages.push({
          id: 1,
          name: 'Etapa 1',
          quantity: 0,
          pavement: 1
        })
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