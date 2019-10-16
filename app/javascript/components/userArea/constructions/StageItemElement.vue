<template>

    <v-dialog
      v-model="dialog"
      width="900"
    >
      <template v-slot:activator="{ on }">
        <v-btn text icon small color="indigo" v-on="on">
          <v-icon>mdi-settings</v-icon>
        </v-btn>
      </template>

      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          {{ item.name }}
        </v-card-title>

        <v-card-text>
          <v-row class=''>
            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Posição</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Bitola</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Qtde.</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Formato</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Peso</span>
            </v-col>

            <v-col cols="2" class="py-1">
              <span class="subtitle-1">Ações</span>
            </v-col>
          </v-row>

          <v-row v-for='element in elements' v-bind:key="element" class='mb-1 blue-grey lighten-4'>
            <v-col cols="2" class="py-1">
              <v-text-field dense :readonly='!editing' :class='{editable: editing}' 
                value='Posição' v-model='item.name'></v-text-field>
            </v-col>

            <v-col cols="2" class="py-1">
              <v-text-field dense :readonly='!editing' :class='{editable: editing}' 
                value='Bitola' v-model='item.name'></v-text-field>
            </v-col>

            <v-col cols="2" class="py-1">
              <v-text-field dense :readonly='!editing' :class='{editable: editing}' 
                value='Qtde' v-model='item.name'></v-text-field>
            </v-col>

            <v-col cols="2" class="py-1">
              <v-text-field dense :readonly='!editing' :class='{editable: editing}' 
                value='Formato' v-model='item.name'></v-text-field>
            </v-col>

            <v-col cols="2" class="py-1">
              <v-text-field dense readonly value='1.200,00 KG'></v-text-field>
            </v-col>


            <v-col cols="2" class="py-1">
              <v-btn text icon small color="blue" v-if='!editing' @click="editItem">
                <v-icon>mdi-pencil-outline</v-icon>
              </v-btn>

              <!-- <v-btn text icon small color="indigo" v-if='!editing'>
                <v-icon>mdi-settings</v-icon>
              </v-btn> -->

              <format :item='item' v-if='!editing'/>

              <v-btn text icon small color="red" v-if='!editing'>
                <v-icon>mdi-delete-forever</v-icon>
              </v-btn>

              <v-btn text icon small color="green" v-if='editing' @click="saveItem">
                <v-icon>mdi-check-outline</v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-btn color="primary" text @click="addElement">
            Add Elemento
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="dialog">
            OK
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import format from './Format'

  export default {
    components: { format },

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

    props: ['item'],

    data () {
      return {
        elements: [],
        editing: false
      }
    },

    mounted () {
      
    },

    computed: {
      
    },

    methods: {
      addElement() {
        this.elements.push( {position: 1} )
      }
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>