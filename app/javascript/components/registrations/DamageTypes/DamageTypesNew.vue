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

            <div class="col-md-5">
              <div class="form-group">
                <select class="form-control" type="text" v-model='damageType.hardware_type_id' required>
                  <option value='0'>Selecione o Tipo de Hardware</option>
                  <option v-for='hardwareType in hardwareTypes' :value='hardwareType.id'>
                    {{hardwareType.name}}
                  </option>
                </select>
              </div>
            </div>

            <div class="col-md-5">
              <div class="form-group">
                <input class="form-control" type="text" v-model='damageType.name' placeholder="Tipo de Avaria" />
              </div>
            </div>

            <div class="col-md-2">
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
        damageType: {
          name: '',
          hardware_type_id: 0,
        },
        damageType_id: null,
        hardwareTypes: [],
        loader: null,
        edit: false,
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
      this.gethardwareTypes();

      this.damageType_id = this.$route.params.damage_id

      if ( this.damageType_id != null) {
        this.edit = true
        this.getDamageType()
        this.header_text = 'Editar Tipo de Avaria'
        this.button_text = 'Editar'

      } else {
        this.header_text = 'Novo Tipo de Avaria'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async gethardwareTypes() {
        let response = null;
        await this.$http.get('/hardware_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.hardwareTypes = response.body;

        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },


      async getDamageType() {
        let response = null;

        await this.$http.get(`/damage_types/${this.damageType_id}`)
        .then((result) => {
          this.damageType.name = result.body.name
          this.damageType.hardware_type_id = result.body.hardware_type.id

        }).catch((err) => {
          response = err.body
        });
      },


      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/damage_types/${this.damageType_id}`,
            this.damageType)
            .then((result) => {
              response = result;
            }).catch((err) => {
              response = err
            });

        } else {
          await this.$http.post("/damage_types", this.damageType)
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
          this.$router.push('/damage-types')

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
      }
    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
