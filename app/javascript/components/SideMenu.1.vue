<template>
  <div class='bg-dark sidebar'>
    <ul class="nav flex-column">

      <li class="nav-item side-header">
        <a class="nav-link disabled text-light" href="#">Navegação</a>
      </li>

      <li class="nav-item">
        <a class="nav-link active text-light" href="#">
          <font-awesome-icon icon="list"/>
          Cadastros
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-light" href="#">
          <font-awesome-icon icon="laptop"/>
          Recebimento
        </a>
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
  }
</style>
