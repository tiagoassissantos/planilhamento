<template>
  <div>

    <v-row class='mb-1 blue-grey lighten-4'>
      <v-col cols="2" class="py-1">
        <v-text-field dense :readonly='!editing' v-model='element.position' :class='{editable: editing}'>
        </v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-select dense v-model="element.gauge" :items="gauges" :readonly='!editing'
                  :class='{editable: editing}' persistent-hint single-line required>
        </v-select>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{ editable: editing }'
                      value='Qtde' v-model='element.quantity' type="number">
        </v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-select dense v-model="element.format" :items="formats" :readonly='!editing'
                  item-text="name" item-value="id" persistent-hint return-object single-line
                  required :class='{editable: editing}' @change="openFormat()">
        </v-select>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense disabled v-model='element.weight'></v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-tooltip top v-if='editing'>
          <template v-slot:activator="{ on }">
            <v-btn text icon small color="green" @click="saveItem" v-on="on">
              <v-icon>mdi-check-outline</v-icon>
            </v-btn>
          </template>
          <span>Salvar</span>
        </v-tooltip>

        <v-tooltip top v-if='editing && element.id == 0'>
          <template v-slot:activator="{ on }">
            <v-btn text icon small color="red" @click="cancelItem" v-on="on">
              <v-icon>mdi-cancel</v-icon>
            </v-btn>
          </template>
          <span>Descartar</span>
        </v-tooltip>

        <v-tooltip top v-if='editing && element.id > 0'>
          <template v-slot:activator="{ on }">
            <v-btn text icon small color="red" @click="cancelEditItem" v-on="on">
              <v-icon>mdi-cancel</v-icon>
            </v-btn>
          </template>
          <span>Cancelar Edição</span>
        </v-tooltip>

        <v-tooltip top  v-if='!editing'>
          <template v-slot:activator="{ on }">
            <v-btn text icon small color="blue" @click="editItem" v-on="on">
              <v-icon>mdi-pencil-outline</v-icon>
            </v-btn>
          </template>
          <span>Editar</span>
        </v-tooltip>

        <v-tooltip top v-if='!editing'>
          <template v-slot:activator="{ on }">
            <v-btn text icon small color="red" v-on="on" @click="destroyItem">
              <v-icon>mdi-delete-forever</v-icon>
            </v-btn>
          </template>
          <span>Excluir</span>
        </v-tooltip>
      </v-col>
    </v-row>

    <cd-format v-model='dataFormatModal'/>

  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import cdFormat from './Format'
  import EventBus from '../../../packs/eventBus.js'

  export default {
    components: { cdFormat },

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

    props: ['item_element', 'item'],

    data () {
      return {
        element: {},
        editing: true,
        formats: [],
        dataFormatModal: { show: false, format: {}, formatValues: {} },
        gauges: [
          { text: "4.2", value: "4_2", weight: "0.109" },
          { text: "5.0", value: "5_0", weight: "0.154" },
          { text: "6.3", value: "6_3", weight: "0.245" },
          { text: "8.0", value: "8_0", weight: "0.395" },
          { text: "10.0", value: "10_0", weight: "0.617" },
          { text: "12.5", value: "12_5", weight: "0.963" },
          { text: "16.0", value: "16_0", weight: "1.578" },
          { text: "20.0", value: "20_0", weight: "2.466" },
          { text: "25.0", value: "25_0", weight: "3.853" },
          { text: "32.0", value: "32_0", weight: "6.313" }
        ],

        oldPosition: null,
        oldGauge: null,
        oldQuantity: null,
        oldFormat: null
      }
    },

    computed: {

    },

    mounted () {
      this.element = this.item_element

      if (this.element && this.element.id > 0) {
        this.editing = false
        this.dataFormatModal.format = this.element.format
        this.dataFormatModal.formatValues = this.element.format_values
      }

      this.getFormats()
    },

    methods: {
      async getFormats() {
        let response = null

        await this.$http.get(`/formats`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.formats = response.body
        }
      },

      async saveItem() {
        let response = null

        this.element.format_id = this.dataFormatModal.format.id
        this.element.format_values = this.dataFormatModal.formatValues

        if ( this.element.id > 0 ) {
          await this.$http.put(`/stage_items/${this.item.id}/item_elements/${this.element.id}`,
            {element: this.element}

          ).then((result) => {
              response = result
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post(`/stage_items/${this.item.id}/item_elements/`,
            {element: this.element}

          ).then(resp => {
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });
        }

        if ( response.status == 200 || response.status == 201 ) {
          this.element = response.body
          this.editing = false

          //EventBus.$emit(`StageItem-${this.item.id}`, this.item)
          EventBus.$emit( `ItemUpdate-${this.item.id}`, true)
        }
      },

      editItem() {
        this.oldPosition = this.element.position
        this.oldGauge = this.element.gauge
        this.oldQuantity = this.element.quantity
        this.oldFormat = this.element.format
        this.editing = true
      },

      openFormat() {
        this.dataFormatModal.show = true
        this.dataFormatModal.format = this.element.format
      },

      cancelItem() {
        EventBus.$emit('cancelItem', this.element)
      },

      cancelEditItem() {
        this.editing = false
        this.element.position = this.oldPosition
        this.element.gauge = this.oldGauge
        this.element.quantity = this.oldQuantity
        this.element.format = this.oldFormat
      },

      async destroyItem() {
        // /stage_items/:stage_item_id/item_elements/:id
        console.log("++++++++++++++++++")
        console.log(this.item_element)
        console.log(this.item)
        console.log("++++++++++++++++++")
      }


    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>