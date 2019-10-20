<template>
  <div id="app">
    <v-container>

      <v-card class="mx-auto">
        <v-card-title class='grey py-1'>
          <v-row>
            <v-col cols="10">
              <span class="display-1 mb-1">Cadastrar Formato</span>
            </v-col>
            <v-col cols="2">
              <v-btn class="float-right" color="primary" large to="/formats"> Voltar </v-btn>
            </v-col>
          </v-row>
        </v-card-title>

        <v-card-text>
          <v-text-field
            v-model="format.name"
            label="Nome"
            required
            type="text"
          ></v-text-field>

          <v-text-field
            v-model="format.sides"
            label="Lados"
            required
          ></v-text-field>

          <v-file-input ref="format_image" label="Imagem do Formato"></v-file-input>

          <v-btn class="mr-4 mt-5 full-width" @click="validateSubmit" color="primary" > {{button_text}} </v-btn>
        </v-card-text>
      </v-card>

    </v-container>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        format: {},
        alert: false,
        button_text: 'Salvar',
        edit: false
      }
    },

    mounted() {
      
    },

    methods: {
      validateSubmit() {
        this.submit()
      },

      async submit() {
        let response = null

        let formData = new FormData()
        formData.append("format", JSON.stringify(this.format))
        formData.append("format_image", this.$refs.format_image.$refs.input.files[0])

        if ( this.edit ) {
          await this.$http.put(`/formats/${this.format_id}`, formData ,
            { headers: {
            'Content-Type': 'multipart/form-data'
            } }
          )
          .then((result) => {
            response = result
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post('/formats', formData,
            { headers: {
            'Content-Type': 'multipart/form-data'
            } }
          )
          .then((result) => {
            response = result
          }).catch((err) => {
            response = err
          });
        }


        if ( response.status == 200 ) {
          this.$router.push("/formats")
        }
      }
    }
  }
</script>

<style scoped>

  .margin-top {
    margin-top: 50px;
  }
</style>
