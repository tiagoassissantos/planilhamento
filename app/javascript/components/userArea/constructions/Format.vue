
<template>

    <v-dialog v-model='show' max-width="700">
      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          {{ format.name }}
        </v-card-title>

        <v-card-text>
          <v-row>
            <v-col cols="2" class="py-1" v-for="(side,index) in format.sides" v-bind:key="index">
              <v-row>
                <v-col cols="12">
                  <span class="subtitle-1"> {{ fieldName[index] }} </span>
                </v-col>
              </v-row>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="2">
              <v-text-field dense v-model="dataValue.l1.size"></v-text-field>
            </v-col>

            <v-col cols="2" v-if="showFormat2">
              <v-text-field dense v-model="dataValue.l2.size"></v-text-field>
            </v-col>

            <v-col cols="2" v-if="showFormat3">
              <v-text-field dense v-model="dataValue.l3.size"></v-text-field>
            </v-col>

            <v-col cols="2" v-if="showFormat4">
              <v-text-field dense v-model="dataValue.l4.size"></v-text-field>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="12" class="py-1">
              <v-img :src="require(`../../../../assets/images/${format.image_name}.png`)" class="width-image"></v-img>
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
import { async } from 'q'

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
        formatData: {},
        fieldName: ['L1', 'L2', 'L3', 'L4'],
        format_image: null,
        dataValue: {
          l1: { size: null, qnt: null },
          l2: { size: null, qnt: null },
          l3: { size: null, qnt: null },
          l4: { size: null, qnt: null }
        },
        formatL1: null,
        formatL2: null,
        formatL3: null,
        formatL4: null
      }
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
      },


      showFormat2() {
        if ( this.format.sides == 1) {
          return false
        } else {
          return true
        }
      },

      showFormat3() {
        if ( this.format.sides == 1 || this.format.sides == 2) {
          return false
        } else {
          return true
        }
      },

      showFormat4() {
        if ( this.format.sides == 1 || this.format.sides == 2 || this.format.sides == 3 ) {
          return false
        } else {
          return true
        }
      }

    },


    mounted () {
      if (this.format.image_name == 'Format-1') {
        this.dataValue = {
          l1: { size: null, qnt: 1 }
        }

      } else if (this.format.image_name == 'Format-3') {
        this.dataValue = {
          l1: { size: null, qnt: 1 },
          l2: { size: null, qnt: 1 }
        }

      } else if (this.format.image_name == 'Format-4') {
        this.dataValue = {
          l1: { size: null, qnt: 1 },
          l2: { size: null, qnt: 1 },
          l3: { size: null, qnt: 1 }
        }

      } else if (this.format.image_name == 'Format-8') {
        this.dataValue = {
          l1: { size: null, qnt: 2 },
          l2: { size: null, qnt: 2 },
          l3: { size: null, qnt: 1 }
        }

      } else if (this.format.image_name == 'Format-58') {
        this.dataValue = {
          l1: { size: null, qnt: 1 },
          l2: { size: null, qnt: 1 }
        }

      } else if (this.format.image_name == 'Format-122') {
        this.dataValue = {
          l1: { size: null, qnt: 1 }
        }

      } else if (this.format.image_name == 'Format-245') {
        this.dataValue = {
          l1: { size: null, qnt: 1 },
          l2: { size: null, qnt: 1 },
          l3: { size: null, qnt: 1 },
          l4: { size: null, qnt: 1 }
        }
      }
    },


    methods: {
      saveFormat() {
        let newValue = this.value

        newValue.formatValues = this.dataValue
        this.$emit('input', newValue)
        this.show = false
      },

      fieldLetter( number ) {
        let n = parseInt(number)
        return
      },

    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }

  .width-image {
    width: 400px;
    height: 200px;
    margin-left: 20%;
  }
</style>
