<template>
  <div id="app">
    <v-container>

      <v-card class="mx-auto">
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1">Formatos</span>
            </v-col>
            <v-col cols="2">
              <v-btn class="float-right" color="primary" large to="/formats/new"> Cadastrar </v-btn>
            </v-col>
          </v-row>
        </v-card-title>

        <v-card-text>
          <v-alert type="success" v-if="alert" class="mb-3 mt-3">
            Obra excluida com sucesso.
          </v-alert>

          <v-simple-table class="mt-5">
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Nome</th>
                  <th class="text-left">Quantidade de Lados</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="format in formats" :key="format.id">
                  <td>{{ format.name }}</td>
                  <td>{{ format.sides }}</td>
                  <td>
                    <v-btn :to="{ name: 'format_edit', params: {id: format.id}}" color="success">
                      Editar
                    </v-btn>
                    <v-btn @click="deleteFormat(format.id)" color="error">
                      Excluir
                    </v-btn>
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
export default {
  data() {
    return {
      formats: [],
      alert: false
    }
  },

  mounted() {
    this.getFormats();
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

    async deleteFormat( id ) {
      let response = null

      await this.$http.delete(`/formats/${id}`)
      .then((result) => {
        response = result
      }).catch((err) => {
        response = err
      });

      if ( response.status == 200 ) {
        this.formats = [],
        this.getFormats(),
        this.alert = true
      }
    }
  }
}
</script>

<style scoped>

  .margin-top {
    margin-top: 50px;
  }
</style>
