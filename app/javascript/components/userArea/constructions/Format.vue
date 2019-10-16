<template>

    <v-dialog
      v-model="dialog"
      width="500"
    >
      <template v-slot:activator="{ on }">
        <v-btn text icon small color="indigo" v-on="on">
          <v-icon>mdi-settings</v-icon>
        </v-btn>
      </template>

      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          Formato 1
        </v-card-title>

        <v-card-text>
          <v-row class=''>
            <v-col cols="2" class="py-1">
              <v-row>
                <v-col cols="12">
                  <span class="subtitle-1">A</span>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field dense value='300 CM'></v-text-field>
                </v-col>
              </v-row>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="12" class="py-1">
              <v-img :src="require('../../../../assets/images/formatA.png')" width="200"></v-img>
            </v-col>
          </v-row>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="dialog">
            Salvar
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

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

    props: ['item'],

    data () {
      return {
        elements: [],
        editing: true
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