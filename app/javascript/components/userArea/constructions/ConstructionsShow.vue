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

         <v-card-text class="mt-1 padding-card blue-grey lighten-5">
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
                  <span class="title-card"> CPF ou CNPJ </span>
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

      <v-card class="padding-card blue-grey lighten-5">
        <v-dialog v-model="dialog" width="500">
          <template v-slot:activator="{ on }">
            <v-row>
              <v-col cols="6">
                <h2 class="mb-5">
                  Etapas
                  <v-btn text icon large color="blue" dark v-on="on">
                    <v-icon>mdi-plus</v-icon>
                  </v-btn>
                </h2>
              </v-col>

              <v-col cols="6">
                <h4 class="float-right"> Peso total da Obra: {{totalConstructionWeight}} Kg </h4>
              </v-col>
            </v-row>
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

        <v-alert v-if="successAlert" type="success">
          Etapa editada com sucesso.
        </v-alert>

        <v-alert v-if="errorAlert" type="error">
          Erro ao editar etapa, verifique os campos.
        </v-alert>

        <div v-for='stage in stages' v-bind:key='stage.id'>
          <construction-stage :stage='stage'></construction-stage>
        </div>

      </v-card>

       <v-card class="padding-card blue-grey lighten-5">
        <v-row >
          <v-col cols="6">
            <h2 class="mb-5">
              Relatórios
            </h2>
          </v-col>
        </v-row>

        <v-card>
          <v-row class="padding-card" justify="space-between">
            <v-col cols="3">
              <v-btn :href="`/reports/tags/${construction_id}`" color="success">
                Gerar Etiquetas
              </v-btn>
            </v-col>

            <v-col cols="3">
              <v-btn :href="`/reports/elements/${construction_id}`" color="info">
                Relatório de Elemento
              </v-btn>
            </v-col>

            <v-col cols="3">
              <v-btn :href="`/reports/tags/${construction_id}`" color="warning">
                Relatório de Etapa
              </v-btn>
            </v-col>

            <v-col cols="3">
              <v-btn :href="`/reports/tags/${construction_id}`" color="error">
                Relatório de Sequência
              </v-btn>
            </v-col>
          </v-row>
        </v-card>

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
          pavement: null,
          sheet: null
        },

        stages: [],
        successAlert: false,
        errorAlert: false
      }
    },

    mounted () {
      this.construction_id = this.$route.params.id

      this.getConstruction()
      this.getConstructionStageUpdate()
      this.edit = true
      this.header_text = 'Editar Obra'
      this.button_text = 'Editar'

      EventBus.$on( `DeleteStage`, this.getConstructionStageDelete )
      EventBus.$on( `UpdateStage`, this.getConstructionStageUpdateEvent )
      EventBus.$on( `ErrorUpdateStage`, this.errorUpdateConstructionStage )

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
      },

      totalConstructionWeight() {
        let totalWeight = 0

        for ( let i = 0; i < this.stages.length; i++ ) {
          if ( !this.stages[i].quantity ) continue
          totalWeight += parseFloat( this.stages[i].quantity )
        }

        return totalWeight.toFixed(2)
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
          this.stage.name = null,
          this.stage.pavement = null,

          this.addStage( response.body )
        }
      },

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

      async getConstructionStageUpdateEvent () {
        let response = null

        await this.$http.get(`/constructions/${this.construction_id}/construction_stages`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.stages = response.body
          this.successAlert = true
          setTimeout(() => {
            this.successAlert = false
          }, 3000);
        }
      },

      errorUpdateConstructionStage () {
        this.errorAlert = true
        setTimeout(() => {
          this.errorAlert = false
        }, 3000);
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