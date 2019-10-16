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
                    <span>{{ stage.name }}</span>
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
                      <span>{{ stage.quantity }}</span>
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
                      <span>{{ stage.pavement }}</span>
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
                  <v-text-field dense label="Nome da Etapa" value='' v-model='stage.name'></v-text-field>
                </v-col>

                <v-col cols="3">
                  <v-text-field dense label="Pavimento" value='' v-model='stage.pavement'></v-text-field>
                </v-col>

                <v-col cols="6">
                  <v-textarea name="input-7-1" dense label="Folha" rows="3"></v-textarea>
                </v-col>
              </v-row>
            </v-col>

            <v-col cols="2" class="py-1">
              <v-row>
                <v-col cols="12">
                  <v-btn small> Salvar </v-btn>
                </v-col>
                <v-col cols="12">
                  <v-btn small> Excluir </v-btn>
                </v-col>
              </v-row>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="8" class="py-1">
              <h3>
                Items 
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
              <span class="subtitle-1">Quantidade</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Ações</span>
            </v-col>
          </v-row>

          <div v-for='item in itens' v-bind:key='item.id'> <stage-item/> </div>
          
        </v-expansion-panel-content>
      </v-expansion-panel>

    </v-expansion-panels>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import stageItem from './StageItem'

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
        name: '',
        itens: []
      }
    },

    mounted () {
      
    },

    computed: {
      
    },

    methods: {
      addItem() {
        this.itens.push({id: 0})
      }
    }
  }
</script>

<style scoped>

</style>