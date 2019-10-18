<template>
  <div>
    
    <v-row class='mb-1 blue-grey lighten-4'>
      <v-col cols="2" class="py-1">
        <v-text-field dense disabled v-model='element.position'></v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-select dense v-model="element.gauge" :items="gauges" :readonly='!editing'
                  :class='{editable: editing}' persistent-hint
                  single-line required @change="calcWeight()">
        </v-select>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{editable: editing}' 
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
        <v-btn text icon small color="green" v-if='editing' @click="saveItem">
          <v-icon>mdi-check-outline</v-icon>
        </v-btn>

        <v-btn text icon small color="blue" v-if='!editing' @click="editItem">
          <v-icon>mdi-pencil-outline</v-icon>
        </v-btn>

        <v-btn text icon small color="red" v-if='!editing'>
          <v-icon>mdi-delete-forever</v-icon>
        </v-btn>
      </v-col>
    </v-row>

    <cd-format v-model='dataFormatModal'/>

    {{ dataFormatModal }}
    <br>
    editar {{ editar }}
    <br>
    editing {{ editing }}
    <br>
    element.id {{ element.id }}
    
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import cdFormat from './Format'

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

    props: ['element', 'item'],

    data () {
      return {
        elements: [],
        editing: true,
        edit: false,
        editar: false,
        formats: [],
        dataFormatModal: { show: false, format: {}, formatDimensions: {} },
        gauges: [
          { text: "4.2", value: "4.2", weight: "0.109" },
          { text: "5.0", value: "5.0", weight: "0.154" },
          { text: "6.3", value: "6.3", weight: "0.245" },
          { text: "8.0", value: "8.0", weight: "0.395" },
          { text: "10.0", value: "10.0", weight: "0.617" },
          { text: "12.5", value: "12.5", weight: "0.963" },
          { text: "16.0", value: "16.0", weight: "1.578" },
          { text: "20.0", value: "20.0", weight: "2.466" },
          { text: "25.0", value: "25.0", weight: "3.853" },
          { text: "32.0", value: "32.0", weight: "6.313" }
        ]
      }
    },

    mounted () {
      if (this.element && this.element.id > 0) {
        this.editing = false
        this.edit = false
      }

      this.getFormats()
    },

    computed: {
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
        this.editing = false
        let response = null

        this.element.format_id = this.dataFormatModal.format.id
        this.element.format_values = this.dataFormatModal.formatDimensions

        console.log('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^')
        console.log( this.editar )

        if ( this.element.id > 0 ) {
          await this.$http.put(`/stage_items/${this.item.id}/item_elements/${this.element.id}`,
            {stage_item: this.item}
          
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

        console.log( response.status )

        if ( response.status == 201 ) {
          console.log( '+++++++++++++++++++++++++++++++++++++++++++++++++')
          this.element.id = response.body.id
          console.log( '=====> 1')
          this.editing = false
          console.log( '=====> 2')
          this.editar = true;
          console.log( '=====> 3')
        }
      },

      editItem() {
        this.editing = true
      },

      openFormat() {
        console.log( this.element.format )
        this.dataFormatModal.show = true
        this.dataFormatModal.format = this.element.format
      },

      calcWeight() {
        console.log('§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§')
      }
    },

    watch: {
      dataFormatModal: function() {
        this.calcWeight()
      }
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>