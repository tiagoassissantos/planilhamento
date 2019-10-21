<template>

    <v-dialog width="900" v-model='showDialog'>
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
            Fechar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import cdElement from './Element'
  import EventBus from '../../../packs/eventBus.js'

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

    //props: ['item'],
    props: {
      value: Object
    },

    data () {
      return {
        elements: [],
        editing: false,
        showDialog: false
      }
    },

    computed: {
      item: {
        get () {
          return this.value
        },
        set (value) {
          this.$emit('input', value)
        }
      }
    },

    mounted () {
      this.getElements();
      let that = this

      EventBus.$on('cancelItem', function (payload) {
        delete that.elements.pop()
      });

      EventBus.$on( `UpdateElements-${this.item.id}`, this.updateElements )
    },

    methods: {
      async getElements() {
        console.log( '------------------================------------------' )
        let response = null

        await this.$http.get(`/stage_items/${this.item.id}/item_elements`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.elements = response.body
        }
      },

      addElement() {
        this.elements.push( {id: 0} )
      },

      closeElement() {
        this.showDialog = false
      },

      editItem() {

      },

      updateElements() {
        this.getElements()
        EventBus.$emit( `ItemUpdate-${this.item.id}`, true)
      },
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>