<template>
  <div id="app">
    <v-container>
      <v-card>
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1">Etiquetas - Obras Cadastradas</span>
            </v-col>
          </v-row>
        </v-card-title>

        <v-card-text>
          <v-alert type="success" v-if="false" class="mb-3 mt-3">
            Obra excluida com sucesso.
          </v-alert>

          <v-alert type="error" v-if="false" class="mb-3 mt-3">
            Erro ao excluir obra.
          </v-alert>

          <v-simple-table class="mt-5">
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Nome</th>
                  <th class="text-left">E-mail</th>
                  <th class="text-left">CPF/CNPJ</th>
                  <th class="text-left">Telefone</th>
                  <th class="text-left">Contato</th>
                  <th class="text-left">Ação</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="construction in constructions" :key="construction.id">
                  <td>{{ construction.name }}</td>
                  <td>{{ construction.email }}</td>
                  <td>{{ construction.cpf_cnpj }}</td>
                  <td>{{ construction.contact_number }}</td>
                  <td>{{ construction.contato }}</td>
                  <td>
                    <v-btn :href="`/reports/tags/${construction.id}`" color="success">
                      Gerar Etiquetas
                    </v-btn>

                    <!-- <v-btn :to="{ name: 'construction_show', params: {id: construction.id}}" color="primary">
                      Planilhar
                    </v-btn> -->
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-card-text>

      </v-card>
    </v-container>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  import EventBus from '../../../packs/eventBus.js'

  export default {
    components: {  },

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

    data () {
      return {
        constructions: [],
        dialog: false
      }
    },

    computed: {

    },

    mounted () {
      this.getConstructions()
    },

    methods: {
      async getConstructions() {
        let response = null

        await this.$http.get(`/constructions`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.constructions = response.body
        }
      },

      async generate( construction_id ) {
        await this.$http.get(`/reports/tags/${construction_id}`,
            {construction_id: construction_id}

          ).then(resp => {
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });

        if ( response.status == 200 || response.status == 201 ) {
           
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