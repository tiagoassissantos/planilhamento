import Vue from 'vue'
import "babel-polyfill"

//plugins
import vuetify from './plugins/vuetify'
import VueRouter from 'vue-router';
import VueResource from "vue-resource/dist/vue-resource";
import Vuelidate from 'vuelidate';

//store functions
import store from './store/principal.js';

//Components
import App from '../components/userArea/UserArea.vue';
import dashboard from '../components/userArea/dashboard.vue'

import users from '../components/userArea/users/UserList.vue'
import userNew from '../components/userArea/users/UserNew.vue'

import customers from '../components/userArea/customer/CustomersList.vue'
import customerNew from '../components/userArea/customer/CustomersNew.vue'

import constructionsNew from '../components/userArea/constructions/ConstructionsNew.vue'
import constructionsShow from '../components/userArea/constructions/ConstructionsShow.vue'
import constructions from '../components/userArea/constructions/ConstructionsList.vue'

import formatsList from '../components/userArea/formats/List'
import formatNew from '../components/userArea/formats/New'

import logs from '../components/userArea/logs/LogsList'

Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(Vuelidate)

const router = new VueRouter({
  routes: [
    { path: "/", component: dashboard, props: true },

    { path: "/users", component: users, props: true },
    { path: "/user/new", component: userNew, props: true },
    { path: "/user/:id", component: userNew, props: true, name: 'user_edit' },

    { path: "/customers", component: customers, props: true },
    { path: "/customer/new", component: customerNew, props: true },
    { path: "/customer/:id", component: customerNew, props: true, name: 'customer_edit' },

    { path: "/constructions", component: constructions, props: true },
    { path: "/construction/new", component: constructionsNew, props: true },
    { path: "/construction/:id/edit", component: constructionsNew, props: true, name: 'construction_edit' },
    { path: "/construction/:id", component: constructionsShow, props: true, name: 'construction_show' },

    { path: "/formats", component: formatsList, props: true },
    { path: "/formats/new", component: formatNew, props: true },
    { path: "/formats/:id/edit", component: formatNew, name:'format_edit', props: true },

    { path: "/logs", component: logs, props: true },
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