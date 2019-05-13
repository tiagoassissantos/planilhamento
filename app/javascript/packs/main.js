import "babel-polyfill";
import Vue from 'vue/dist/vue'
import VueResource from "vue-resource/dist/vue-resource";
import VueRouter from 'vue-router'

//css
import 'bootstrap/dist/css/bootstrap.css';
//import '../../../app/javascript/assets/stylesheets/standarts.scss'


import { library } from '@fortawesome/fontawesome-svg-core'
import { faEnvelope, faKey, faUser } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
library.add(faEnvelope, faKey, faUser)
Vue.component('font-awesome-icon', FontAwesomeIcon)

//pages
import App from '../pages/main'
import sign_in from '../components/sign_in'
import dashboard from '../pages/dashboard'
//import register from '../components/landing_pages/registerUser.vue'
//import forgot_password from '../components/landing_pages/forgot_password.vue'

Vue.use(VueRouter)
Vue.use(VueResource)

const router = new VueRouter({
  routes: [
    {
      path: "/",
      component: sign_in,
      props: true
    },
    {
      path: "/dashboard",
      component: dashboard,
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
    store
  })

  console.log(app)
})
