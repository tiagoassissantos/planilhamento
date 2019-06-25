<template>
  <div id="app" class='container'>
    <div class="card">
      <div class="card-header">
        Lista de Lotes
      </div>
      <div class="card-body">

        <div class='row'>
          <div class="col-sm-8">
            <div class="input-group">
              <input type="text" class="form-control" v-model="input" aria-describedby="button-addon4">
              <div class="input-group-append" id="button-addon4">
                <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
                <button class="btn btn-danger" type="button" @click=" input = null ">Limpar pesquisa</button>
              </div>
            </div>
          </div>

          <div class="col-sm-2 offset-sm-2">
            <router-link to="/lots/new" class="btn btn-primary float-right">
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
                    <th scope="col">Editar</th>
                    <th scope="col">Código</th>
                    <th scope="col">Núm. Lote</th>
                    <th scope="col"> Status </th>
                    <th scope="col">Data</th>
                  </tr>
                </thead>

                <tbody>
                  <tr v-for='(lot, index) in lots' :key="index" v-if="regExp( lot )">
                    <td>
                      <router-link :to="{ name: 'edit-lot', params: {lot_id: lot.id}}">
                        <!--router-link to="/lots/" class="nav-link active text-light"-->
                        <img src='../../../assets/images/editar.png'/>
                      </router-link>
                    </td>
                    <td>{{lot.id}}</td>
                    <td>{{lot.order_number}}</td>
                    <td>{{lot.status}}</td>
                    <td>{{lot.created_at}}</td>
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

        input: null
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
          if( this.getCurrentUser.role == "Operador N2") {
            this.$router.push('/')
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

            if( lot.status === 'open') { status = 'Aberto'}
            if( lot.status === 'closed') { status = 'Fechado' }
            if( lot.status === 'reopened') { status = 'Reaberto' }

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
</style>
