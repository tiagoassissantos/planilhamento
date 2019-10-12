
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
import App from '../components/admin/Admin';
import dashboardAdmin from '../components/admin/DashboardAdmin.vue'
import users from '../components/admin/users/UserList.vue'
import userNew from '../components/admin/users/UserNew.vue'

Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(Vuelidate)

const router = new VueRouter({
  routes: [
    { path: "/", component: dashboardAdmin, props: true },

    { path: "/users", component: users, props: true },
    { path: "/user/new", component: userNew, props: true },
    { path: "/user/:id", component: userNew, props: true, name: 'user_edit' },

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

