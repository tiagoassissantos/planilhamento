<template>
  <div class='container'>
    <div class="card response-display">
      <div class="card-header">
        Manutenção de Item
      </div>

      <div class="card-body">
        <form @submit.prevent="submit">
          <div class="mb-3"> Detalhes do Produto </div>
          <div class="table-scroll">
            <table class="table table-hover table-bordered">
              <thead>
                <tr>
                  <th scope="col">Produto</th>
                  <th scope="col">Num. Série</th>
                  <th scope="col">SKU</th>
                  <th scope="col">Categoria</th>
                </tr>
              </thead>
              <tbody>
                <td>
                  <span v-if="lot_item.hardware_type != null" >
                    {{ lot_item.hardware_type }}
                  </span>
                  <span v-else> </span>
                </td>

                <td>
                  <span v-if="lot_item.serial_number != null" >
                    {{ lot_item.serial_number }}
                  </span>
                  <span v-else> </span>
                </td>

                <td>
                  <span v-if="lot_item.sku_id != null" >
                    {{ lot_item.sku_id }}
                  </span>
                  <span v-else> </span>
                </td>

                <td>
                  <span v-if="lot_item.category != null" >
                    {{ lot_item.category }}
                  </span>
                  <span v-else> </span>
                </td>
              </tbody>
            </table>
          </div><br>

          <label> Local / Tipos de Avaria </label>
          <multiselect
            v-model="value"
            :options="damageTypes"
            :multiple="true"
            :close-on-select="false"
            :clear-on-select="false"
            :preserve-search="true"
            placeholder="Remova as avarias"
            label="name"
            track-by="name"
            :preselect-first="true"
          >
          </multiselect><br>

          <div class="row mt-6">
            <div class="col-sm-6">
              <div class="form-group">
                <label>Destino Atual</label>
                <input type="text" class="form-control" v-model='lot_item.destination' readonly />
              </div>
            </div>

            <div class="col-sm-6">
              <label> Novo Destino </label>
              <select
                class="form-control"
                name="destinations"
                type="text"
                v-model='new_destination'
              >
                <option value="null" > Selecione o novo destino </option>
                <option v-for='(destination, index) in destinations' :key="index" :value='destination.id' >
                  {{destination.name}}
                </option>
              </select>
            </div>
          </div>

          <button class="full-width btn btn-success space-top"> Salvar Alterações </button>
        </form>

        <b-modal v-model="showModal" v-if="showModal" hide-footer> <!-- modal -->
          <center>
            <img  class="size-img-modal" src="../../../assets/images/checked.png"/>
          </center>
          <p class="my-1"> {{ messageModal }} </p>
        </b-modal>
      </div> <!-- card body -->
    </div> <!-- card -->
  </div> <!-- app -->
</template>

<script>
  import Multiselect from 'vue-multiselect'

  export default {
    components: { Multiselect },

    data() {
      return {
        value: [],
        lot_item: {
          hardware_type_id: 0,
          model_id: 0,
          ram_memory: null,
          serial_number: null,
          asset_tag: null,
          category_id: null,
          comments: null,
          processor_id: null,
          disk_size_id: null,
          disk_type_id: null,
          parent_id: null,
          screen: null,
          webcam: null,
          keyboard_type_id: null,
          wireless: null,
          bluetooth: null,
          mini_display_port: null,
          hdmi: null,
          vga: null,
          esata: null,
          bright_keyboard: null,
          destination_id: null,
          bar_code: null,
          vga_card: null,
          biometric_reader: null
        },

        lot_item_id: null,
        damageTypes: [],
        destinations: [],
        new_destination: null,

        showModal: false,
        messageModal: '',
      }
    },

    computed: { },

    mounted() {
      this.lot_item_id = this.$route.params.lot_item_id
      this.getlot_item()
      this.getDestinations();
    },

    methods: {

      async getlot_item () {
        let response = null

        await this.$http.get(`/lot_items/${this.lot_item_id}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if (response.status == 200 ) {
          this.lot_item = response.body
          this.value = this.lot_item.damage_types
        }
      },

      async getDestinations() {
        let response = null;
        await this.$http.get('/destinations')
          .then((resp) => {
            response = resp;
            this.messageModal = "Item Editado com sucesso."
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.destinations = response.body;
        }
      },

      async submit() {
        let response = null
        let damages_id = []

        this.value.forEach( damage => {
          damages_id.push(damage.id)
        });

        if( this.new_destination !== null) {
          this.lot_item.destination_id = this.new_destination
        }

        await this.$http.put(`/lot_items/${this.lot_item_id}`,
        JSON.stringify({
                        lot_item_id: this.lot_item_id,
                        damage_types_id: damages_id,
                        destination_id: this.lot_item.destination_id
                      }))
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.showModal = true
          setTimeout(function(){
            this.showModal = false
            this.$router.push('/maintenance/search-items')
          }.bind(this), 2000);
        }
      }

    }
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }

  .is-danger {
    border-color: red !important;
  }

  .button-margin-top {
    margin-top: 30px;
  }

  .full-width {
    width: 100%
  }

  .error-text {
    color: red;
  }

  .style-select {
    cursor: pointer;
  }

  .active {
    background-color: rgba(172, 238, 178, 0.959);
  }

  .space-bottom {
    margin-bottom: 20px !important;
  }

  .space-top {
    margin-top: 30px !important;
  }
</style>
