<template>
  <div id="app">

    <div class='row'>
      <div class="col-md-8 col-sm-12">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click="input = null">Limpar pesquisa</button>
          </div>
        </div>
      </div>
    </div>

    <div class="margin-alert">
      <b-alert show dismissible v-if="showAlert" :variant="messageClass">
        {{ message }}
      </b-alert>
    </div>

    <div class="table-scroll">
      <b-pagination
        v-model="currentPage"
        :total-rows="rows"
        :per-page="perPage"
        aria-controls="my-table"
        align="fill"
      > </b-pagination>

      <b-table
        id="my-table"
        :items="skus"
        :per-page="perPage"
        :current-page="currentPage"
        small
        striped
        hover
      >

        <template slot="code" slot-scope="data">
          {{ data.item.code }}
        </template>

        <template slot="hardware_type" slot-scope="data">
          {{ data.item.hardware_type }}
        </template>

        <template slot="manufacturer" slot-scope="data">
          {{ data.item.manufacturer }}
        </template>

        <template slot="model" slot-scope="data">
          {{ data.item.model }}
        </template>

        <template slot="ram_memory" slot-scope="data">
          {{ data.item.model }}
        </template>

        <template slot="damages" slot-scope="data">
          <span class='badge badge-primary' v-for="(damage, index) in data.item.damages" :key="index">
            {{ damage }}
          </span>
        </template>

        <template slot="ram_memory" slot-scope="data">
          {{ data.item.ram_memory }}
        </template>

        <template slot="processor" slot-scope="data">
          {{ data.item.processor }}
        </template>

        <template slot="disk_size" slot-scope="data">
          {{ data.item.disk_size }}
        </template>

        <template slot="disk_type" slot-scope="data">
          {{ data.item.disk_type }}
        </template>

        <template slot="webcam" slot-scope="data">
          {{ data.item.webcam }}
        </template>

        <template slot="keyboard_type" slot-scope="data">
          {{ data.item.keyboard_type }}
        </template>

        <template slot="bluetooth" slot-scope="data">
          {{ data.item.bluetooth }}
        </template>

        <template slot="bright_keyboard" slot-scope="data">
          {{ data.item.bright_keyboard }}
        </template>

        <template slot="biometric_reader" slot-scope="data">
          {{ data.item.biometric_reader }}
        </template>

        <template slot="vga_card" slot-scope="data">
          {{ data.item.vga_card }}
        </template>

        <template slot="color" slot-scope="data">
          {{ data.item.color }}
        </template>

        <template slot="archive" slot-scope="data">
          {{ data.item.archive }}
        </template>
      </b-table>

      <!-- <table class="table table-hover table-bordered font-small">
        <thead>
          <tr>
            <th scope="col"> SKU </th>
            <th scope="col"> Tipo de Hardware </th>
            <th scope="col"> Fabricante </th>
            <th scope="col"> Modelo </th>
            <th scope="col"> Mem. RAM </th>
            <th scope="col"> Categoria </th>
            <th scope="col"> Avarias </th>
            <th scope="col"> Processador </th>
            <th scope="col"> Armazenamento </th>
            <th scope="col"> Tipo Armazenamento </th>
            <th scope="col"> Webcam </th>
            <th scope="col"> Teclado </th>
            <th scope="col"> Bluetooth </th>
            <th scope="col"> Teclado Luminoso </th>
            <th scope="col"> Leitor Biométrico </th>
            <th scope="col"> Placa Vídeo </th>
            <th scope="col"> Cor </th>
            <th scope="col"> Arquivo </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for='(sku, index) in maxSkus' :key="index">
            <td> {{ sku.code }} </td>
            <td> {{ sku.hardware_type }} </td>
            <td> {{ sku.manufacturer }} </td>
            <td> {{ sku.model }} </td>

            <td>
              <span v-if="sku.ram_memory != null"> {{ sku.ram_memory }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.category != null"> {{ sku.category }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span class='badge badge-primary' v-if="sku.category != null" v-for="damage in sku.damages">
                {{ damage }}
              </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.processor != null"> {{ sku.processor }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.disk_size != null"> {{ sku.disk_size }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.disk_type != null"> {{ sku.disk_type }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.webcam != null">{{ sku.webcam }}</span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.keyboard_type != null"> {{ sku.keyboard_type }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.bluetooth != null">{{ sku.bluetooth }} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.bright_keyboard != null">{{sku.bright_keyboard}} </span>
              <span v-else> </span>
            </td>

            <td>
              <span v-if="sku.biometric_reader != null">{{ sku.biometric_reader }} </span>
              <span v-else> </span>
            </td>

            <td> {{ sku.vga_card }} </td>

            <td>
              <span v-if="sku.color != null">{{ sku.color }} </span>
              <span v-else> </span>
            </td>

            <td>
              <router-link :to="{ path:`/skus/${sku.id}/archive`}" class="btn btn-success" v-if="sku.archive == 'false'">
                Upload
              </router-link>
              <a :href="sku.archive" target="_blank" class="btn btn-info" v-if="sku.archive != 'false'">
                Download
              </a>
              <span target="_blank" class="btn btn-danger" v-if="sku.archive != 'false'" @click="deleteArchive(sku.id)">
                Excluir
              </span>
            </td>
          </tr>
        </tbody>
      </table> -->
    </div>

  </div>
</template>

<script>
  export default {
    components: { },

    data() {
      return {
        skus: [],
        maxSkus: [],
        showAlert: false,
        message: '',
        messageClass: '',
        input: null,
        way: '',
        pageNumber: 0,


        perPage: 5,
        currentPage: 1,
        items: [
          { id: 1, first_name: 'Fred', last_name: 'Flintstone' },
          { id: 2, first_name: 'Wilma', last_name: 'Flintstone' },
          { id: 3, first_name: 'Barney', last_name: 'Rubble' },
          { id: 4, first_name: 'Betty', last_name: 'Rubble' },
          { id: 5, first_name: 'Pebbles', last_name: 'Flintstone' },
          { id: 6, first_name: 'Bamm Bamm', last_name: 'Rubble' },
          { id: 7, first_name: 'The Great', last_name: 'Gazzoo' },
          { id: 8, first_name: 'Rockhead', last_name: 'Slate' },
          { id: 9, first_name: 'Pearl', last_name: 'Slaghoople' }
        ]

      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      },
      rows() {
        return this.items.length
      }
    },

    mounted() {
      this.getSkus();
    },

    methods: {
      async getSkus() {
        let response = null;
        await this.$http.get('/skus')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.skus = response.body;
        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
        this.loading = false
      },

      regExp( sku ) {
        var id = sku.id.toString()
        var code = sku.code.toLowerCase()
        var h_type = sku.hardware_type.toLowerCase()
        var model = sku.model.toLowerCase()
        var ram_memory = ''
        if (sku.ram_memory != null ) {
          ram_memory = sku.ram_memory.toLowerCase()
        }
        var category = ''
        if (sku.category != null ) {
          category = sku.category.toLowerCase()
        }
        var damageType = ''
        if (sku.category != null ) {
          category = sku.category.toLowerCase()
        }
        var processor = ''
        if (sku.processor != null ) {
          processor = sku.processor.toLowerCase()
        }
        var disk_size = ''
        if (sku.disk_size != null ) {
          disk_size = sku.disk_size.toLowerCase()
        }
        var keyboard_type = ''
        if (sku.keyboard_type != null ) {
          keyboard_type = sku.keyboard_type.toLowerCase()
        }
        var color = ''
        if (sku.color != null ) {
          color = sku.color.toLowerCase()
        }

        if( this.input === null){
          return true
        }else{
          this.input = this.input
          if(
              id.match(this.input.toLowerCase())            ||
              h_type.match(this.input.toLowerCase())        ||
              code.match(this.input.toLowerCase())          ||
              model.match(this.input.toLowerCase())         ||
              ram_memory.match(this.input.toLowerCase())    ||
              category.match(this.input.toLowerCase())      ||
              processor.match(this.input.toLowerCase())     ||
              disk_size.match(this.input.toLowerCase())     ||
              keyboard_type.match(this.input.toLowerCase()) ||
              color.match(this.input.toLowerCase())
            ){
            return true
          }else{
            return false
          }
        }
      },

      async deleteArchive( sku_id ) {
        let response = null

        this.$http.delete(`/skus/${sku_id}/delete_archive`)
        .then((result) => {
          response = result
          this.skus = []
          this.getSkus()
        }).catch((err) => {
          response = err
        });
      },
    }
  };
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

  .font-small {
    font-size: 12px
  }
</style>
