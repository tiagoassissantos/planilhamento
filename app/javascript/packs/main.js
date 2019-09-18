import Vue from 'vue'
import "babel-polyfill"

//plugins
import vuetify from './plugins/vuetify'
import VueRouter from 'vue-router';
import VueResource from "vue-resource/dist/vue-resource";
import BootstrapVue from 'bootstrap-vue';
import { library } from '@fortawesome/fontawesome-svg-core';
import { faEnvelope, faKey, faUser } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import Vuelidate from 'vuelidate';

//store functions
import store from './store/principal';

//Components
import App from '../pages/main';
import sign_in from '../pages/sign_in'

//css
import 'bootstrap/dist/css/bootstrap.css';

//icons
library.add(faEnvelope, faKey, faUser);
Vue.component('font-awesome-icon', FontAwesomeIcon);



Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(BootstrapVue);
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
