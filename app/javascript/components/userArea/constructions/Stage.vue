<template>
  <div id="app">
    <v-expansion-panels class='mb-3' focusable inset>
      <v-expansion-panel>

        <v-expansion-panel-header class='py-2'>
          <template v-slot:default="{ open }">
            <v-row no-gutters>
              <v-col cols="3">
                <v-row>
                  <v-col cols='12' class='py-0'>
                    <span class='caption grey--text'>Nome da Etapa</span>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols='12' class='py-1'>
                    <span>{{ localStage.name }}</span>
                  </v-col>
                </v-row>
              </v-col>

              <v-col cols="3">
                <v-row>
                  <v-col cols='12' class='py-0'>
                    <v-fade-transition leave-absolute>
                      <span class='caption grey--text'>Quantidade</span>
                    </v-fade-transition>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols='12' class='py-1'>
                    <v-fade-transition leave-absolute>
                      <span>{{ localStage.quantity }}</span>
                    </v-fade-transition>
                  </v-col>
                </v-row>
              </v-col>

              <v-col cols="3">
                <v-row>
                  <v-col cols='12' class='py-0'>
                    <v-fade-transition leave-absolute>
                      <span class='caption grey--text'>Pavimento</span>
                    </v-fade-transition>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols='12' class='py-1'>
                    <v-fade-transition leave-absolute>
                      <span>{{ localStage.pavement }}</span>
                    </v-fade-transition>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </template>
        </v-expansion-panel-header>

        <v-expansion-panel-content>
          <v-row>
            <v-col cols="10" class="py-1">
              <v-row>
                <v-col cols="3">
                  <v-text-field dense label="Nome da Etapa" value='' v-model='localStage.name'></v-text-field>
                </v-col>

                <v-col cols="3">
                  <v-text-field dense label="Pavimento" value='' v-model='localStage.pavement'></v-text-field>
                </v-col>

                <v-col cols="6">
                  <v-textarea name="input-7-1" v-model="localStage.sheet" dense label="Folha" rows="3"></v-textarea>
                </v-col>
              </v-row>
            </v-col>

            <v-col cols="2" class="py-1">
              <v-row>
                <v-col cols="12">
                  <v-btn small color="primary" @click="editStage"> Salvar</v-btn>
                </v-col>
                <v-col cols="12">
                  <v-btn small color="error" @click="dialog = true"> Excluir </v-btn>
                </v-col>
              </v-row>
            </v-col>
          </v-row>

          <v-dialog v-model="dialog" width="350">
            <v-card>
              <v-card-title primary-title>
                Deseja excluir a etapa?
              </v-card-title>

              <v-divider></v-divider>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="error" @click="deleteStage" class="full-width">
                  Excluir
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-row>
            <v-col cols="8" class="py-1">
              <h3>
                Itens
                <v-btn text icon color="blue" @click='addItem'>
                  <v-icon>mdi-plus</v-icon>
                </v-btn>
              </h3>
            </v-col>
          </v-row>

          <v-row class='mb-3'>
            <v-col cols="3" class="py-1">
              <span class="subtitle-1">Nome do Item</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Quantidade</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Abreviação</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Peso</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Ações</span>
            </v-col>
          </v-row>

          <div v-for='item in items' v-bind:key='item.id'>
            <stage-item :stage_item="item" :stage="localStage"/>
          </div>

          <v-alert dense v-if="error" type="error" >
            {{ errorStageItemText }}
          </v-alert>

        </v-expansion-panel-content>
      </v-expansion-panel>

    </v-expansion-panels>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import stageItem from './StageItem'
  import EventBus from '../../../packs/eventBus.js'

  export default {
    components: { stageItem },

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

    props: ['stage'],

    data () {
      return {
        localStage: {},
        name: '',
        items: [],
        errorStageItemText: null,
        error: false,
        dialog: false
      }
    },

    computed: {

    },

    mounted () {
      this.localStage = this.stage;
      this.getItems();
      EventBus.$on( `UpdateItems-${this.localStage.id}`, this.updateStage )

      EventBus.$on( `DeleteItem-${this.localStage.id}`, this.getItems )
      EventBus.$on( `ErrorName-${this.localStage.id}`, this.errorName )
      EventBus.$on( `ErrorAbbreviation-${this.localStage.id}`, this.errorAbbreviation )
      EventBus.$on( `SuccesSubmit-${this.stage.id}`, this.succesSubmit )

    },

    methods: {
      async getItems() {
        let response = null

        await this.$http.get(`/construction_stages/${this.localStage.id}/stage_items`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.items = response.body
        }
      },

      addItem() {
        this.items.push( {id: 0, name: '', abbreviation: '', quantity: 0} )
      },

      async updateStage() {
        let response = null

        await this.$http.get(`/construction_stages/${this.localStage.id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.localStage = response.body
          this.getItems()
        }
      },

      async deleteStage() {
        let response = null

        await this.$http.delete(`/construction_stages/${this.localStage.id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.dialog = false
          EventBus.$emit( `DeleteStage`, true )
        }
      },

      errorName( error ) {
        this.error = true
        this.errorStageItemText = "Nome do item da etapa não pode ser nulo"
      },

      errorAbbreviation( error ) {
        this.error = true
        this.errorStageItemText = "Abreviação do item da etapa não pode ser nulo"
      },

      succesSubmit ( error ) {
        this.error = false
      },

      async editStage () {
        let response = null

        let hasEmptyValue = this.emptyValue()

        if ( hasEmptyValue ) {
          EventBus.$emit( `ErrorUpdateStage`, true )
          return
        }

        await this.$http.patch(`/construction_stages/${this.localStage.id}`, { construction_stage: this.localStage })
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          EventBus.$emit( `UpdateStage`, true )
        } else {
          EventBus.$emit( `ErrorUpdateStage`, true )
        }
      },

      emptyValue () {
        let empty = false

        if ( this.localStage.name == '' ) {
          empty = true
        } else if ( this.localStage.pavement == '') {
          empty = true
        }
        return empty
      }

    }
  }
</script>

<style scoped>
  .full-width {
    width: 100%;
  }
</style>
