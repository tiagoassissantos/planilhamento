<template>
  <div id="app">

    <v-row class='mb-1 blue-grey lighten-4'>
      <v-col cols="3" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{editable: editing}' 
          value='Nome do Item' v-model='item.name'></v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense readonly value='11X'></v-text-field>
      </v-col>

      <v-col cols="2" class="py-1">
        <v-text-field dense :readonly='!editing' :class='{editable: editing}' value='IT1'></v-text-field>
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

        <stage-item-element :item='item' v-if='!editing'/>

        <v-btn text icon small color="red" v-if='!editing'>
          <v-icon>mdi-delete-forever</v-icon>
        </v-btn>

        <v-btn text icon small color="green" v-if='editing' @click="saveItem">
          <v-icon>mdi-check-outline</v-icon>
        </v-btn>
      </v-col>
    </v-row>

  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import stageItemElement from './StageItemElement'

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

    props: ['stage'],

    data () {
      return {
        item: {
          name: '',
        },
        editing: true
      }
    },

    mounted () {
      
    },

    computed: {
      
    },

    methods: {
      saveItem() {
        this.editing = false;
      },

      editItem() {
        this.editing = true;
      }
    }
  }
</script>

<style scoped>
  .editable {
    background-color: white !important;
  }
</style>