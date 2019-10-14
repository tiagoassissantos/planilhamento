<template>
  <div id="app">
    <v-container>

      <h1 class="margin-top text-md-center"> Obras Cadastradas </h1>
      <v-btn class="mt-5" color="primary" x-large to="/construction/new"> Cadastrar </v-btn>

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
                <v-btn :to="{ name: 'customer_edit', params: {id: construction.id}}" color="success">
                  Editar
                </v-btn>
              </td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>

    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      constructions: []
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

  }
}
</script>

<style scoped>

  .margin-top {
    margin-top: 50px;
  }
</style>
