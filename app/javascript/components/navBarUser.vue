<template>
  <nav class="navbar navbar-light bg-light nav">
    <ul>
      <li>
        <a href="#">
          <font-awesome-icon icon="list"/>
          Cadastros
        </a>
        <ul>
          <li>
            <router-link to="/users" class="nav-link active text-light">
              <font-awesome-icon icon="user" class="sub-icon"/> Usuários
            </router-link>
          </li>
          <li>
            <router-link to="/hardware-types" class="nav-link active text-light">
              <font-awesome-icon icon="microchip" class="sub-icon"/> Tipo de Hardware
            </router-link>
          </li>
          <li>
            <router-link to="/manufacturers" class="nav-link active text-light">
              <font-awesome-icon icon="user-cog" class="sub-icon"/> Fabricante
            </router-link>
          </li>
          <li>
            <router-link to="/models" class="nav-link active text-light">
              <font-awesome-icon icon="info-circle" class="sub-icon"/> Modelo
            </router-link>
          </li>
          <li>
            <router-link to="/categories" class="nav-link active text-light">
              <font-awesome-icon icon="indent" class="sub-icon"/> Categoria
            </router-link>
          </li>
          <li>
            <router-link to="/damage-types" class="nav-link active text-light">
              <font-awesome-icon icon="unlink" class="sub-icon"/> Tipo de Avaria
            </router-link>
          </li>
          <li>
            <router-link to="/processors" class="nav-link active text-light">
              <font-awesome-icon icon="sim-card" class="sub-icon"/> Processadores
            </router-link>
          </li>
          <li>
            <router-link to="/disk-types" class="nav-link active text-light">
              <font-awesome-icon icon="memory" class="sub-icon"/> Tipo do Disco
            </router-link>
          </li>
          <li>
            <router-link to="/disk-sizes" class="nav-link active text-light">
              <font-awesome-icon icon="server" class="sub-icon"/> Tamanho do Disco
            </router-link>
          </li>
          <li>
            <router-link to="/keyboard-types" class="nav-link active text-light">
              <font-awesome-icon icon="keyboard" class="sub-icon"/> Tipo Teclado
            </router-link>
          </li>
          <li>
            <router-link to="/destinations" class="nav-link active text-light">
              <font-awesome-icon icon="plane" class="sub-icon"/> Destino
            </router-link>
          </li>
        </ul>
      </li>

      <li v-if="getCurrentUser.role != 'Operador N2'">
        <a href="#">
          <font-awesome-icon icon="laptop"/>
          Recebimento
        </a>
        <ul>
          <li>
            <router-link to="/lots" class="nav-link active text-light">
              <font-awesome-icon icon="box" class="sub-icon"/> Lote
            </router-link>
          </li>
        </ul>
      </li>

      <li>
        <a href="#">
          <font-awesome-icon icon="copy"/>
          Inventário

          <ul>
            <li>
              <router-link class="nav-link active text-light" :to="{ name: 'inventory', params: {status: 'all'}}">
                <font-awesome-icon icon="box" class="sub-icon"/> Todos os Lotes
              </router-link>
            </li>
            <li>
              <router-link class="nav-link active text-light" :to="{ name: 'inventory', params: {status: 'open'}}">
                <font-awesome-icon icon="box" class="sub-icon"/> Lotes Abertos
              </router-link>
            </li>
            <li>
              <router-link class="nav-link active text-light" :to="{ name: 'inventory', params: {status: 'closed'}}">
                <font-awesome-icon icon="box" class="sub-icon"/> Lotes Fechados
              </router-link>
            </li>
          </ul>
        </a>
      </li>

      <li>
        <a href="#">
          <font-awesome-icon icon="columns"/>
          Movimentações
        </a>
      </li>
    </ul>

    <ul class="nav justify-content-end nav-header">
      <li class="nav-item style-item">
        <span class="nav-link" href="#">
          0.0.19
        </span>
      </li>
      <li class="nav-item style-item">
        <div class="dropdown">
          <div class="row">
            <div class="col-sm-3">
              <b-img v-bind="mainProps" rounded="circle" alt="Circle image"></b-img>
            </div>
            <div class="col-sm">
              <span class="dropbtn">
                Nome do usuário
                <p> Teste</p>
              </span>
            </div>
          </div>
          <div class="dropdown-content">
            <router-link to="/change-password">Trocar senha</router-link>
            <a href="javascript:void(0)" v-on:click='logoff()'>Sair</a>
          </div>
        </div>
      </li>
    </ul>

  </nav>
</template>

<script>
export default {
  data() {
    return {
      mainProps: { blank: true, blankColor: '#777', width: 50, height: 50, class: 'm1' },
      sideActive: false
    }
  },

  computed: {
    getCurrentUser() {
        return this.$store.state.currentUser
    }
  },


  methods: {

    animationHamburger() {
      let hamburger = document.getElementById('header__button');
      hamburger.classList.toggle("hamburger--open");
      let sideMenu = document.getElementById('main-menu-id');
      let hamburgerLi = document.getElementById('hamburger-li')
      let navigationLi = document.getElementById('navigation-toggle')

      if( this.sideActive ) {
        sideMenu.classList.remove("expanded");
        this.sideActive = false
        navigationLi.style.display = "none";
      }else {
        sideMenu.classList.add("expanded");
        navigationLi.style.display = "block";
        this.sideActive = true
      }
    },

    logoff() {
      this.$http
        .delete("/users/sign_out")
        .then(result => {
          window.location.href = "/";
        })
        .catch(err => {
          //window.location.href = "/";
        });
    },

    toggleNavPanel(x){
      var panel = document.getElementById(x), navarrow = document.getElementById("navarrow"), maxH="300px";
      if(panel.style.height == maxH){
        panel.style.height = "0px";
        navarrow.innerHTML = "&#9662;";
      } else {
        panel.style.height = maxH;
        navarrow.innerHTML = "&#9652;";
      }
    }

  }
}

</script>

<style scoped lang="scss">
  .nav-header {
    height: 75px;
  }

  .style-item {
    border-left: 1px solid #E9E9E6;
    padding-top: 10px;
    padding-left: 20px;
    padding-right: 20px;
  }


  .dropbtn {
    background-color: transparent;
    color: black;

    font-size: 16px;
    border: none;
    cursor: pointer;
  }

  .dropdown {
    position: relative;
    display: inline-block;
  }

  .dropdown-content {
    display: none;
    position: absolute;
    left: -20px;
    top: 60px;
    background-color: #f9f9f9;
    min-width: 220px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
  }

  .dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
  }

  .dropdown-content a:hover {background-color: #f1f1f1}

  .dropdown:hover .dropdown-content {
    display: block;
  }

  .header-side{
    background-color:#171717;
  }

  #label{
    color: white;
    font-size: 20px;
  }

  #navigation-toggle {
    display: none;
    color: white;
    background-color: #212121;
    padding-right: 75px !important;
  }

  .nav-toggle{
    padding-top: 10px;
    padding-left: 20px;
    margin-right: 18px;
  }


  .nav ul {
    *zoom: 1;
    list-style: none;
    margin: 0;
    padding: 0;
  }

  .nav ul:before,
  .nav ul:after {
    content: "";
    display: table;
  }

  .nav ul:after {
    clear: both;
  }

  .nav ul > li {
    float: left;
    position: relative;
  }

  .nav a {
    display: block;
    padding: 10px 20px;
    line-height: 1.2em;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
  }

  .nav a:hover {
    text-decoration: none;
    background: #171717;
    color: white !important;
  }

  .nav li ul {
    background: #171717;
  }

  .nav li ul li {
    width: 200px;
  }

  .nav li ul a {
    border: none;
  }

  .nav li ul a:hover {
    background: rgba(0, 0, 0, 0.19999999999999996);
  }

  .nav ul > li:hover ul li {
    max-height: 150px;
  }

  .nav li ul {
    position: absolute;
    left: 0;
    top: 36px;
    z-index: 1;
  }

  .nav li ul li {
    overflow: hidden;
    max-height: 0;
    -webkit-transition: max-height 500ms ease;
    -moz-transition: max-height 500ms ease;
    -o-transition: max-height 500ms ease;
    transition: max-height 500ms ease;
  }

  .sub-icon{
    margin-right: 5px;
    margin-top: -51px !important;
  }

</style>
