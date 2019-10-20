<template>

    <v-dialog v-model='show' max-width="700">
      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          {{ format.name }}
        </v-card-title>

        <v-card-text>
          <v-row>
            <v-col cols="2" class="py-1" v-for="side in format.sides" v-bind:key="side"> 
              <v-row>
                <v-col cols="12">
                  <span class="subtitle-1"> {{ fieldLetter( side )  }} </span>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field dense v-model="formatData[ fieldLetter( side ) ]"></v-text-field>
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
          <v-btn color="primary" text @click="saveFormat">
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

    props: {
      value: Object
    },

    data () {
      return {
        elements: [],
        editing: true,
        dialog: false,
        formatData: {}
      }
    },

    mounted () {

    },

    computed: {
      show: {
        get () {
          return this.value.show
        },
        set (value) {
          let newValue = this.value
          newValue.show = value
          this.$emit('input', newValue)
        }
      },

      format: {
        get() {
          return this.value.format
        },
        set( format ) {
          let newValue = this.value
          newValue.format = format
          this.$emit('input', newValue)
        },
      }

    },

    methods: {
      saveFormat() {
        let newValue = this.value
        newValue.formatValues = this.formatData
        this.$emit('input', newValue)
        this.show = false
      },

      fieldLetter( number ) {
        return String.fromCharCode(64 + number)
      }
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>