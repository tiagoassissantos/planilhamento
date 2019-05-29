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

import UsersList from '../components/registrations/Users/UsersList.vue'
import UsersNew from '../components/registrations/Users/UsersNew.vue'

import HardwareTypeList from '../components/registrations/HardwareTypes/HardwareTypeList.vue'
import HardwareTypeNew from '../components/registrations/HardwareTypes/HardwareTypeNew.vue'

import ManufacturerList from '../components/registrations/Manufacturers/ManufacturerList.vue'
import ManufacturerNew from '../components/registrations/Manufacturers/ManufacturerNew.vue'

import ModelsList from '../components/registrations/Models/ModelList.vue'
import ModelNew from '../components/registrations/Models/ModelNew.vue'

import CategoriesList from '../components/registrations/Categories/CategoriesList.vue'
import CategoryNew from '../components/registrations/Categories/CategoriesNew.vue'

import DamageTypesList from '../components/registrations/DamageTypes/DamageTypesList.vue'
import DamageTypeNew from '../components/registrations/DamageTypes/DamageTypesNew.vue'

import ProcessorsList from '../components/registrations/Processors/ProcessorsList.vue'
import ProcessorsNew from '../components/registrations/Processors/ProcessorsNew.vue'

import KeyboardTypesList from '../components/registrations/KeyboardTypes/KeyboardTypesList.vue'
import KeyboardTypesNew from '../components/registrations/KeyboardTypes/KeyboardTypesNew.vue'

import DestinationsList from '../components/registrations/Destinations/DestinationsList.vue'
import DestinationsNew from '../components/registrations/Destinations/DestinationsNew.vue'

import DiskTypesList from '../components/registrations/DiskTypes/DiskTypesList.vue'
import DiskTypesNew from '../components/registrations/DiskTypes/DiskTypesNew.vue'

import DiskSizesList from '../components/registrations/DiskSizes/DiskSizesList.vue'
import DiskSizesNew from '../components/registrations/DiskSizes/DiskSizesNew.vue'

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

    { path: "/users", component: UsersList, props: true },
    { path: "/users/new", component: UsersNew, props: true },
    { path: "/users/:user_id", component: UsersNew, props: true, name: 'user' },

    { path: "/hardware-types", component: HardwareTypeList, props: true },
    { path: "/hardware-types/new", component: HardwareTypeNew, props: true },
    { path: "/hardware-types/:hardware_id", component: HardwareTypeNew, props: true, name: 'hardware-type' },

    { path: "/manufacturers", component: ManufacturerList, props: true },
    { path: "/manufacturers/new", component: ManufacturerNew, props: true },
    { path: "/manufacturers/:manufacturer_id", component: ManufacturerNew, props: true, name: 'manufacturer' },

    { path: "/models", component: ModelsList, props: true },
    { path: "/models/new", component: ModelNew, props: true },
    { path: "/models/:model_id", component: ModelNew, props: true, name: 'model' },

    { path: "/categories", component: CategoriesList, props: true },
    { path: "/categories/new", component: CategoryNew, props: true },
    { path: "/categories/:category_id", component: CategoryNew, props: true, name: 'category' },

    { path: "/damage-types", component: DamageTypesList, props: true },
    { path: "/damage-types/new", component: DamageTypeNew, props: true },
    { path: "/damage-types/:damage_id", component: DamageTypeNew, props: true, name: 'damage' },

    { path: "/processors", component: ProcessorsList, props: true },
    { path: "/processors/new", component: ProcessorsNew, props: true },
    { path: "/processors/:processor_id", component: ProcessorsNew, props: true, name: 'processor' },

    { path: "/keyboard-types", component: KeyboardTypesList, props: true },
    { path: "/keyboard-types/new", component: KeyboardTypesNew, props: true },
    { path: "/keyboard-types/:keyboard_type_id", component: KeyboardTypesNew, props: true, name: 'keyboard_type' },

    { path: "/destinations", component: DestinationsList, props: true },
    { path: "/destinations/new", component: DestinationsNew, props: true },
    { path: "/destinations/:destination_id", component: DestinationsNew, props: true, name: 'destination' },

    { path: "/disk-types", component: DiskTypesList, props: true },
    { path: "/disk-types/new", component: DiskTypesNew, props: true },
    { path: "/disk-types/:disk_type_id", component: DiskTypesNew, props: true, name: 'disk_type' },

    { path: "/disk-sizes", component: DiskSizesList, props: true },
    { path: "/disk-sizes/new", component: DiskSizesNew, props: true },
    { path: "/disk-sizes/:disk_size_id", component: DiskSizesNew, props: true, name: 'disk_size' },
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
