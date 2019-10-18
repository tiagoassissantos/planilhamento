<template>
  <div id="app">
    <v-container>
      <v-card class="max-auto">
        <v-card-title class='grey py-1'>
          <v-row>

            <v-col cols="10">
              <span class="display-1 mb-1"> Clientes Cadastrados </span>
            </v-col>

            <v-col cols="2">
              <v-btn class="float-right" color="primary" large to="/customer/new"> Cadastrar </v-btn>
            </v-col>

          </v-row>
        </v-card-title>

        <v-card-text>

          <v-simple-table class="mb-3 mt-3">
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Nome</th>
                  <th class="text-left">E-mail</th>
                  <th class="text-left">CPF/CNPJ</th>
                  <th class="text-left">Telefone</th>
                  <th class="text-left">Vendedor</th>
                  <th class="text-left">Ação</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="customer in customers" :key="customer.id">
                  <td>{{ customer.name }}</td>
                  <td>{{ customer.email }}</td>
                  <td>{{ customer.cpf_cnpj }}</td>
                  <td>{{ customer.phone }}</td>
                  <td>{{ customer.salesman }}</td>
                  <td>
                    <v-btn :to="{ name: 'customer_edit', params: {id: customer.id}}" color="success">
                      Editar
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
