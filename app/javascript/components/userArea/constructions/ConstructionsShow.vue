<template>
  <div id="app">
    <v-container>
      <v-card class="">
         <v-card-title class='grey py-1'>

          <v-row>
            <v-col cols="10">
              <span class='display-1'> Obra: </span> <span class='headline'> {{ construction.name }} </span>
            </v-col>
            <v-col cols="2">
              <v-btn class="float-right" to="/constructions" color="primary"> Voltar </v-btn>
            </v-col>
          </v-row>

         </v-card-title>

         <v-card-text class="mt-1 padding-card">
           <v-row justify="space-between">
            <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card"> Vendedor </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.customer.salesman }}
                </v-card-text>
              </v-card>
            </v-col>

            <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card"> Contato </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.customer.contact }}
                </v-card-text>
              </v-card>
            </v-col>

            <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card"> Telefone Do Contato </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.contact_number }}
                </v-card-text>
              </v-card>
            </v-col>

           </v-row>

           <v-row>
             <v-col cols="12" class='pt-2 pb-2'>
               <v-card class="grey py-1 pl-2">
                <span class="title-card">
                  <strong> Cliente: </strong>
                  {{ construction.customer.name }}
                </span>
               </v-card>

             </v-col>
           </v-row>

          <v-row>

           <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card">  CPF ou CNPJ </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.customer.cpf_cnpj }}
                </v-card-text>
              </v-card>
            </v-col>

            <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card"> Contato </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.customer.contact }}
                </v-card-text>
              </v-card>
            </v-col>

            <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card"> Telefone Contato </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.customer.phone }}
                </v-card-text>
              </v-card>
            </v-col>

            <v-col cols="3">
              <v-card>
                <v-card-title>
                  <span class="title-card"> E-mail </span>
                </v-card-title>
                <v-card-text>
                 {{ construction.customer.email }}
                </v-card-text>
              </v-card>
            </v-col>

           </v-row>
        </v-card-text>
      </v-card>

      <v-card class="padding-card">
        <v-dialog v-model="dialog" width="500">
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
                  v-model="stage.name"
                  label="Nome da Etapa"
                  required
                  type="text"
                  class="ma-1 pa-3"
                  :error-messages="nameStageErrors"
                  @input="$v.stage.name.$touch()"
                  @blur="$v.stage.name.$touch()"
                ></v-text-field>

                <v-autocomplete
                  v-model="stage.pavement"
                  label="Pavimento"
                  :items="floorItems"
                  class="ma-1 pa-3"
                  required
                  :error-messages="pavementErrors"
                  @input="$v.stage.pavement.$touch()"
                  @blur="$v.stage.pavement.$touch()"
                >
                </v-autocomplete>
              </form>
            </v-card-text>

            <v-divider></v-divider>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="validationConstructionStage()">
                Cadastrar
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <div v-for='stage in stages' v-bind:key='stage.id'>
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
  import EventBus from '../../../packs/eventBus.js'

  export default {
    components: {constructionStage},

    mixins: [validationMixin],
    validations: {
      stage: {
        name: { required },
        pavement: { required }
      }
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

        edit: false,
        construction_id: null,
        header_text: null,
        button_text: null,

        dialog: false,

        stage: {
          name: null,
          pavement: null
        },

        stages: [],
      }
    },

    mounted () {
      this.construction_id = this.$route.params.id

      this.getConstruction()
      this.getConstructionStageUpdate()
      this.edit = true
      this.header_text = 'Editar Obra'
      this.button_text = 'Editar'

      EventBus.$on( `DeleteStage`, this.getConstructionStageUpdate )
    },

    computed: {
      nameStageErrors () {
        const errors = []
        if (!this.$v.stage.name.$dirty) return errors
        !this.$v.stage.name.required && errors.push('Nome da etapa é obrigatório')
        return errors
      },

      pavementErrors () {
        const errors = []
        if (!this.$v.stage.pavement.$dirty) return errors
        !this.$v.stage.pavement.required && errors.push('Pavimento é obrigatório')
        return errors
      },

      floorItems() {
        let items = []
        for (var i = -5; i <= 50; i++) {
          items.push( i )
        }
        return items
      }

    },

    methods: {
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
          console.log("+++++++++++++++=")
          console.log( this.construction )
          console.log("+++++++++++++++=")
        }
      },

      validationConstructionStage () {
        this.$v.$touch()
        if ( this.$v.$invalid ) {
          return
        } else {
          this.submitConstructionStage()
        }
      },

      async submitConstructionStage() {
        let response = null

        await this.$http.post(
          `/constructions/${this.construction_id}/construction_stages`,
          { construction_stage: this.stage}

        ).then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.dialog = false
          console.log("++++++++++++++++++++++++++++++++++++++++++++++=")
          this.stage.name = null,
          this.stage.pavement = null,

          this.addStage( response.body )
        }
      },

      /*async deleteConstructionStage ( id ) {
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
      },*/

      async getConstructionStageUpdate () {
        let response = null

        await this.$http.get(`/constructions/${this.construction_id}/construction_stages`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.stages = response.body
        }
      },

      addStage( stage ) {
        this.stages.push( stage )
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

  .title-card {
    font-size: 18px;
  }

</style>