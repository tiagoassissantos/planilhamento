
import Vue from 'vue'
import "babel-polyfill"

//plugins
import vuetify from './plugins/vuetify'
import VueRouter from 'vue-router';
import VueResource from "vue-resource/dist/vue-resource";
import Vuelidate from 'vuelidate';

//store functions
import store from './store/principal';

//Components
import App from '../components/externalPages/main.vue';
import sign_in from '../components/externalPages/sign_in.vue'


Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(Vuelidate)

const router = new VueRouter({
  routes: [
    {
      path: "/",
      component: sign_in,
      props: true
    }
  ]
})

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  const app = new Vue({
    render: h => h(App),
    router,
    el: 'app',
    template: '<App/>',
    components: { App },
    vuetify,
    store,
  }).$mount('#app')
})

