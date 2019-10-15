<template>
  <div id="app">
    <v-container>

      <h1 class="margin-top text-md-center"> Usuários Cadastrados </h1>
      <v-btn class="mt-5" color="primary" x-large to="/user/new"> Cadastrar </v-btn>

      <v-simple-table class="mt-5">
        <template v-slot:default>
          <thead>
            <tr>
              <th class="text-left">Nome</th>
              <th class="text-left">E-mail</th>
              <th class="text-left">CPF</th>
              <th class="text-left">Ação</th>
              <th class="text-left">Tipo</th>
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
