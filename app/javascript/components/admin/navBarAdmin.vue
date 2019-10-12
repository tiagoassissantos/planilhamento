<template>
  <div id="app">
    <v-toolbar dark>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" v-if="pwa"></v-app-bar-nav-icon>

      <v-toolbar-title> Panilhamento </v-toolbar-title>

      <div class="flex-grow-1"></div>

      <v-toolbar-items v-if="!pwa">
        <v-btn to="/users" text> Usuários </v-btn>
        <v-btn text>Link 2</v-btn>
        <v-btn text>Link 3</v-btn>
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
        dropdown_font: ['Arial', 'Calibri', 'Courier', 'Verdana'],

      }
    },

    created() {
      window.addEventListener('resize', this.handleResize)
      this.handleResize();
    },

    destroyed() {
      window.removeEventListener('resize', this.handleResize)
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
    }

  }
</script>