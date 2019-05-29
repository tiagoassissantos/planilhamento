<template>
  <div class='container'>

    <div class="margin-alert">
      <b-alert show dismissible v-if="error" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="card">
      <div class="card-header">
        {{ header_text }}
      </div>

      <div class="card-body">
        <form @submit.prevent="submit">
          <div class='row'>
            <div class="col-sm-8">
              <div class="form-group">
                <input class="form-control" type="text" v-model='destination.name' placeholder="Nome do Destino" />
              </div>
            </div>

            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                {{button_text}}
              </button>
            </div>
          </div>
        </form>
      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  export default {
    components: {  },

    data() {
      return {
        destination: {
          name: ''
        },
        loader: null,
        edit: false,
        destination_id: null,
        error: false,
        messageClass: '',
        message: '',

        header_text: '',
        button_text: ''
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.destination_id = this.$route.params.destination_id

      if ( this.destination_id != null) {
        this.edit = true
        this.getDestination()
        this.header_text = 'Editar Destino'
        this.button_text = 'Editar'
      } else {
        this.header_text = 'Novo Destino'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/destinations/${this.destination_id}`,
          JSON.stringify({destination: this.destination}))
          .then((result) => {
            response = result;
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post("/destinations", this.destination)
            .then(resp => {
              response = resp;
            })
            .catch(resp => {
              console.log(response);
              response = resp;
            });
        }


        if (response.status == 200) {
          this.messageClass = "success";
          this.$router.push('/destinations')

        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = response.body.message;
        }

        this.loader.hide()
      },

      showLoading() {
        this.loader = this.$loading.show({
          container: this.fullPage ? null : this.$refs.formContainer,
          canCancel: false,
          backgroundColor: '#000',
          opacity: 0.75
        });
      },

      async getDestination(){
        let response = null;

        await this.$http.get(`/destinations/${this.destination_id}`)
        .then((result) => {
          this.destination =  result.body
        }).catch((err) => {
          response = err.body
        });
      }

    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
