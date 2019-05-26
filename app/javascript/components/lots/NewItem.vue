<template>
  <div class='container'>
    <div class="card">
      <div class="card-header">
        <div class="row">
          <div class="col-sm-6">
            Novo Item
          </div>
        </div>
      </div>

      <div class="card-body"> <!-- =================== -->
        <div class="input-group">
          <input type="text" class="form-control" placeholder='Informe o SKU' aria-describedby="button-addon4">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button">Limpar pesquisa</button>
          </div>


          <div class="card">
            <div class="card-body">

              <div class="container">
                <div class="row">
                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Tipo de Hardware</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Fabicante</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Modelo</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Memória RAM</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Número de Série</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Asset TAG</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Categoria</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Comentários</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Local / Tipo Avaria</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Processador</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Tamanho</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Tipo</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Parent (ID)</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Tela (Polegadas)</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Webcam</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Sim</option>
                        <option value="13">Não</option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Tipo Teclado</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Sim</option>
                        <option value="13">Não</option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Wireless</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Bluetooth</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Mini Display Port</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>HDMI</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>VGA</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>eSata</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Teclado Luminoso</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Destino</label>
                      <select class="form-control">
                        <option value="undefined" selected>Selecione</option>
                        <option value="12">Monitor</option>
                        <option value="13">Desktop</option>
                        <option value="14">Servidor</option>
                        <option value>Notebook</option>
                        <option value>Celular</option>
                        <option value>Tablet</option>
                        <option value>Switch</option>
                        <option value>HD</option>
                        <option value>SSD</option>
                        <option value></option>
                      </select>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Código de Barras</label>
                      <input type="text" class="form-control" />
                    </div>
                  </div>
                </div> <!-- End Row -->

                <div class="float-right">
                  <button class="btn btn-primary" type="button">
                    Adicionar
                  </button>
                  <button class="btn btn-danger cancel-btn" type="button" v-on:click='cancelItem'>
                    Cancelar
                  </button>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div> <!-- ==================== -->
    </div>
  </div> <!-- app -->
</template>

<script>
  export default {
    components: {  },

    data() {
      return {
        hardwareType: '',
        manufacturer: '',
        model: '',
        ramMemory: '',
        serialNumber: '',
        assetTag: '',
        category: '',
        comments: '',
        damageType: '',
        processor: '',
        size: '',
        type: '',
        parentId: '',
        screenSize: '',
        webcam: '',
        keyboardType: '',
        wirelles: '',
        bluetooth: '',
        miniDisplayPort: '',
        hdmi: '',
        vga: '',
        esata: '',
        luminousKeyboard: '',
        destination: '',
        barCode: ''
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
      cancelItem() {
        this.$router.go(-1)
      }
    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }

  .cancel-btn {
    margin-left: 15px;
  }
</style>
