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
                <form @submit.prevent="submit">
                  <div class="row">
                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Tipo de Hardware</label>
                        <select class="form-control" type="text" v-model='lot_item.hardware_type_id' @change='getDamageTypes()' required>
                          <option value='0'>Selecione o Tipo de Hardware</option>
                          <option v-for='hardwareType in hardwareTypes' :value='hardwareType.id'>
                            {{hardwareType.name}}
                          </option>
                        </select>
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Fabicante</label>
                        <select class="form-control" v-model='manufacturerId' @change='getModels()'>
                          <option value='0'>Selecione o Fabricante</option>
                          <option v-for='manufacturer in manufacturers' :value='manufacturer.id'>
                            {{manufacturer.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Modelo</label>
                        <select class="form-control" type="text" v-model='lot_item.model_id' required>
                          <option value='0'>Selecione o Modelo</option>
                          <option v-for='model in models' :value='model.id'>
                            {{model.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showMemory'>
                      <div class="form-group">
                        <label>Memória RAM</label>
                        <input type="text" class="form-control" v-model='lot_item.ram_memory' />
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Número de Série</label>
                        <input type="text" class="form-control" v-model='lot_item.serial_number' />
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Asset TAG</label>
                        <input type="text" class="form-control" v-model='lot_item.asset_tag' />
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showCategory'>
                      <div class="form-group">
                        <label>Categoria</label>
                        <select class="form-control" type="text" v-model='lot_item.category_id' required>
                          <option value='0'>Selecione a Categoria</option>
                          <option v-for='category in categories' :value='category.id'>
                            {{category.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Comentários</label>
                        <input type="text" class="form-control" v-model='lot_item.comments' />
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Local / Tipo Avaria</label>
                        <select class="form-control" type="text" v-model='lot_item.damage_type_id' required>
                          <option value='0'>Selecione o Tipo de Avaria</option>
                          <option v-for='damageType in damageTypes' :value='damageType.id'>
                            {{damageType.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showProcessor'>
                      <div class="form-group">
                        <label>Processador</label>
                        <select class="form-control" type="text" v-model='lot_item.processor_id' required>
                          <option value='0'>Selecione o Processador</option>
                          <option v-for='processor in processors' :value='processor.id'>
                            {{processor.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showDiskFields'>
                      <div class="form-group">
                        <label>Tamanho do HD</label>
                        <select class="form-control" type="text" v-model='lot_item.disk_size_id' required>
                          <option value='0'>Selecione o Tamanho do HD</option>
                          <option v-for='diskSize in diskSizes' :value='diskSize.id'>
                            {{diskSize.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showDiskFields'>
                      <div class="form-group">
                        <label>Tipo</label>
                        <select class="form-control" type="text" v-model='lot_item.disk_type_id' required>
                          <option value='0'>Selecione o Tipo do HD</option>
                          <option v-for='diskType in diskTypes' :value='diskType.id'>
                            {{diskType.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showDiskFields'>
                      <div class="form-group">
                        <label>Parent (ID)</label>
                        <input type="text" class="form-control" v-model='lot_item.parent_id'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showScreen'>
                      <div class="form-group">
                        <label>Tela (Polegadas)</label>
                        <input type="text" class="form-control" v-model='lot_item.screen'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showWebcam'>
                      <div class="form-group">
                        <label>Webcam</label>
                        <select class="form-control" v-model='lot_item.webcam'>
                          <option value="undefined" selected>Selecione</option>
                          <option value="12">Sim</option>
                          <option value="13">Não</option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showKeyboardType'>
                      <div class="form-group">
                        <label>Tipo Teclado</label>
                        <select class="form-control" type="text" v-model='lot_item.keyboard_type_id' required>
                          <option value='0'>Selecione o Tipo de Teclado</option>
                          <option v-for='keyboardType in keyboardTypes' :value='keyboardType.id'>
                            {{keyboardType.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showWireless'>
                      <div class="form-group">
                        <label>Wireless</label>
                        <input type="text" class="form-control" v-model='lot_item.wireless'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showBluetooth'>
                      <div class="form-group">
                        <label>Bluetooth</label>
                        <select class="form-control" v-model='lot_item.bluetooth'>
                          <option value="undefined" selected>Selecione</option>
                          <option value="1">Sim</option>
                          <option value="0">Não</option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3"  v-if='showMiniDisplayPort'>
                      <div class="form-group">
                        <label>Mini Display Port</label>
                        <input type="text" class="form-control" v-model='lot_item.mini_display_port'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showHdmihVgaEsata'>
                      <div class="form-group">
                        <label>HDMI</label>
                        <input type="text" class="form-control" v-model='lot_item.hdmi'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showHdmihVgaEsata'>
                      <div class="form-group">
                        <label>VGA</label>
                        <input type="text" class="form-control" v-model='lot_item.vga'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showHdmihVgaEsata'>
                      <div class="form-group">
                        <label>eSata</label>
                        <select class="form-control" v-model='lot_item.esata'>
                          <option value="undefined" selected>Selecione</option>
                          <option value="1">Sim</option>
                          <option value="0">Não</option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showLuminousKeyboard'>
                      <div class="form-group">
                        <label>Teclado Luminoso</label>
                        <input type="text" class="form-control" v-model='lot_item.bright_keyboard'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showBiometricReader'>
                      <div class="form-group">
                        <label>Leitor Biométrico</label>
                        <input type="text" class="form-control" v-model='lot_item.biometric_reader'/>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showVideoCard'>
                      <div class="form-group">
                        <label>Tipo Placa Vídeo</label>
                        <select class="form-control" v-model='lot_item.vga_card'>
                          <option value="undefined" selected>Selecione</option>
                          <option value="1">Integrada</option>
                          <option value="0">Dedicada</option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Destino</label>
                        <select class="form-control" type="text" v-model='lot_item.destination_id' required>
                          <option value='0'>Selecione o Destino</option>
                          <option v-for='destination in destinations' :value='destination.id'>
                            {{destination.name}}
                          </option>
                        </select>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if='showBarCode'>
                      <div class="form-group">
                        <label>Código de Barras</label>
                        <input type="text" class="form-control" v-model='lot_item.bar_code'/>
                      </div>
                    </div>
                  </div> <!-- End Row -->

                  <div class="float-right">
                    <button class="btn btn-primary" type="submit">
                      Adicionar
                    </button>
                    <button class="btn btn-danger cancel-btn" type="button" v-on:click='cancelItem'>
                      Cancelar
                    </button>
                  </div>
                </form>
              </div> <!-- === FIM CONTAINER === -->
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
        lot_item: {
          hardware_type_id: 0,
          model_id: 0,
          ram_memory: '',
          serial_number: '',
          asset_tag: '',
          //category_id: 0,
          comments: '',
          //damage_type_id: 0,
          //processor_id: 0,
          size: '',
          type: '',
          parent_id: '',
          screen_size: '',
          webcam: '',
          //keyboard_type_id: 0,
          wireless: '',
          bluetooth: '',
          mini_display_port: '',
          hdmi: '',
          vga: '',
          esata: '',
          luminous_keyboard: '',
          destination_id: 0,
          bar_code: ''
        },

        hardwareTypes: [],
        manufacturers: [],
        manufacturerId: 0,
        models: [],
        categories: [],
        damageTypes: [],
        processors: [],
        diskTypes: [],
        diskSizes: [],
        keyboardTypes: [],
        destinations: [],

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
      },

      showMemory() {
        if (this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showCategory() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showProcessor() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showDiskFields() {
        if (
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return true;
        }
        return false;
      },

      showScreen() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showWebcam() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showKeyboardType() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showWireless() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 3 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showBluetooth() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 3 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showMiniDisplayPort() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showHdmihVgaEsata() {
        if (
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 3 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showLuminousKeyboard() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showBiometricReader() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showVideoCard() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showBarCode() {
        if (this.lot_item.destination_id == 0 || this.lot_item.destination_id == 3) {
          return false;
        }
        return true;
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id;

      this.getHardwareTypes();
      this.getManufacturers();
      this.getCategories();
      this.getProcessors();
      this.getDiskTypes();
      this.getDiskSizes();
      this.getKeyboardTypes();
      this.getDestinations();
    },

    methods: {
      cancelItem() {
        this.$router.go(-1)
      },

      async submit() {
        this.showLoading()

        let response = null;

        if (this.edit) {
          console.log("++++")
          await this.$http.put(`/lots/${this.lotId}/lot_items`, {lot_item: this.lot_item})
          .then((result) => {
            response = result;
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post(`/lots/${this.lotId}/lot_items`, {lot_item: this.lot_item})
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
          this.$router.push(`/lots/${this.lotId}`)

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

      async getHardwareTypes() {
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
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getManufacturers() {
        let response = null;
        await this.$http.get('/manufacturers')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.manufacturers = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getModels() {
        this.models = [];

        let response = null;
        await this.$http.get(`/models/by-manufacturer/${this.manufacturerId}`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.models = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getCategories() {
        let response = null;
        await this.$http.get('/categories')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.categories = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },


      async getDamageTypes() {
        let response = null;
        await this.$http.get(`/damage_types/by-hardware-type/${this.lot_item.hardware_type_id}`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.damageTypes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },


      async getProcessors() {
        let response = null;
        await this.$http.get('/processors')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.processors = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },


      async getDiskTypes() {
        let response = null;
        await this.$http.get('/disk_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.diskTypes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getDiskSizes() {
        let response = null;
        await this.$http.get('/disk_sizes')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.diskSizes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getKeyboardTypes() {
        let response = null;
        await this.$http.get('/keyboard_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.keyboardTypes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getDestinations() {
        let response = null;
        await this.$http.get('/destinations')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.destinations = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
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
