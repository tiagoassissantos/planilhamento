<template>
  <div id="app">
    <v-container>
      <v-card class="mx-auto">
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1">Usuários Cadastrados</span>
            </v-col>
            <v-col cols="2">
              <v-btn color="primary" large to="/user/new"> Cadastrar </v-btn>
            </v-col>
          </v-row>
        </v-card-title>

        <v-card-text class="mb-3 mt-3">
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Nome</th>
                  <th class="text-left">E-mail</th>
                  <th class="text-left">CPF</th>
                  <th class="text-left">Tipo</th>
                  <th class="text-left">Ação</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="user in users" :key="user.id">
                  <td>{{ user.name }}</td>
                  <td>{{ user.email }}</td>
                  <td>{{ user.cpf }}</td>
                  <td>{{ user.role }}</td>
                  <td>
                    <v-btn :to="{ name: 'user_edit', params: {id: user.id}}" color="success">
                      Editar
                    </v-btn>
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-card-text>
      </v-card>

      <h1 class="margin-top text-md-center">  </h1>




    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      users: []
    }
  },

  mounted() {
    this.getUsers();
  },

  methods: {

    async getUsers() {
      let response = null

      await this.$http.get(`/users`)
      .then((result) => {
        response = result
      }).catch((err) => {
        response = err
      });

      if ( response.status == 200 ) {
        this.users = response.body
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
