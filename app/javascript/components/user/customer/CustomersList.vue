<template>
  <div id="app">
    <v-container>

      <h1 class="margin-top text-md-center"> Clientes Cadastrados </h1>
      <v-btn class="mt-5" color="primary" x-large to="/customer/new"> Cadastrar </v-btn>

      <v-simple-table class="mt-5">
        <template v-slot:default>
          <thead>
            <tr>
              <th class="text-left">Nome</th>
              <th class="text-left">E-mail</th>
              <th class="text-left">Ação</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="customer in customers" :key="customer.id">
              <td>{{ customer.name }}</td>
              <td>{{ customer.email }}</td>
              <td>
                <v-btn :to="{ name: 'customer_edit', params: {id: customer.id}}" color="success">
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
      customers: []
    }
  },

  mounted() {
    this.getCustomers();
  },

  methods: {

    async getCustomers() {
      let response = null

      await this.$http.get(`/customers`)
      .then((result) => {
        response = result
      }).catch((err) => {
        response = err
      });

      if ( response.status == 200 ) {
        this.customers = response.body
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
