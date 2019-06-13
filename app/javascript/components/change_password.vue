<template>
  <div class='container'>
    <div class="card">
      <div class="card-header">
        Alterar Senha
      </div>

      <div class="card-body">
        <b-alert show dismissible  variant="danger" v-if="error">  {{ messageText }} </b-alert>
        <form @submit.prevent="submit">

          <div class="form-group">
            <input class="form-control" v-model="user.current_password" type="password" placeholder="Senha atual" />
          </div>

          <div class="form-group">
            <input class="form-control" v-model="user.password" type="password" placeholder="Nova senha" />
          </div>

          <div class="form-group">
            <input class="form-control" v-model="user.password_confirm" type="password" placeholder="Confirme a nova senha" />
          </div>

          <center>
            <button type='submit' class="btn btn-primary"> Alterar Senha </button>
          </center>

          <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
            <center>
              <img  class="size-img-modal" src="../../assets/images/checked.png"/>
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
    data() {
      return{
        user:{
          current_password: null,
          password: null,
          password_confirm: null
        },

        error: false,
        messageText: null,

        showModal: false,
        messageModal: '',
      }
    },

    methods: {

      async submit() {
        this.showLoading()
        let response = null;

        await this.$http.patch(`/update_password`, JSON.stringify({user: this.user}))
        .then((result) => {
          response = result;
        }).catch((err) => {
          response = err;
        });

        if (response.body.status == 'success') {
          this.error = false;


          this.messageModal = 'Senha alterada com sucesso, você será redirecionado.'
          this.showModal = true


          setTimeout(function(){
            this.showModal = false
            window.location.href="/"
          }.bind(this), 2000);

        } else {
          this.error = !this.error;
          this.messageText = response.body.message;
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
    }

  }

</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
