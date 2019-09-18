import "babel-polyfill";
import Vue from 'vue/dist/vue';
import VueResource from "vue-resource/dist/vue-resource";
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue';
import vuetify from './plugins/vuetify'


//css
import 'bootstrap/dist/css/bootstrap.css';
//import '../../../app/javascript/assets/stylesheets/standarts.scss'


import { library } from '@fortawesome/fontawesome-svg-core';
import { faEnvelope, faKey, faUser } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
library.add(faEnvelope, faKey, faUser);
Vue.component('font-awesome-icon', FontAwesomeIcon);

//pages
import App from '../pages/main';
import sign_in from '../pages/sign_in';
//import forgot_password from '../components/landing_pages/forgot_password.vue'

Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(BootstrapVue);

const router = new VueRouter({
  routes: [
    {
      path: "/",
      component: sign_in,
      props: true
    }
  ]
})

import store from './store/principal';

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  const app = new Vue({
    router,
    el: 'app',
    template: '<App/>',
    components: { App },
    store,
    vuetify
  })

  console.log(app)
})
