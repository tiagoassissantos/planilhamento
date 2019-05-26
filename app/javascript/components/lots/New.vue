<template>
  <div class='container'>
    <div class="card">

      <div class="card-header">
        Novo Lote
      </div>

      <div class="card-body">
        <div class='row'>
          <div class="col-sm-8">
            <div class="form-group">
              <input class="form-control" type="email" name="email" placeholder="Número do Pedido" />
            </div>
          </div>

          <div class="col-sm-2">
            <router-link to="/lots/1" class="btn btn-primary">
                Criar
            </router-link>
          </div>
        </div>

      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  export default {
    components: {  },

    computed: {
      isLogged() {
        return this.$store.state.logged
      }
    },

    mounted() {
      this.$store.dispatch('isLogged');
    },

    methods: {
    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }
</style>
