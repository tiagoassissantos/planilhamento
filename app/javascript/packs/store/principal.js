import Vue from 'vue/dist/vue';
import Vuex from 'vuex';
import VueResource from "vue-resource/dist/vue-resource";

Vue.use(Vuex);
Vue.use(VueResource);

//styles
import '../../styles/global.scss'


export default new Vuex.Store({
  state: {
    logged: false,
    currentUser: {},
    landing: true
  },

  actions: {
    isLogged: async ({ commit }) => {
      const logged = (await Vue.http.get("/logged")).body
      commit('SET_LOGGED', logged)
    },

    //setCurrentUser: async ({ commit }) => {
    //  const user = (await Vue.http.get("/current_user")).body
    //  commit('SET_CURRENT_USER', user)
    //}
  },

  mutations: {
    SET_LOGGED(store, obj) {
      store.logged = obj
    },

    SET_CURRENT_USER(store, obj) {
      store.currentUser = obj
    }
  }
})
