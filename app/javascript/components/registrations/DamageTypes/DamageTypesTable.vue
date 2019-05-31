<template>
  <div id="app">

    <div class="margin-alert">
      <b-alert show dismissible v-if="showAlert" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <table class="table table-hover table-bordered">
      <thead>
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Nome</th>
          <th scope="col">Hardware</th>
          <th scope="col">Editar</th>
          <th scope="col">Excluir</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='(damageType, index) in damageTypes' :key="index">
          <td>{{damageType.id}}</td>
          <td>{{damageType.name}}</td>
          <td>{{damageType.hardware_type.name}}</td>
          <td>
            <router-link :to="{ name: 'damage', params: {damage_id: damageType.id}}">
              <img src='../../../../assets/images/editar.png'/>
            </router-link>
          </td>
          <td>
            <img @click="deleteDamageTypes(damageType.id)" src='../../../../assets/images/excluir.png'/>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    components: { },

    data() {
      return {
        damageTypes: [],
        showAlert: false,
        message: '',
        messageClass: ''

      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.getDamageTypes();
    },

    methods: {
      async getDamageTypes() {
        let response = null;
        await this.$http.get('/damage_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.damageTypes = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async deleteDamageTypes(damageType_id){
        let response = null;

        await this.$http.delete(`/damage_types/${damageType_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if( response.status == 200 ){
          this.getDamageTypes(),
          this.showAlert = true
          this.messageClass = "success"
          this.message = "Tipo de Avaria excluido com sucesso."
        }else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
      }

    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
    margin-right: 50px;
  }

  table {
    margin-top: 20px;
  }

  .edit-icon {
    font-size: 30px
  }
</style>
