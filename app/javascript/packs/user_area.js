import "babel-polyfill";
import Vue from 'vue/dist/vue';
import VueResource from "vue-resource/dist/vue-resource";
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue';
import Loading from 'vue-loading-overlay';

import 'bootstrap';

//css
import 'bootstrap/dist/css/bootstrap.css';
//import '../../../app/javascript/assets/stylesheets/standarts.scss'
import 'vue-loading-overlay/dist/vue-loading.css';


import { library } from '@fortawesome/fontawesome-svg-core';
import { faEnvelope, faKey, faUser, faHome, faLaptop, faList, faFolderOpen, faChartBar, faCopy, faColumns, faEdit } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
library.add(faEnvelope, faKey, faUser, faHome, faLaptop, faList, faFolderOpen, faChartBar, faCopy, faColumns, faEdit);
Vue.component('font-awesome-icon', FontAwesomeIcon);

//pages
import App from '../pages/UserArea';
import dashboard from '../pages/dashboard';
import ListLots from '../components/lots/List.vue';
import NewLot from '../components/lots/New.vue';
import NewLotItem from '../components/lots/NewItem.vue';
import ShowLot from '../components/lots/ShowLot.vue';

import HardwareTypeList from '../components/registrations/HardwareTypeList.vue'
import HardwareTypeNew from '../components/registrations/HardwareTypeNew.vue'

Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(BootstrapVue);
Vue.use(Loading);

const router = new VueRouter({
  routes: [
    { path: "/", component: dashboard, props: true },
    { path: "/lots", component: ListLots, props: true },
    { path: "/lots/new", component: NewLot, props: true },
    { path: "/lots/:lot_id/new-item", component: NewLotItem, props: true },
    { path: "/lots/:lot_id", component: ShowLot, props: true },
    { path: "/hardware-types", component: HardwareTypeList, props: true },
    { path: "/hardware-types/new", component: HardwareTypeNew, props: true }
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
