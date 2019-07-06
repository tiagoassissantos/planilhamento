<template>
  <div class='container'>
    <div class="card response-display">
      <div class="card-header">
        <div class="row">
          <div class="col-sm-6">
            Novo Item
          </div>
        </div>
      </div>

      <div class="card-body"> <!-- =================== -->
        <div class="input-group">
          <vue-bootstrap-typeahead  class="width-complete" v-model="query"
          :data="skus" :serializer="s => s.code"  :minMatchingChars="0"
          placeholder="Insira o SKU"  @hit="selectedSku($event)"/>
          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
          </div>

          <div class="card">
            <div class="card-body">
              <div class="container">
                <!--form @submit.prevent="submit"-->

                  <div class="row">
                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">

                        <label>Tipo de Hardware</label>
                        <select
                          class="form-control"
                          type="text"
                          v-model='lot_item.hardware_type_id'
                          @change='getDamageTypes()'
                          v-validate.disabled="'required|min_value:1'"
                          name="h_type"
                          :class="{'input': true, 'is-danger': errors.has('h_type') }"
                        >
                          <option value='0'> Selecione um tipo de hardware </option>
                          <option value='x' @click="openModal(9)"> Cadastrar novo tipo </option>
                          <option
                            v-for='(hardwareType,index) in hardwareTypes'
                            :key="index"
                            :value='hardwareType.id'
                          >
                              {{hardwareType.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('h_type')"> {{ required_text }} </span>

                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Fabicante</label>
                        <select
                          class="form-control"
                          v-model='manufacturerId'
                          name="manufacturer"
                          @change='getModels()'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('manufacturer') }"
                        >
                          <option value="0"> Selecionar Fabricante </option>
                          <option value='x' @click="openModal(0)"> Cadastrar Novo </option>
                          <option v-for=' (manufacturer, index) in manufacturers' :key="index" :value='manufacturer.id'>
                            {{manufacturer.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('manufacturer')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Modelo</label>
                        <select
                          class="form-control"
                          name="models"
                          type="text"
                          v-model='lot_item.model_id'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('models') }"
                        >
                          <option value='0'> Selecione um Modelo</option>
                          <option value='x' @click="openModal(1)"> Cadastrar Modelo</option>
                          <option v-for='(model, index) in models' :key="index" :value='model.id'>
                            {{model.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('models')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showMemory'>
                      <div class="form-group">
                        <label>Memória RAM</label>
                        <input
                          type="text"
                          class="form-control"
                          v-model='lot_item.ram_memory'
                          name="ram_memory"
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('ram_memory') }"
                        />
                      <span class="error-text" v-show="errors.first('ram_memory')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Número de Série</label>
                        <input
                          type="text"
                          name="serial_number"
                          class="form-control"
                          v-model='lot_item.serial_number'
                          v-validate="'required'"
                          :class="{'input': true, 'is-danger': errors.has('serial_number') }"
                        />
                        <span class="error-text" v-show="errors.first('serial_number')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if="showNumberOfSerieandAssetTag">
                      <div class="form-group">
                        <label>Asset TAG</label>
                        <input
                          type="text"
                          name="asset_tag"
                          class="form-control"
                          v-model='lot_item.asset_tag'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('asset_tag') }"
                        />
                        <span class="error-text" v-show="errors.first('asset_tag')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showCategory'>
                      <div class="form-group">
                        <label>Categoria</label>
                        <select
                          class="form-control"
                          name="category"
                          type="text"
                          v-model='lot_item.category_id'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('category') }"
                        >
                          <option value='null'> Selecionar Categoria </option>
                          <option value='x' @click="openModal(4)"> Cadastrar novo </option>
                          <option v-for='(category, index) in categories' :key="index" :value='category.id'>
                            {{category.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('category')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Comentários</label>
                        <input
                          type="text"
                          name="coments"
                          class="form-control"
                          v-model='lot_item.comments'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('coments') }"
                        />
                        <span class="error-text" v-show="errors.first('coments')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-if="showDamageType">
                      <div class="form-group">
                        <label>Local / Tipo Avaria</label>
                        <select
                          class="form-control"
                          name="damge_type"
                          type="text"
                          v-model='lot_item.damage_type_id'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('damge_type') }"
                        >
                          <option value='null'> Selecionar o Tipo de Avaria </option>
                          <option value='x' @click="openModal(2)"> Cadastrar novo </option>
                          <option v-for='(damageType, index) in damageTypes' :key="index" :value='damageType.id'>
                            {{ damageType.name }}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('damge_type')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showProcessor'>
                      <div class="form-group">
                        <label>Processador</label>
                        <select
                          class="form-control"
                          name="processor"
                          type="text"
                          v-model='lot_item.processor_id'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('processor') }"
                        >
                          <option value='null'> Selecione o processador </option>
                          <option value='x' @click="openModal(5)"> Cadastre novo</option>
                          <option v-for='(processor, index) in processors' :key="index" :value='processor.id'>
                            {{processor.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('processor')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showDiskFields'>
                      <div class="form-group">
                        <label>Tamanho do HD</label>
                        <select
                          class="form-control"
                          name="disk_size"
                          type="text"
                          v-model='lot_item.disk_size_id'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('disk_size') }"
                        >
                          <option value='null' @click="openModal(7)"> Selecione o Tamanho do HD </option>
                          <option value='x' @click="openModal(7)">Cadastrar Novo</option>
                          <option v-for='(diskSize, index) in diskSizes' :key="index" :value='diskSize.id'>
                            {{diskSize.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('disk_size')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showDiskFields'>
                      <div class="form-group">
                        <label>Tipo</label>
                        <select
                          class="form-control"
                          name="disk_type"
                          type="text"
                          v-model='lot_item.disk_type_id'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('disk_type') }"
                        >
                          <option value='null'>Selecione Tipo de HD </option>
                          <option value='x' @click="openModal(8)"> Cadastre Novo</option>
                          <option v-for='(diskType, index) in diskTypes' :key="index" :value='diskType.id'>
                            {{diskType.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('disk_type')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showDiskFields'>
                      <div class="form-group">
                        <label>Parent (ID)</label>
                        <input
                          type="text"
                          name="parent_id"
                          class="form-control"
                          v-model='lot_item.parent_id' v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('parent_id') }" />
                        <span class="error-text" v-show="errors.first('parent_id')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showScreen'>
                      <div class="form-group">
                        <label>Tela (Polegadas)</label>
                        <input
                          type="text"
                          name="screen"
                          class="form-control"
                          v-model='lot_item.screen'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('screen') }"/>
                        <span class="error-text" v-show="errors.first('screen')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showWebcam'>
                      <div class="form-group">
                        <label>Webcam</label>
                        <select
                          class="form-control"
                          name="webcam"
                          v-model='lot_item.webcam'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('webcam') }" >
                          <option value="null" selected>Selecione</option>
                          <option value="12">Sim</option>
                          <option value="13">Não</option>
                        </select>
                        <span class="error-text" v-show="errors.first('webcam')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showKeyboardType'>
                      <div class="form-group">
                        <label>Tipo Teclado</label>
                        <select
                          class="form-control"
                          name="keyboard-type"
                          type="text"
                          v-model='lot_item.keyboard_type_id'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('keyboard-type') }"
                        >
                          <option value='null'> Selecione Novo Tipo de Teclado </option>
                          <option value='x' @click="openModal(6)"> Cadastre Novo</option>
                          <option v-for='(keyboardType, index) in keyboardTypes' :key="index" :value='keyboardType.id'>
                            {{keyboardType.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('keyboard-type')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showWireless'>
                      <div class="form-group">
                        <label>Wireless</label>
                        <select
                          class="form-control"
                          name="wireless"
                          v-model='lot_item.wireless'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('wireless') }"
                        >
                          <option value="null" selected>Selecione</option>
                          <option value="12">Sim</option>
                          <option value="13">Não</option>
                        </select>
                        <span class="error-text" v-show="errors.first('wireless')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showBluetooth'>
                      <div class="form-group">
                        <label>Bluetooth</label>
                        <select
                          class="form-control"
                          name="bluetooth"
                          v-model='lot_item.bluetooth'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('bluetooth') }">
                          <option value="null" selected> Selecione </option>
                          <option value="1">Sim</option>
                          <option value="0">Não</option>
                        </select>

                        <span class="error-text" v-show="errors.first('bluetooth')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3"  v-show='showMiniDisplayPort'>
                      <div class="form-group">
                        <label>Mini Display Port</label>
                        <select
                          class="form-control"
                          name="mini-display"
                          v-model='lot_item.mini_display_port'
                          v-validate.disabled="'required|min_value:12'"
                          :class="{'input': true, 'is-danger': errors.has('mini-display') }"
                        >
                          <option value="null" selected>Selecione</option>
                          <option value="12">Sim</option>
                          <option value="13">Não</option>
                        </select>

                        <span class="error-text" v-show="errors.first('mini-display')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showHdmihVgaEsata'>
                      <div class="form-group">
                        <label>HDMI</label>
                        <select
                          class="form-control"
                          name="hdmi"
                          v-model='lot_item.hdmi'
                          v-validate.disabled="'required|min_value:12'"
                          :class="{'input': true, 'is-danger': errors.has('hdmi') }"
                        >
                          <option value="null"> Selecione </option>
                          <option value="12">Sim</option>
                          <option value="13">Não</option>
                        </select>
                        <span class="error-text" v-show="errors.first('hdmi')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showHdmihVgaEsata'>
                      <div class="form-group">
                        <label>VGA</label>
                        <select
                          class="form-control"
                          name="vga"
                          v-model='lot_item.vga'
                          v-validate.disabled="'required|min_value:12'"
                          :class="{'input': true, 'is-danger': errors.has('vga') }">
                          <option value="null" > Cadastre VGA</option>
                          <option value="12">Sim</option>
                          <option value="13">Não</option>
                        </select>
                        <span class="error-text" v-show="errors.first('vga')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showEsata'>
                      <div class="form-group">
                        <label>eSata</label>
                        <select
                          class="form-control"
                          name="esata"
                          v-model='lot_item.esata'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('esata') }" >
                          <option value="null" selected> Selecione </option>
                          <option value="1">Sim</option>
                          <option value="2">Não</option>
                        </select>
                        <span class="error-text" v-show="errors.first('esata')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showLuminousKeyboard'>
                      <div class="form-group">
                        <label>Teclado Luminoso</label>
                        <input
                          type="text"
                          name="birght_keyboard"
                          class="form-control"
                          v-model='lot_item.bright_keyboard'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('birght_keyboard') }"
                        />
                      </div>
                      <span class="error-text" v-show="errors.first('birght_keyboard')"> {{ required_text }} </span>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showBiometricReader'>
                      <div class="form-group">
                        <label>Leitor Biométrico</label>
                        <select
                          class="form-control"
                          name="biometric_reader"
                          v-model='lot_item.biometric_reader'
                          v-validate.disabled="'required'"
                          :class="{'input': true, 'is-danger': errors.has('biometric_reader') }">
                          <option value="null" selected> Selecione </option>
                          <option value="12"> Sim </option>
                          <option value="13"> Não </option>
                        </select>
                        <span class="error-text" v-show="errors.first('biometric_reader')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showVideoCard'>
                      <div class="form-group">
                        <label>Tipo Placa Vídeo</label>
                        <select
                          class="form-control"
                          name="vga-card"
                          v-model='lot_item.vga_card'
                          v-validate.disabled="'required|min_value:0'"
                          :class="{'input': true, 'is-danger': errors.has('vga-card') }"
                        >
                          <option value="null" >Selecione </option>
                          <option value="1">Integrada</option>
                          <option value="0">Dedicada</option>
                        </select>
                        <span class="error-text" v-show="errors.first('vga-card')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3">
                      <div class="form-group">
                        <label>Destino</label>
                        <select
                          class="form-control"
                          name="destinations"
                          type="text"
                          v-model='lot_item.destination_id'
                          v-validate.disabled="'required|min_value:1'"
                          :class="{'input': true, 'is-danger': errors.has('destinations') }"
                        >
                          <option value='null'> Selecione o Destino </option>
                          <option value='x' @click="openModal(3)"> Cadastre Novo </option>
                          <option v-for='(destination, index) in destinations'  :key="index" :value='destination.id'>
                            {{destination.name}}
                          </option>
                        </select>
                        <span class="error-text" v-show="errors.first('destinations')"> {{ required_text }} </span>
                      </div>
                    </div>

                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showBarCode'>
                      <div class="form-group">
                        <label>Código de Barras</label>
                        <input type="text" class="form-control" v-model='lot_item.bar_code'/>
                      </div>
                    </div>
                  </div> <!-- End Row -->

                  <div class="float-right">
                    <button class="btn btn-primary" type="button" @click='submit'>
                      Adicionar
                    </button>
                    <button class="btn btn-danger cancel-btn" type="button" v-on:click='cancelItem'>
                      Cancelar
                    </button>
                  </div>

                  <!-- modal Alert-->
                  <b-modal v-model="showModal" v-if="showModal" hide-footer>
                    <center>
                      <img  class="size-img-modal" src="../../../assets/images/checked.png"/>
                    </center>
                    <p class="my-1"> {{ messageModal }} </p>
                  </b-modal>

                  <!-- modal de componentes -->
                  <b-modal ref="my-modal" hide-footer title="Cadastre..." size="lg">
                    <div class="d-block text-center">
                      <new-manufacturer v-if="id_modal === 0" modal_params="Cadastre"></new-manufacturer>
                      <new-model v-if="id_modal === 1" modal_params="Cadastre" />
                      <new-damage-type v-if="id_modal === 2" modal_params="Cadastre"/>
                      <new-destinations v-if="id_modal === 3" modal_params="Cadastre"/>
                      <new-categories v-if="id_modal === 4" modal_params="Cadastre"/>
                      <new-processors v-if="id_modal === 5" modal_params="Cadastre"/>
                      <new-keyboard-types v-if="id_modal === 6" modal_params="Cadastre"/>
                      <disk-sizes v-if="id_modal === 7" modal_params="Cadastre"/>
                      <disk-types v-if="id_modal === 8" modal_params="Cadastre"/>
                      <new-hardware v-if="id_modal === 9" modal_params="Cadastre"/>
                    </div>
                    <b-button class="mt-3" variant="outline-danger" block @click="hideModal"> Fechar </b-button>
                  </b-modal>

                <!--/form-->
              </div> <!-- === FIM CONTAINER === -->
            </div>
          </div>

        </div>
      </div> <!-- ==================== -->
    </div>
  </div> <!-- app -->
</template>

<script>
  import VueBootstrapTypeahead from 'vue-bootstrap-typeahead'
  import newManufacturer from '../registrations/Manufacturers/ManufacturerNew.vue'
  import newModel from '../registrations/Models/ModelNew.vue'
  import newDamageType from '../registrations/DamageTypes/DamageTypesNew.vue'
  import newDestinations from '../registrations/Destinations/DestinationsNew.vue'
  import newCategories from '../registrations/Categories/CategoriesNew.vue'
  import newProcessors from '../registrations/Processors/ProcessorsNew.vue'
  import newKeyboardTypes from '../registrations/KeyboardTypes/KeyboardTypesNew.vue'
  import DiskSizes from '../registrations/DiskSizes/DiskSizesNew.vue'
  import DiskTypes from '../registrations/DiskTypes/DiskTypesNew.vue'
  import newHardware from '../registrations/HardwareTypes/HardwareTypeNew.vue'

  export default {
    components: {
      VueBootstrapTypeahead, newManufacturer, newModel, newDamageType, newDestinations, newCategories,
      newProcessors, newKeyboardTypes, DiskSizes, DiskTypes, newHardware
      },

    data() {
      return {
        lot_item: {
          hardware_type_id: 0,
          model_id: 0,
          ram_memory: null,
          serial_number: null,
          asset_tag: null,
          category_id: null,
          comments: null,
          damage_type_id: null,
          processor_id: null,
          disk_size_id: null,
          disk_type_id: null,
          parent_id: null,
          screen: null,
          webcam: null,
          keyboard_type_id: null,
          wireless: null,
          bluetooth: null,
          mini_display_port: null,
          hdmi: null,
          vga: null,
          esata: null,
          bright_keyboard: null,
          destination_id: null,
          bar_code: null,
          vga_card: null,
          biometric_reader: null
        },

        hardwareTypes: [],
        manufacturers: [],
        manufacturerId: 0,
        models: [],
        categories: [],
        damageTypes: [],
        processors: [],
        diskTypes: [],
        diskSizes: [],
        keyboardTypes: [],
        destinations: [],

        error: false,
        messageClass: '',
        message: '',

        header_text: '',
        button_text: '',

        query: null,
        skus: [],

        showModal: false,
        messageModal: '',

        id_modal: '',
        required_text: 'Este campo é obrigatório.',
        text_manufacturer: 'Selecione um Fabricante',
        text_model: 'Selecione um modelo',
        text_damage_type: 'Selecione o Tipo de Avaria',
        text_destination: 'Selecione o Destino',
        text_category: 'Selecione a Categoria',
        text_processors: 'Selecione o Processador',
        text_keyboard: 'Selecione o Tipo de Teclado',
        text_size_hd: 'Selecione o tamanho do hd',
        text_type_hd: 'Selecione o tipo de hd',
        text_h_type: 'Selecione o tipo de Hardware'
      }
    },


    computed: {
      isLogged() {
        return this.$store.state.logged
      },

      showDamageType() {
        if(
          this.lot_item.hardware_type_id == 8 ||
          this.lot_item.hardware_type_id == 9){
            return false
          } else {
            return true
          }
      },

      showNumberOfSerieandAssetTag() {
        if (this.lot_item.hardware_type_id == 3 ) {
          return false
        } else {
          return true
        }
      },

      showMemory() {
        if (this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showCategory() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showProcessor() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showDiskFields() {
        if (
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showScreen() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 3 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showWebcam() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showKeyboardType() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showWireless() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showBluetooth() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showMiniDisplayPort() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showHdmihVgaEsata() {
        if (
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 3 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showEsata() {
        if (
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showLuminousKeyboard() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showBiometricReader() {
        if (
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showVideoCard() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 10) {
          return true;
        }
        return false;
      },

      showBarCode() {
        if (
            this.lot_item.destination_id == null  ||
            this.lot_item.destination_id == 'x'   ||
            this.lot_item.destination_id == 4) {
          return false;
        }
        return true;
      }
    },

    mounted() {
      this.lotId = this.$route.params.lot_id;

      this.getHardwareTypes();
      this.getManufacturers();
      this.getCategories();
      this.getProcessors();
      this.getDiskTypes();
      this.getDiskSizes();
      this.getKeyboardTypes();
      this.getDestinations();
      this.getSkus();
    },

    methods: {

      doNothing() {
        console.log('---> doNothing')
      },

      cancelItem() {
        this.$router.go(-1)
      },

      async submit() {
        this.$validator.validate().then((result) => {});
        this.registrationOrEdit()
      },

      async registrationOrEdit() {
        let response = null;

        if (this.edit) {
          await this.$http.put(`/lots/${this.lotId}/lot_items`, {lot_item: this.lot_item})
          .then((result) => {
            this.messageModal = 'Item editado com sucesso'
            response = result;
          }).catch((err) => {
            response = err
          });

        } else {
          await this.$http.post(`/lots/${this.lotId}/lot_items`, {lot_item: this.lot_item})
            .then(resp => {
              this.messageModal = 'Item adicionado com sucesso.'
              response = resp;
            })
            .catch(resp => {
              response = resp;
            });
        }

        if (response.status == 200) {
          this.messageClass = "success";
          this.showModal = true
          setTimeout(function(){
            this.showModal = false
            this.$router.push(`/lots/${this.lotId}`)
          }.bind(this), 2000);
        } else {
          this.messageClass = "danger";
          this.error = true;
          this.message = response.body.message;
        }
      },

      showLoading() {
        this.loader = this.$loading.show({
          container: this.fullPage ? null : this.$refs.formContainer,
          canCancel: false,
          backgroundColor: '#000',
          opacity: 0.75
        });
      },

      async getHardwareTypes() {
        let response = null;
        await this.$http.get('/hardware_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.hardwareTypes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getManufacturers() {
        let response = null;
        await this.$http.get('/manufacturers')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.manufacturers = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getModels() {
        this.models = [];

        let response = null;
        await this.$http.get(`/models/by-manufacturer/${this.manufacturerId}`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.models = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getCategories() {
        let response = null;
        await this.$http.get('/categories')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.categories = response.body;
        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getDamageTypes() {
        let response = null;

        await this.$http.get(`/damage_types/by-hardware-type/${this.lot_item.hardware_type_id}`)
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.damageTypes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getProcessors() {
        let response = null;
        await this.$http.get('/processors')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.processors = response.body;
        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getDiskTypes() {
        let response = null;
        await this.$http.get('/disk_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.diskTypes = response.body;
        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getDiskSizes() {
        let response = null;
        await this.$http.get('/disk_sizes')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.diskSizes = response.body;

        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getKeyboardTypes() {
        let response = null;
        await this.$http.get('/keyboard_types')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.keyboardTypes = response.body;
        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      async getDestinations() {
        let response = null;
        await this.$http.get('/destinations')
          .then((resp) => {
            response = resp;
          })
          .catch((resp) => {
            response = resp;
          })

        if (response.status == 200) {
          this.destinations = response.body;
        } else {
          this.error = true
          this.messageClass = "danger"
          this.message = "Erro ao carregar os dados."
        }

        this.loading = false
      },

      getSkus() {
        this.$http.get(`/lots/${this.lotId}/get_all_skus`)
        .then((result) => {
          this.skus = result.body
        })
      },

      selectedSku( sku ) {
       this.$http.get(`/lots/${this.lotId}/get_sku/${sku.id}`)
       .then((result) => {
         this.lot_item = result.body
         this.manufacturerId = this.lot_item.manufacturer_id
         this.getModels()
         this.getDamageTypes()
       })
      },

      resetVee() {
        this.$validator.reset();
      },

      openModal( id ) {
        this.id_modal = id
        this.$refs['my-modal'].show()
      },

      hideModal() {
        switch (this.id_modal) {
          case 0:
            this.manufacturers = []
            this.getManufacturers();
            break;
          case 1:
            this.models = []
            this.getModels()
            break
          case 2:
            this.damageTypes = []
            this.getDamageTypes()
            break
          case 3:
            this.destinations = []
            this.getDestinations();
            break
          case 4:
            this.categories = []
            this.getCategories();
            break
          case 5:
            this.processors = []
            this.getProcessors();
            break
          case 6:
            this.keyboardTypes = []
            this.getKeyboardTypes();
            break
          case 7:
            this.diskSizes = []
            this.getDiskSizes();
            break
          case 8:
            this.diskTypes = []
            this.getDiskTypes();
            break
          case 9:
            this.hardwareTypes = []
            this.getHardwareTypes()
            break
          default:
            break
        }
        this.$refs['my-modal'].hide()
      },
    },
  };
</script>

<style scoped>
  .card {
    margin-top: 50px;
  }

  .cancel-btn {
    margin-left: 15px;
  }

  .width-complete{
    width: 400px;
  }

  .is-danger {
    border-color: red !important;
  }

  .error-text {
    color: red;
    font-size: 12px;
    font-weight: bold;
  }
</style>
