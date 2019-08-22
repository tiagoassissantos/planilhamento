<template>
  <div id="app" class='container'>
    <div class="card response-display">
      <div class="card-header ">
        Lista de Lotes
      </div>
      <div class="card-body">

        <div class='row'>
          <div class="col-md-8 col-sm-12">
            <div class="input-group">
              <input type="text" class="form-control" v-model="input" aria-describedby="button-addon4">
              <div class="input-group-append" id="button-addon4">
                <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
                <button class="btn btn-danger" type="button" @click=" input = null ">Limpar pesquisa</button>
              </div>
            </div>
          </div>

          <div class="col-md-2 offset-md-2 col-sm-12">
            <router-link v-if="!user_operator_n2" to="/lots/new" class="btn btn-primary full-width-button float-right">
                Novo Lote
            </router-link>
          </div>
        </div>

        <div class='row'>
          <div class="col-sm-12">
            <div class="table-scroll">
              <table class="table table-hover table-bordered">
                <thead>
                  <tr>
                    <th scope="col" v-if="!user_operator_n1 && !user_operator_n2"> Editar </th>
                    <th scope="col"> Núm. Lote </th>
                    <th scope="col"> Status </th>
                    <th scope="col"> Data </th>
                    <th scope="col"> Ação </th>
                  </tr>
                </thead>

                <tbody>
                  <tr v-for='(lot, index) in lots' :key="index" v-if="regExp( lot )">
                    <td v-if="!user_operator_n1 && !user_operator_n2">
                      <router-link :to="{ name: 'edit-lot', params: {lot_id: lot.id}}">
                        <img src='../../../assets/images/editar.png'/>
                      </router-link>
                    </td>
                    <td>{{lot.order_number}}</td>
                    <td>{{lot.status}}</td>
                    <td>{{lot.created_at}}</td>
                    <td>
                      <span
                        v-if="checkStatusAndUser(lot.status)"
                        @click="updateStatus(lot)"
                        class="btn btn-danger button-custom"
                      >
                        <span v-if="lot.status === 'Aberto'"> Fechar </span>
                        <span v-if="lot.status === 'Reaberto'"> Fechar </span>
                        <span v-if="lot.status === 'Fechado'"> Reabrir </span>
                      </span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import moment from 'moment';
  import { format } from 'path';

  export default {
    components: { },

    data() {
      return {
        lots: [],
        button_text_status: null,
        input: null,
        user_operator_n1: false,
        user_operator_n2: false,
        user_operator_comercial: false
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      },

      getCurrentUser() {
        return this.$store.state.currentUser
      }
    },

    mounted() {
      this.$store.dispatch('getCurrentUser');
      this.$store.subscribe((mutation, state) => {
        if (mutation.type == 'SET_CURRENT_USER') {
          if( this.getCurrentUser.role == "Operador Pós-Venda / Garantia" || this.getCurrentUser.role == "Operador Marketing") {
            this.$router.push('/')
          }
          if( this.getCurrentUser.role == "Operador N1" ) {
            this.user_operator_n1 = true
          }
          if( this.getCurrentUser.role == "Operador N2" ) {
            this.user_operator_n2 = true
          }

          if( this.getCurrentUser.role == "Operador Comercial" ) {
            this.user_operator_comercial = true
          }

        }
      }),
      this.getLots();
    },

    methods: {
      async getLots() {
        let response = null;
        await this.$http.get('/lots')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {

          response.body.forEach(lot => {

            let status = ''

            if( lot.status === 'open') {
              status = 'Aberto'
              this.button_text_status = 'Fechar lote'
            }
            if( lot.status === 'closed') {
              this.button_text_status = 'Reabrir lote',
              status = 'Fechado'
            }
            if( lot.status === 'reopened') {
              this.button_text_status = 'Fechar lote'
              status = 'Reaberto'
            }

            this.lots.push({
              id: lot.id,
              order_number: lot.order_number,
              status: status,
              created_at: moment(lot.created_at).format('DD/MM HH:mm'),
            })
          });

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      regExp( lot ) {
        var lot_id = lot.id.toString()
        var order_number = lot.order_number.toLowerCase()
        var created_at = lot.created_at.toLowerCase()
        var status = lot.status.toLowerCase()

        if( this.input === null){
          return true
        }else{
          this.input = this.input.toLowerCase()
          if(
              lot_id.match(this.input)        ||
              order_number.match(this.input)  ||
              created_at.match(this.input)    ||
              status.match(this.input)
            ) {
            return true
          }else{
            return false
          }
        }
      },

      async updateStatus(lot_update) {
        let response = null

          if( lot_update.status === 'Aberto') { lot_update.status = 'closed'}
          if( lot_update.status === 'Fechado') { lot_update.status = 'reopened' }
          if( lot_update.status === 'Reaberto') { lot_update.status = 'closed' }

        await this.$http.put(`/lots/${lot_update.id}`, {lot: lot_update})
          .then((result) => {
            response = result;
          }).catch((err) => {
            response = err
          });

          if ( response.status == 200 ) {
            this.lots = []
            this.getLots();
          }
      },

      checkStatusAndUser( lot_status ) {
        if( this.user_operator_n1 && lot_status == "Fechado") {
          return false
        } else if ( this.user_operator_n2 && lot_status == "Fechado" ){
          return false
        } else if( this.user_operator_comercial ){
          return false
        } else {
          return true
        }
      }
    }
  }
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

  .button-custom {
    cursor: pointer;
  }
</style>
