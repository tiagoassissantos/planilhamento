<template>
  <div class='bg-dark sidebar accordion'>
    <ul class="nav flex-column">

      <li class="nav-item side-header">
        <a class="nav-link disabled text-light" href="#">Navegação</a>
      </li>

      <li class="nav-item" data-toggle="collapse" data-target="#registers">
        <span class='nav-link active text-light'>
          <font-awesome-icon icon="list"/>
          Cadastros
        </span>

        <ul class="nav nav-list collapse submenu" id="registers">
          <li class="nav-item">
            <router-link to="/users" class="nav-link active text-light">
              Usuários
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/hardware-types" class="nav-link active text-light">
              Tipo de Hardware
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/manufacturers" class="nav-link active text-light">
              Fabricante
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/models" class="nav-link active text-light">
              Modelo
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/categories" class="nav-link active text-light">
              Categoria
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/damage-types" class="nav-link active text-light">
              Tipo de Avaria
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/processors" class="nav-link active text-light">
              Processadores
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/disk-types" class="nav-link active text-light">
              Tipo do Disco
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/disk-sizes" class="nav-link active text-light">
              Tamanho do Disco
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/keyboard-types" class="nav-link active text-light">
              Tipo Teclado
            </router-link>
          </li>
          <li class="nav-item">
            <router-link to="/destinations" class="nav-link active text-light">
              Destino
            </router-link>
          </li>
        </ul>
      </li>

      <li class="nav-item" data-toggle="collapse" data-target="#receipt">
        <a class="nav-link text-light" href="#">
          <font-awesome-icon icon="laptop"/>
          Recebimento
        </a>
        <ul class="nav nav-list collapse submenu" id="receipt">
          <li class="nav-item">
            <router-link to="/lots" class="nav-link active text-light">
              Lote
            </router-link>
          </li>
        </ul>
      </li>

      <li class="nav-item">
        <a class="nav-link text-light" href="#">
          <font-awesome-icon icon="copy"/>
          Inventário
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link text-light" href="#" tabindex="-1" aria-disabled="true">
          <font-awesome-icon icon="columns"/>
          Movimentações
        </a>
      </li>
    </ul>
  </div>
</template>


<script>
  export default {
    data() {
      return {

      }
    },


    mounted() {
      /*if (typeof localStorage !== 'undefined') {
          if (localStorage.getItem('sidebar-left-position') !== null) {
            var initialPosition = localStorage.getItem('sidebar-left-position'),
              sidebarLeft = document.querySelector('#sidebar-left .nano-content');

            sidebarLeft.scrollTop = initialPosition;
          }
        }*/
    },

    methods: {

    }
  }
</script>

<style scoped lang="scss">
  .side-header {
    height: 54px;
  }

  .sidebar {
    width: 200px;
    background-color: black;
    height: 100%
    ;
  }

  .submenu {
    margin-left: 30px;
  }
</style>
