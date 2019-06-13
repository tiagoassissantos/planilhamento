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
                <input class="form-control" type="text" v-model='category.name' placeholder="Nome da Categoria" />
              </div>
            </div>

            <div class="col-sm-2">
              <button type='submit' class="btn btn-primary">
                {{button_text}} {{modal_params}}
              </button>
            </div>
          </div>

          <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
            <center>
              <img  class="size-img-modal" src="../../../../assets/images/checked.png"/>
            </center>
            <p class="my-1"> {{ messageModal }} </p>
          </b-modal>

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
        category: {
          name: ''
        },
        loader: null,
        edit: false,
        category_id: null,
        error: false,
        messageClass: '',
        message: '',

        header_text: '',
        button_text: '',

        showModal: false,
        messageModal: '',
      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.category_id = this.$route.params.category_id

      if ( this.category_id != null) {
        this.edit = true
        this.getCategory()
        this.header_text = 'Editar Categoria'
        this.button_text = 'Editar'
      } else {
        this.header_text = 'Nova Categoria'
        this.button_text = 'Cadastrar'
      }
    },

    methods: {
      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          await this.$http.put(`/categories/${this.category_id}`,
          JSON.stringify({category: this.category}))
          .then((result) => {
            response = result;
            this.messageModal = 'Categoria editada com sucesso'

          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post("/categories", this.category)
            .then(resp => {
              response = resp;
              this.messageModal = 'Categoria cadastrada com sucesso'
            })
            .catch(resp => {
              response = resp;
            });
        }

        if (response.status == 200) {
          this.messageClass = "success";
          this.showModal = true

          setTimeout(function(){
            this.showModal = false
            this.$router.push('/categories')
          }.bind(this), 2000);

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

      async getCategory(){
        let response = null;

        await this.$http.get(`/categories/${this.category_id}`)
        .then((result) => {
          this.category =  result.body
        }).catch((err) => {
          response = err.body
        });
      }
    },

    props: {
      modal_params: String
    }

  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
