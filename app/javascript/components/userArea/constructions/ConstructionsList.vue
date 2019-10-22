<template>
  <div id="app">
    <v-container>
      <v-card>
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1">Obras Cadastradas</span>

            </v-col>
            <v-col cols="2">
              <v-btn class="float-right" color="primary" large to="/construction/new"> Cadastrar </v-btn>
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
                    <v-btn :to="{ name: 'construction_edit', params: {id: construction.id}}" color="success">
                      Editar
                    </v-btn>
                    <v-btn @click="deleteContruction(construction.id)" color="error">
                      Excluir
                    </v-btn>
                    <v-btn :to="{ name: 'construction_show', params: {id: construction.id}}" color="primary">
                      Planilhar
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
      constructions: [],
      alert: false
    }
  },

  mounted() {
    this.getConstructions();
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

    async deleteContruction( id ) {
      let response = null

      await this.$http.delete(`/constructions/${id}`)
      .then((result) => {
        response = result
      }).catch((err) => {
        response = err
      });

      if ( response.status == 200 ) {
        this.constructions = [],
        this.getConstructions(),
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
