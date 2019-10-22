<template>
  <div id="app">

    <v-row class='mb-1 blue-grey lighten-4'>
      <v-col cols="3" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{editable: editing}'
                      value='Nome do Item' v-model='item.name'>
                      </v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{editable: editing}' v-model="item.quantity">
        </v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{editable: editing}'
                      value='IT1' v-model="item.abbreviation"></v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense disabled v-model="item.weight"></v-text-field>
      </v-col>


      <v-col cols="2" class="py-1">
        <v-btn text icon small color="blue" v-if='!editing' @click="editItem">
          <v-icon>mdi-pencil-outline</v-icon>
        </v-btn>

        <stage-item-element v-model='item' v-if='!editing'/>

        <v-btn text icon small color="red" v-if='!editing' @click="dialog = true">
          <v-icon>mdi-delete-forever</v-icon>
        </v-btn>

        <v-btn text icon small color="green" v-if='editing' @click="saveItem">
          <v-icon>mdi-check-outline</v-icon>
        </v-btn>
      </v-col>
    </v-row>

    <v-dialog v-model="dialog" width="350">
      <v-card>
        <v-card-title primary-title>
          Deseja excluir o item da etapa?
        </v-card-title>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="error" @click="deleteItem" class="full-width">
            Excluir
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>


  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import stageItemElement from './StageItemElement'
  import EventBus from '../../../packs/eventBus.js'

  export default {
    components: { stageItemElement },

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

    props: ['stage', 'stage_item'],

    data () {
      return {
        item: {},
        editing: true,
        edit: false,
        error: true,
        dialog: false
      }
    },

    computed: {

    },

    mounted () {
      this.item = this.stage_item

      if (this.item && this.item.id > 0) {
        this.editing = false
        this.edit = true

        EventBus.$on( `ItemUpdate-${this.item.id}`, this.updateItem )
      }

    },

    methods: {
      async saveItem () {
        let response = null

        if ( this.item.name == '') {
          EventBus.$emit( `ErrorName-${this.stage.id}`, this.error )
          return
        } else if ( this.item.abbreviation == '' ) {
          EventBus.$emit( `ErrorAbbreviation-${this.stage.id}`, this.error )
          return
        }

        if ( this.edit ) {
          await this.$http.put(`/construction_stages/${this.stage.id}/stage_items/${this.item.id}`,
            {stage_item: this.item}

          ).then((result) => {
              response = result
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post(`/construction_stages/${this.stage.id}/stage_items`,
            {stage_item: this.item}

          ).then(resp => {
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });
        }

        if ( response.status == 200 ) {
          this.item = response.body
          this.editing = false
          this.edit = true
          EventBus.$on( `ItemUpdate-${this.item.id}`, this.updateItem )
          EventBus.$emit( `SuccesSubmit-${this.stage.id}`, this.error )
          EventBus.$emit( `UpdateItems-${this.stage.id}`, true )
        }
      },

      editItem() {
        this.editing = true;
      },

      async updateItem( quantity ) {
        let response = null

        await this.$http.get(`/stage_items/${this.item.id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.item = response.body
        }

        EventBus.$emit( `UpdateItems-${this.stage.id}`, true)
      },


      async deleteItem() {
        let response = null

        await this.$http.delete(`/stage_items/${this.item.id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          EventBus.$emit( `UpdateItems-${this.stage.id}`, true)
          EventBus.$emit( `DeleteItem-${this.stage.id}`, true)
          this.dialog = true
        }
      }
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }

  .full-width {
    width: 100%;
  }
</style>
