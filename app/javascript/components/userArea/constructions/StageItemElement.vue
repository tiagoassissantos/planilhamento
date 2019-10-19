<template>

    <v-dialog width="900">
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


          <div v-for='element in elements' v-bind:key='element.id'> 
            <cd-element :item_element="element" :item="item" /> 
          </div>

        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-btn color="primary" text @click="addElement">
            + Elemento
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="closeElement">
            Finalizar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import cdElement from './Element'

  export default {
    components: { cdElement },

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
        editing: false,
        lastPosition: 0
      }
    },

    mounted () {
      this.getElements();
    },

    computed: {
      
    },

    methods: {
      async getElements() {
        let response = null

        await this.$http.get(`/stage_items/${this.item.id}/item_elements`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.elements = response.body

          console.log( '------------------------------------------' )
          console.log( this.elements.length)
          if (this.elements.length > 0) {
            this.lastPosition = this.elements[this.elements.length -1].position
            console.log( this.lastPosition)
          }
        }
      },

      addElement() {
        let newPosition = this.lastPosition + 1
        this.lastPosition = newPosition
        this.elements.push( {id: 0, position: newPosition} )
      },

      closeElement() {

      },

      editItem() {

      }
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>