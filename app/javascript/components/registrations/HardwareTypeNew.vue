<template>
  <div class='container'>
    <div class="card">

      <div class="card-header">
        Novo Tipo de Hardware
      </div>

      <div class="card-body">
        <form @submit.prevent="submit">
          <div class='row'>
            <div class="col-sm-8">
              <div class="form-group">
                <input class="form-control" type="text" v-model='hardware_type.name' placeholder="Tipo de Hardware" />
              </div>
            </div>

            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                Cadastrar
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
        hardware_type: {
          name: ''
        },
        loader: null
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;
        await this.$http.post("/hardware_types", this.hardware_type)
          .then(resp => {
            response = resp;
          })
          .catch(resp => {
            console.log(response);
            response = resp;
          });

        if (response.status == 200) {
          this.messageClass = "success";
          this.$router.push('/hardware-types')

        } else {
          this.messageClass = "danger";
          this.error = true;
          this.errorMessage = response.body.message;
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
      }
    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
