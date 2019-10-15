<template>
  <div id="app">
    <v-toolbar dark>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" v-if="pwa"></v-app-bar-nav-icon>

      <v-toolbar-title> Panilhamento </v-toolbar-title>

      <div class="flex-grow-1"></div>

      <v-toolbar-items v-if="!pwa">

        <v-menu offset-y>
          <template v-slot:activator="{ on }">
            <v-btn v-on="on" text>
              Registrar
            </v-btn>
          </template>
          <v-list>

            <v-list-item v-if="isAdmin" to="/users" >
              <v-list-item-title> Usuários </v-list-item-title>
            </v-list-item>

            <v-list-item to="/customers" >
              <v-list-item-title> Clientes </v-list-item-title>
            </v-list-item>

          </v-list>
        </v-menu>

        <v-btn text to="/constructions"> Obras </v-btn>

        <v-btn text @click="signOut()"> Sair </v-btn>
      </v-toolbar-items>

    </v-toolbar>

    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
      dark
    >
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title> PLANILHAMENTO </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <v-list dense>

        <v-list-item>
          <v-list-item-content>
            <v-list-item-title> link 1 </v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item>
          <v-list-item-content>
            <v-list-item-title> link 2 </v-list-item-title>
          </v-list-item-content>
        </v-list-item>

      </v-list>
    </v-navigation-drawer>

  </div>
</template>

<script>
  export default {

    data() {
      return {
        drawer: null,
        window: {
          width: 0,
          height: 0
        },
        pwa: false,
        isAdmin: false
      }
    },

    created() {
      window.addEventListener('resize', this.handleResize)
      this.handleResize();
    },

    destroyed() {
      window.removeEventListener('resize', this.handleResize)
    },

    mounted() {
      this.getCurrentUser()
    },

    methods: {
      handleResize() {
        this.window.width = window.innerWidth;
        this.window.height = window.innerHeight;

        if( this.window.width <= 785 ) {
          this.pwa = true;
        } else {
          this.pwa = false;
        }
      },

      async getCurrentUser () {
        let response = null;

        await this.$http.get(`/get_user`)
        .then((result) => {
          response = result

        }).catch((err) => {
          response = err
        });

        if ( response.body.role == 'Administrador' ) {
          this.isAdmin = true
        }
      },

      async signOut () {
        let response = null
        await this.$http.delete("/users/sign_out")
        .then(result => {
          response = result
        })
        .catch(err => {});

        if ( response.status == 200 ) {
          window.location.href = "/";
        }
      }

    }
  }
</script>