<template>
  <div id="app">

    <div class='row'>
      <div class="col-md-8 col-sm-12">
        <div class="input-group">
          <input type="text" class="form-control" aria-describedby="button-addon4" v-model="input">
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button" @click="filter()">Pesquisar</button>
            <button class="btn btn-danger" type="button" @click="clearFilter()">Limpar pesquisa</button>
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

      <b-table
        id="my-table"
        :fields="header"
        :items="maxSkus"
        :per-page="perPage"
        :current-page="currentPage"
        small
        striped
        hover
      >

        <template slot="SKU" slot-scope="data">
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
          {{ data.item.ram_memory }}
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
          <span @click="routerUpload(data.item.id)" class="btn btn-success width-btn" v-if="data.item.archive == 'false'"> Upload </span>

          <a :href="data.item.archive" target="_blank" class="btn btn-info width-btn" v-if="data.item.archive != 'false'">
            Download
          </a>
          <span target="_blank" class="btn btn-danger width-btn margin-button" v-if="data.item.archive != 'false'" @click="deleteArchive(data.item.id)">
            Excluir
          </span>
        </template>
      </b-table>

      <b-pagination
        v-model="currentPage"
        :total-rows="rows"
        :per-page="perPage"
        aria-controls="my-table"
        align="fill"
      > </b-pagination>

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
        perPage: 20,
        currentPage: 1,

        header: [
          {key: 'code', label: 'SKU'},
          {key: 'hardware_type', label: 'Hardware'},
          {key: 'manufacturer', label: 'Fabricante'},
          {key: 'model', label: 'Modelo'},
          {key: 'ram_memory', label: 'Memória Ram'},
          {key: 'damages', label: 'Avaria'},
          {key: 'category', label: 'Categoria'},
          {key: 'processor', label: 'Processador'},
          {key: 'disk_size', label: 'Tam. disco'},
          {key: 'disk_type', label: 'Tipo disco'},
          {key: 'webcam', label: 'Webcam'},
          {key: 'keyboard_type', label: 'Teclado'},
          {key: 'bluetooth', label: 'Bluetooth'},
          {key: 'bright_keyboard', label: 'Teclado Luminoso'},
          {key: 'biometric_reader', label: 'Leitor Biométrico'},
          {key: 'vga_card', label: 'Placa de vídeo'},
          {key: 'color', label: 'Cor'},
          {key: 'archive', label: 'Arquivo'}
        ]

      }
    },

    computed: {
      isLogged() {
        return this.$store.state.logged
      },
      rows() {
        return this.skus.length
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
          this.maxSkus = response.body
        } else {
          this.showAlert = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }
        this.loading = false
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

      routerUpload (sku_id) {
        this.$router.push(`/skus/${sku_id}/archive`)
      },

      async filter() {
        this.maxSkus = []
        let response = null

        if( this.input == '' || this.input == null ) {
          this.maxSkus = []
          this.getSkus();
          return
        }

        await this.$http.get(`/query_sku/${this.input}`)
        .then((result) => {
          response = result
        }).catch((err) => {
          response = err
        });

        if ( response.status == 200 ) {
          this.maxSkus = response.body
        }
      },

      clearFilter() {
        this.input = null
        this.maxSkus = []
        this.getSkus();
      }
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

  .width-btn {
    width: 100%;
  }

  .margin-button {
    margin-top: 5px;
  }
</style>
