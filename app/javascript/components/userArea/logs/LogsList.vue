<template>
  <div id="app">
    <v-container>
      <v-card>
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1">Logs Registrados</span>

            </v-col>

          </v-row>
        </v-card-title>
        <v-card-text>

          <v-simple-table class="mt-5">
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left"> Nome do usuário </th>
                  <th class="text-left"> Ação </th>
                  <th class="text-left"> Registro </th>
                  <th class="text-left"> Descrição </th>
                  <th class="text-left"> Data Modificação </th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="log in logs" :key="log.id">
                  <td> {{ log.user_id }} </td>
                  <td> {{ log.action }} </td>
                  <td> {{ log.registry }} </td>
                  <td> {{ log.description }} </td>
                  <td> {{ formatData(log.created_at) }} </td>
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
import moment from 'moment';

export default {

  data() {
    return {
      logs: [],
      alert: false,
      errorAlert: false,
      isAdmin: false
    }
  },

  mounted() {
    this.getAdmin()
    this.getLogs()
  },

  methods: {
    async getLogs () {
      let response = null

      await this.$http.get('/logs')
      .then((result) => {
        response = result
      }).catch((err) => {
        response = err
      });

      if ( response.status == 200 ) {
        this.logs = response.body
      }
    },

    formatData( data ) {
      return moment(data).format('DD/MM HH:mm')
    },

    async getAdmin () {
      let response = null;

      await this.$http.get(`/get_user`)
      .then((result) => {
        response = result

      }).catch((err) => {
        response = err
      });

      if ( response.body.role != 'Administrador' ) {
        this.$router.push('/')
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
