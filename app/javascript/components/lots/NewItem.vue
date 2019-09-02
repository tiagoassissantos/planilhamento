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
          <vue-bootstrap-typeahead
            class="width-complete"
            v-model="query"
            :data="skus"
            :serializer="s => s.code"
            :minMatchingChars="0"
            placeholder="Insira o SKU"
            @hit="selectedSku($event)" />

          <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button">Pesquisar</button>
          </div>

          <div class="card">
            <div>
              <b-alert show variant="danger" v-if="error"> {{ message }} </b-alert>
            </div>

            <div class="card-body">
              <div class="container">

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
                        <option
                          v-for='(hardwareType,index) in hardwareTypes'
                          :key="index"
                          :value='hardwareType.id'
                        >
                          {{hardwareType.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-1"
                          @click="toggleModal('my-modal','modal-1')"
                        >
                          Cadastre novo Hardware
                        </p>

                        <b-modal ref="my-modal" size="lg" hide-footer title="Novo Tipo de Hardware">
                          <div class="d-block text-center">
                            <new-hardware modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(9, 'my-modal')">Close Me</b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('h_type')"> {{ required_text }} </span>
                    </div>
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
                        <option v-for=' (manufacturer, index) in manufacturers' :key="index" :value='manufacturer.id'>
                          {{manufacturer.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-2"
                          @click="toggleModal('my-modal-1','modal-2')"
                        >
                          Cadastre novo Fabricante
                        </p>
                        <b-modal ref="my-modal-1" size="lg" hide-footer title="Novo Fabricante">
                          <div class="d-block text-center">
                            <new-manufacturer modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(0, 'my-modal-1')"> Fechar </b-button>
                        </b-modal>
                      </div>

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
                        <option v-for='(model, index) in models' :key="index" :value='model.id'>
                          {{model.name}}
                        </option>
                      </select>
                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-3"
                          @click="toggleModal('my-modal-2','modal-3')"
                        >
                          Cadastre novo Modelo
                        </p>
                        <b-modal ref="my-modal-2" size="lg" hide-footer title="Novo Modelo">
                          <div class="d-block text-center">
                            <new-model modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(1, 'my-modal-2')"> Fechar </b-button>
                        </b-modal>
                      </div>

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

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull'>
                    <div class="form-group">
                      <label>Memória RAM</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model='lot_item.ram_memory'
                      />
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

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show="showAssetTag">
                    <div class="form-group">
                      <label>Asset TAG</label>
                      <input
                        type="text"
                        name="asset_tag"
                        class="form-control"
                        v-model='lot_item.asset_tag'
                      />
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
                        <option v-for='(category, index) in categories' :key="index" :value='category.id'>
                          {{category.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-4"
                          @click="toggleModal('my-modal-3','modal-4')"
                        >
                          Cadastre nova Categoria
                        </p>
                        <b-modal ref="my-modal-3" size="lg" hide-footer title="Nova Categoria">
                          <div class="d-block text-center">
                            <new-categories modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(4, 'my-modal-3')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('category')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull'>
                    <div class="form-group">
                      <label>Categoria</label>
                      <select
                        class="form-control"
                        type="text"
                        v-model='lot_item.category_id'
                      >
                        <option value='null'> Selecionar Categoria </option>
                        <option v-for='(category, index) in categories' :key="index" :value='category.id'>
                          {{category.name}}
                        </option>
                      </select>
                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-4"
                          @click="toggleModal('my-modal-3','modal-4')"
                        >
                          Cadastre nova Categoria
                        </p>
                        <b-modal ref="my-modal-3" size="lg" hide-footer title="Nova Categoria">
                          <div class="d-block text-center">
                            <new-categories modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(4, 'my-modal-3')"> Fechar </b-button>
                        </b-modal>
                      </div>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="form-group">
                      <label>Comentários</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model='lot_item.comments'
                      />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-if="showDamageType">
                    <div class="form-group">
                      <label>Local / Tipo Avaria</label>

                      <multiselect
                        v-model="value"
                        :options="damageTypes"
                        :multiple="true"
                        :close-on-select="false"
                        :clear-on-select="false"
                        :preserve-search="true"
                        placeholder="Selecione Avarias"
                        label="name"
                        track-by="name"
                        :preselect-first="true"
                        class="input-size"
                      >
                      </multiselect>
                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-5"
                          @click="toggleModal('my-modal-4','modal-5')"
                        >
                          Cadastre nova Avaria
                        </p>
                        <b-modal ref="my-modal-4" size="lg" hide-footer title="Nova Avaria">
                          <div class="d-block text-center">
                            <new-damage-type modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(2, 'my-modal-4')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <!--span class="error-text" v-show="errors.first('damge_type')"> {{ required_text }} </span-->
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
                        <option v-for='(processor, index) in processors' :key="index" :value='processor.id'>
                          {{processor.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-7"
                          @click="toggleModal('my-modal-6','modal-7')"
                        >
                          Cadastre novo Processador
                        </p>
                        <b-modal ref="my-modal-6" size="lg" hide-footer title="Novo Processador">
                          <div class="d-block text-center">
                            <new-processors modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(5, 'my-modal-6')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('processor')"> {{ required_text }} </span>
                    </div>
                  </div>

                                    <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull'>
                    <div class="form-group">
                      <label>Processador</label>
                      <select
                        class="form-control"
                        type="text"
                        v-model='lot_item.processor_id'
                      >
                        <option value='null'> Selecione o processador </option>
                        <option v-for='(processor, index) in processors' :key="index" :value='processor.id'>
                          {{processor.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-7"
                          @click="toggleModal('my-modal-6','modal-7')"
                        >
                          Cadastre novo Processador
                        </p>
                        <b-modal ref="my-modal-6" size="lg" hide-footer title="Novo Processador">
                          <div class="d-block text-center">
                            <new-processors modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(5, 'my-modal-6')"> Fechar </b-button>
                        </b-modal>
                      </div>

                    </div>
                  </div>


                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showDiskSize'>
                    <div class="form-group">
                      <label>Tamanho do Armazenamento</label>
                      <select
                        class="form-control"
                        name="disk_size"
                        type="text"
                        v-model='lot_item.disk_size_id'
                        v-validate.disabled="'required'"
                        :class="{'input': true, 'is-danger': errors.has('disk_size') }"
                      >
                        <option value='null' > Selecione o Tamanho do HD </option>
                        <option v-for='(diskSize, index) in diskSizes' :key="index" :value='diskSize.id'>
                          {{diskSize.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-9"
                          @click="toggleModal('my-modal-8','modal-9')"
                        >
                          Cadastre novo Tamanho do HD
                        </p>
                        <b-modal ref="my-modal-8" size="lg" hide-footer title="Novo tamanho do HD">
                          <div class="d-block text-center">
                            <disk-sizes modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(7, 'my-modal-8')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('disk_size')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Tamanho do Armazenamento</label>
                      <select
                        class="form-control"
                        type="text"
                        v-model='lot_item.disk_size_id'
                      >
                        <option value='null' > Selecione o Tamanho do HD </option>
                        <option v-for='(diskSize, index) in diskSizes' :key="index" :value='diskSize.id'>
                          {{diskSize.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-9"
                          @click="toggleModal('my-modal-8','modal-9')"
                        >
                          Cadastre novo Tamanho do HD
                        </p>
                        <b-modal ref="my-modal-8" size="lg" hide-footer title="Novo tamanho do HD">
                          <div class="d-block text-center">
                            <disk-sizes modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(7, 'my-modal-8')"> Fechar </b-button>
                        </b-modal>
                      </div>

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
                        <option v-for='(diskType, index) in diskTypes' :key="index" :value='diskType.id'>
                          {{diskType.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-10"
                          @click="toggleModal('my-modal-10','modal-10')"
                        >
                          Cadastre novo Tipo de HD
                        </p>
                        <b-modal ref="my-modal-10" size="lg" hide-footer title="Novo Tipo de HD">
                          <div class="d-block text-center">
                            <disk-types modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(8, 'my-modal-10')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('disk_type')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Tipo</label>
                      <select
                        class="form-control"
                        type="text"
                        v-model='lot_item.disk_type_id'
                      >
                        <option value='null'>Selecione Tipo de HD </option>
                        <option v-for='(diskType, index) in diskTypes' :key="index" :value='diskType.id'>
                          {{diskType.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-10"
                          @click="toggleModal('my-modal-10','modal-10')"
                        >
                          Cadastre novo Tipo de HD
                        </p>
                        <b-modal ref="my-modal-9" size="lg" hide-footer title="Novo Tipo de HD">
                          <div class="d-block text-center">
                            <disk-types modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(8, 'my-modal-10')"> Fechar </b-button>
                        </b-modal>
                      </div>

                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showParentId'>
                    <div class="form-group">
                      <label>Parent (ID)</label>
                      <input
                        type="text"
                        name="parent_id"
                        class="form-control"
                        v-model='lot_item.parent_id'
                      />
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

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Tela (Polegadas)</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model='lot_item.screen'
                      />
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
                        <option value="1">Sim</option>
                        <option value="0">Não</option>
                      </select>
                      <span class="error-text" v-show="errors.first('webcam')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Webcam</label>
                      <select
                        class="form-control"
                        v-model='lot_item.webcam'
                      >
                        <option value="null" selected>Selecione</option>
                        <option value="1">Sim</option>
                        <option value="0">Não</option>
                      </select>
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
                        <option v-for='(keyboardType, index) in keyboardTypes' :key="index" :value='keyboardType.id'>
                          {{keyboardType.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-8"
                          size="lg"
                          @click="toggleModal('my-modal-7','modal-8')"
                        >
                          Cadastre novo Tipo de Teclado
                        </p>
                        <b-modal ref="my-modal-7" hide-footer title="Novo Tipo de Teclado">
                          <div class="d-block text-center">
                            <new-keyboard-types modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(6, 'my-modal-7')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('keyboard-type')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Tipo Teclado</label>
                      <select
                        class="form-control"
                        type="text"
                        v-model='lot_item.keyboard_type_id'
                      >
                        <option value='null'> Selecione Novo Tipo de Teclado </option>
                        <option v-for='(keyboardType, index) in keyboardTypes' :key="index" :value='keyboardType.id'>
                          {{keyboardType.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-8"
                          size="lg"
                          @click="toggleModal('my-modal-7','modal-8')"
                        >
                          Cadastre novo Tipo de Teclado
                        </p>
                        <b-modal ref="my-modal-7" hide-footer title="Novo Tipo de Teclado">
                          <div class="d-block text-center">
                            <new-keyboard-types modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(6, 'my-modal-7')"> Fechar </b-button>
                        </b-modal>
                      </div>

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
                        <option value='null' selected> Selecione </option>
                        <option value="1">Sim</option>
                        <option value="0">Não</option>
                      </select>

                      <span class="error-text" v-show="errors.first('bluetooth')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showColors'>
                    <div class="form-group">
                      <label>Cor</label>

                      <select
                        class="form-control"
                        name="color"
                        v-model='lot_item.color'
                        v-validate.disabled="'required'"
                        :class="{'input': true, 'is-danger': errors.has('color') }">
                        <option value="null" selected> Selecione </option>
                        <option value="Amarelo">Amarelo</option>
                        <option value="Azul">Azul</option>
                        <option value="Branco">Branco</option>
                        <option value="Dourado">Dourado</option>
                        <option value="Laranja">Laranja</option>
                        <option value="Prata">Prata</option>
                        <option value="Preto">Preto</option>
                        <option value="Rosa">Rosa</option>
                        <option value="Verde">Verde</option>
                        <option value="Vermelho">Vermelho</option>
                        <option value="Violeta">Violeta</option>
                      </select>

                      <span class="error-text" v-show="errors.first('color')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='lot_item.hardware_type_id == 10'>
                    <div class="form-group">
                      <label>Cor</label>
                      <input type="text" class="form-control" v-model='lot_item.color' />
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showLuminousKeyboard'>
                    <div class="form-group">
                      <label>Teclado Luminoso</label>
                      <select
                        name="birght_keyboard"
                        class="form-control"
                        v-model='lot_item.bright_keyboard'
                        v-validate.disabled="'required'"
                        :class="{'input': true, 'is-danger': errors.has('birght_keyboard') }"
                      >
                        <option value="null" selected> Selecione </option>
                        <option value="1">Sim</option>
                        <option value="0">Não</option>
                      </select>

                    </div>
                    <span class="error-text" v-show="errors.first('birght_keyboard')"> {{ required_text }} </span>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Teclado Luminoso</label>
                      <select
                        name="birght_keyboard"
                        class="form-control"
                        v-model='lot_item.bright_keyboard'
                      >
                        <option value="null" selected> Selecione </option>
                        <option value="1">Sim</option>
                        <option value="0">Não</option>
                      </select>

                    </div>
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
                        <option value="1"> Sim </option>
                        <option value="0"> Não </option>
                      </select>
                      <span class="error-text" v-show="errors.first('biometric_reader')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Leitor Biométrico</label>
                      <select
                        class="form-control"
                        v-model='lot_item.biometric_reader'
                      >
                        <option value="null" selected> Selecione </option>
                        <option value="1"> Sim </option>
                        <option value="0"> Não </option>
                      </select>
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

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showOthersAccNull && showNewOthersAccNull'>
                    <div class="form-group">
                      <label>Tipo Placa Vídeo</label>
                      <select
                        class="form-control"
                        v-model='lot_item.vga_card'
                      >
                        <option value="null" >Selecione </option>
                        <option value="1">Integrada</option>
                        <option value="0">Dedicada</option>
                      </select>
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
                        <option v-for='(destination, index) in destinations'  :key="index" :value='destination.id'>
                          {{destination.name}}
                        </option>
                      </select>

                      <div>
                        <p
                          v-if="show_ref_to_modal"
                          class="link-new"
                          id="modal-6"
                          @click="toggleModal('my-modal-5','modal-6')"
                        >
                          Cadastre novo Destino
                        </p>
                        <b-modal ref="my-modal-5" size="lg" hide-footer title="Novo Destino">
                          <div class="d-block text-center">
                            <new-destinations modal_params="Cadastre"/>
                          </div>
                          <b-button class="mt-3" variant="outline-danger" block @click="hideModal(3, 'my-modal-5')"> Fechar </b-button>
                        </b-modal>
                      </div>

                      <span class="error-text" v-show="errors.first('destinations')"> {{ required_text }} </span>
                    </div>
                  </div>

                  <div class="col-sm-6 col-md-4 col-lg-3" v-show='showBarCode'>
                    <div class="form-group">
                      <label>Código de Barras</label>
                      <input
                        type="text"
                        class="form-control"
                        v-model='lot_item.bar_code'
                        name="bar_code"
                        v-validate.disabled="'required'"
                        :class="{'input': true, 'is-danger': errors.has('bar_code') }"
                      />
                      <span class="error-text" v-show="errors.first('bar_code')"> {{ required_text }} </span>
                      <span class="error-text"> {{ message }}</span>

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

  import Multiselect from 'vue-multiselect'

  export default {
    components: {
      VueBootstrapTypeahead, newManufacturer, newModel, newDamageType, newDestinations, newCategories,
      newProcessors, newKeyboardTypes, DiskSizes, DiskTypes, newHardware, Multiselect
      },

    data() {
      return {
        value: [], //Array of selected damage types.

        lot_item: {
          hardware_type_id: 0,
          model_id: 0,
          ram_memory: null,
          serial_number: null,
          asset_tag: null,
          category_id: null,
          comments: null,
          damage_type_id: [],
          processor_id: null,
          disk_size_id: null,
          disk_type_id: null,
          parent_id: null,
          screen: null,
          webcam: null,
          keyboard_type_id: null,
          bluetooth: null,
          bright_keyboard: null,
          destination_id: null,
          bar_code: null,
          vga_card: null,
          biometric_reader: null,
          color: null,
        },

        show_ref_to_modal: true,

        selected: [], // Must be an array reference!

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
        editDamageType: '',
        returnSubmit: false
      }
    },


    computed: {
      getCurrentUser() {
        return this.$store.state.currentUser
      },

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

      showMemory() {
        if (this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9 ||
            this.lot_item.hardware_type_id == 10 ||
            this.lot_item.hardware_type_id > 10) {
          return false;
        }
        return true;
      },

      showCategory() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9 ||
            this.lot_item.hardware_type_id == 10 ||
            this.lot_item.hardware_type_id > 10
            ) {
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
            this.lot_item.hardware_type_id == 10 ||
            this.lot_item.hardware_type_id == 9 ||
            this.lot_item.hardware_type_id > 10
            ) {
          return false;
        }
        return true;
      },

      showDiskFields() {
        if (
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9
          ) {
          return true;
        }
        return false;
      },

      showParentId() {
        if (
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9 ||
            this.lot_item.hardware_type_id == 10
          ) {
          return true;
        }
        return false;
      },

      showDiskSize() {
        if (
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9
          ) {
          return true;
        }
        return false;
      },

      showScreen() {
        if (
            this.lot_item.hardware_type_id == 0 ||
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 3 ||
            this.lot_item.hardware_type_id == 4 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 10 ||
            this.lot_item.hardware_type_id > 10 ||
            this.lot_item.hardware_type_id == 9) {
          return false;
        }
        return true;
      },

      showAssetTag() {
        if (
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9
            ) {
          return false;
        }
        return true;
      },

      showWebcam() {
        if (
            this.lot_item.hardware_type_id == 4
            ) {
          return true;
        }
        return false;
      },

      showColors() {
        if (
            this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6
          ) {
          return true;
        }
        return false;
      },

      showKeyboardType() {
        if (
            this.lot_item.hardware_type_id == 4
        ) {
          return true;
        }
        return false;
      },

      showBluetooth() {
        if (
            this.lot_item.hardware_type_id == 4
          ) {
          return true;
        }
        return false;
      },

      showLuminousKeyboard() {
        if (
            this.lot_item.hardware_type_id == 4 ) {
          return true;
        }
        return false;
      },

      showBiometricReader() {
        if (
            this.lot_item.hardware_type_id == 4 ) {
          return true;
        }
        return false;
      },

      showVideoCard() {
        if (
            this.lot_item.hardware_type_id == 2 ||
            this.lot_item.hardware_type_id == 4 ) {
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
      },

      showOthersAccNull() {
        if (
            this.lot_item.hardware_type_id == 10   ||
            this.lot_item.hardware_type_id > 10) {
          return true;
        }
        return false;
      },

      showNewOthersAccNull() {
        if (this.lot_item.hardware_type_id > 10) {
          return false;
        }
        return true;
      }
    },

    mounted() {
      this.getHardwareTypes();
      this.getManufacturers();
      this.getCategories();
      this.getProcessors();
      this.getDiskTypes();
      this.getDiskSizes();
      this.getKeyboardTypes();
      this.getDestinations();
      this.getSkus();

      this.lotId = this.$route.params.lot_id;

      this.$store.dispatch('getCurrentUser');
      this.$store.subscribe((mutation, state) => {
        if (mutation.type == 'SET_CURRENT_USER') {
          if(
            this.getCurrentUser.role == "Operador N2"){
              this.show_ref_to_modal = false
          }
        }
      })


    },

    methods: {

      cancelItem() {
        this.$router.go(-1)
      },

      async submit() {
        this.lot_item.damage_type_id = []
        console.log("+++++++++++")
        console.log(this.value)
        console.log("+++++++++++")
        console.log(this.lot_item.damage_type_id)
        console.log("----------------")
        this.value.forEach(damageType => {
          this.lot_item.damage_type_id.push(damageType.id)
        })

        this.$validator.validate().then((result) => {
          switch (this.lot_item.hardware_type_id) {
            case 1:
              if ( this.validationMonitorAndSwitch() ) {
                return
                }
              break;
            case 2:
              if ( this.validationDeskTop() ) {
                this.returnSubmit = true
              } else {
                this.returnSubmit = false
              }
              break;
            case 3:
              if ( this.validationServer() ) {
                this.returnSubmit = true
              } else {
                this.returnSubmit = false
              }
              break;
            case 4:
              if ( this.validationNoteBook() ) {
                this.returnSubmit = true
              } else {
                this.returnSubmit = false
              }
              break;
            case 5:
              if ( this.validationPhone() ) {
                 this.returnSubmit = true
              } else {
                this.returnSubmit = false
              }
              break;
            case 6:
              if ( this.validationPhone() ) {
                this.returnSubmit = true
              } else {
                this.returnSubmit = false
              }
              break;
            case 7:
              if ( this.validationMonitorAndSwitch() ) {
                return
              }
              break;
            case 8:
              if ( this.validationHdAndSsd() ) {
                return
              }
              break;
            case 9:
              if ( this.validationHdAndSsd() ) {
                return
              }
              break;

            default:
              break;
          }
        });

        setTimeout(function() {
          if ( this.returnSubmit ) {
            return
          }

          this.registrationOrEdit()
        }.bind(this), 1000);
      },

      validationMonitorAndSwitch () {
        if(
            this.lot_item.category_id == null ||
            ( this.lot_item.destination_id != 4 && this.lot_item.bar_code.trim() == '')
          ){
          return true
        }
      },

      validationDeskTop () {
        if(
            this.lot_item.category_id == null ||
            this.lot_item.processor_id == null ||
            this.lot_item.vga_card == null ||
            this.lot_item.ram_memory == null ||
            this.lot_item.ram_memory.trim() == '' ||
            ( this.lot_item.destination_id != 4 && this.lot_item.bar_code.trim() == '')
          ){
          return true

        } else if ( this.lot_item.vga_card == 'null') {
          this.lot_item.vga_card = null
          return true

        } else {
          return false
        }
      },

      validationServer () {
        if (
            this.lot_item.category_id == null ||
            this.lot_item.processor_id == null ||
            this.lot_item.ram_memory == null ||
            this.lot_item.ram_memory.trim() == '' ||
            ( this.lot_item.destination_id != 4 && this.lot_item.bar_code.trim() == '')
          ) {
          return true
        }
        return false;
      },

      validationNoteBook() {
        if(
            this.lot_item.category_id == null ||
            this.lot_item.processor_id == null ||
            this.lot_item.webcam == null ||
            this.lot_item.keyboard_type_id == null ||
            this.lot_item.bluetooth == null ||
            this.lot_item.bright_keyboard == null ||
            this.lot_item.biometric_reader == null ||
            this.lot_item.vga_card == null ||
            this.lot_item.ram_memory == null ||
            this.lot_item.ram_memory.trim() == '' ||
            ( this.lot_item.destination_id != 4 && this.lot_item.bar_code.trim() == '')
          ){
          return true
        } else if ( this.lot_item.bluetooth == 'null'  ) {
          this.lot_item.bluetooth = null
          return true

        } else if ( this.lot_item.webcam == 'null'  ) {
          this.lot_item.webcam = null
          return true

        } else if ( this.lot_item.bright_keyboard == 'null'  ) {
          this.lot_item.bright_keyboard = null
          return true

        } else if ( this.lot_item.keyboard_type_id == 'null'  ) {
          this.lot_item.keyboard_type_id = null
          return true

        } else if ( this.lot_item.vga_card == 'null'  ) {
          this.lot_item.vga_card = null
          return true

        }  else if ( this.lot_item.biometric_reader == 'null'  ) {
          this.lot_item.biometric_reader = null
          return true

        }
         else {
          return false
        }
      },

      validationPhone() {
        if(
            this.lot_item.category_id == null ||
            this.lot_item.disk_size_id == null ||
            this.lot_item.screen == null ||
            this.lot_item.color == null ||
            ( this.lot_item.destination_id != 4 && this.lot_item.bar_code.trim() == '')
          ){
          return true


        } else if (this.lot_item.color == 'null'){
          this.lot_item.color = null
          return true

        } else {
          return false
        }
      },

      validationHdAndSsd() {
        if(
            this.lot_item.disk_size_id == null ||
            this.lot_item.disk_type_id == null ||
            ( this.lot_item.destination_id != 4 && this.lot_item.bar_code.trim() == '')
          ){
          return true
        }
      },

      async registrationOrEdit() {
        let response = null;

        if( this.lot_item.destination_id == 4 ) {
          this.lot_item.bar_code = ' '
        }

        if(
          (this.lot_item.hardware_type_id == 2 ||
          this.lot_item.hardware_type_id == 3 ||
          this.lot_item.hardware_type_id == 4 ||
          this.lot_item.hardware_type_id == 5 ||
          this.lot_item.hardware_type_id == 6 ) &&
          this.lot_item.ram_memory == ''
          ) {
            this.lot_item.ram_memory = null
          }

          if (
            this.lot_item.hardware_type_id == 1 ||
            this.lot_item.hardware_type_id == 7 ||
            this.lot_item.hardware_type_id == 8 ||
            this.lot_item.hardware_type_id == 9
          ) {
            this.lot_item.ram_memory = ' '
          }

          if( this.lot_item.serial_number == '') {
            this.lot_item.serial_number = null
          }

          if(
            (this.lot_item.hardware_type_id == 5 ||
            this.lot_item.hardware_type_id == 6) &&
            this.lot_item.color == null
          ) {
            return
          }

          if (this.lot_item.hardware_type_id == 10 && this.lot_item.ram_memory == null ){
            this.lot_item.ram_memory = ''
          }


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
        this.lot_item.damage_type_id = []
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
         this.lot_item = result.body.sku
         this.manufacturerId = this.lot_item.manufacturer_id
         this.getModels()
         this.getDamageTypes()
       })
      },

      resetVee() {
        this.$validator.reset();
      },

     hideModal(id, string_modal) {

        switch (id) {
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
        this.$refs[string_modal].hide()
      },

      toggleModal(ref_string, id_string) {
        this.$refs[ref_string].toggle(id_string)
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

  .link-new {
    color: #0094d9;
    font-size: 12px;
    cursor: pointer;
    font-weight: bold;
  }

  .link-new:hover {
    text-decoration: underline;
  }

  select[readonly] {
    background: #eee;
    pointer-events: none;
    touch-action: none;
  }

  .input-size {
    font-size: 12px !important;
  }

</style>


<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>