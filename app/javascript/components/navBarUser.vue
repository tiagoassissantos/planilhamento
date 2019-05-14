<template>
 <div id="navBarUser">
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
          <a href="#">Trocar senha</a>
          <a href="#">Sair</a>
        </div>
      </div>
    </li>
  </ul>

  <div class="area"></div>
   
    <div class="header-side">
      <ul class="nav justify-content-left">
        <li id="navigation-toggle" class="nav-item nav-toggle">
          <span class="nav-text"> Navegação </span>
        </li>
        <li id="hamburger-li" class="nav-item hamburguer-item">
          <div class="header__menu">
            <a @click="animationHamburger()" id="header__button" class="hamburger" href="#">
              <div class="hamburger__inner"></div>
            </a>  
          </div>
        </li>

        <li class="nav-item">
          <label id="label" class="nav-link active"> Recicladora Urbana </label>
        </li>
      </ul>
    </div>
  
  <nav id="main-menu-id" class="main-menu">
    <ul>
      <li>
        <a href="http://justinfarrow.com">
          <i class="fa fa-home fa-2x"></i>
          <span class="nav-text">
            Cadastros
          </span>
        </a>
      </li>
      <li class="has-subnav">
        <a href="#">
          <i class="fa fa-laptop fa-2x"></i>
          <span class="nav-text">
            Recebimento
          </span>
        </a>
      </li>
      <li class="has-subnav">
        <a href="#">
          <i class="fa fa-list fa-2x"></i>
          <span class="nav-text">
            Inventário
          </span>
        </a>
      </li>
      <li class="has-subnav">
        <a href="#">
          <i class="fa fa-folder-open fa-2x"></i>
          <span class="nav-text">
            Movimentações
          </span>
        </a>
      </li>
      <li>
        <a href="#">
          <i class="fa fa-bar-chart-o fa-2x"></i>
          <span class="nav-text">
            Utilitários
          </span>
        </a>
      </li>
    </ul>
  </nav>

</div>
</template>

<script>
export default {
  data() {
    return {
      mainProps: { blank: true, blankColor: '#777', width: 50, height: 50, class: 'm1' },
      sideActive: false

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
    }

  }
}

</script>

<style scoped lang="scss">

  .nav-header {
    border-bottom: 1px solid #E9E9E6;
    border-top: 3px solid #EDEDED;
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

  /* Hamburger */

  .hamburguer-item{
    padding-right: 40px !important;
    padding-top: 15px;
    padding-left: 15px;
    border-right: 1px solid #777 
  }

  

  $hamburger__height: 10px;
  $hamburger__width: 20px;
  $hamburger__layer__height: 3px;
  $hamburger__colour: #C3C3C3;

  // Structure
  .hamburger {
    display: block;
    position: absolute;
    width: $hamburger__height;
    height: $hamburger__width;
    z-index: 2;
    border-radius: 5px;
  }

  .hamburger__inner { 
    display: block;
    width: $hamburger__width;
    height: $hamburger__layer__height; 
    margin-top: $hamburger__layer__height * 2;
    background: $hamburger__colour;
    -webkit-transition: all 0.4s ease-in-out;
    transition: all 0.4s ease-in-out;
  
    &::before, &::after { 
      display: block; 
      position: absolute; 
      content: "";
      z-index: -1;
      width: $hamburger__width; 
      height: $hamburger__layer__height; 
      background: $hamburger__colour;
      -webkit-transition: all 0.4s ease-in-out;
      transition: all 0.4s ease-in-out; 
    }
    &::before {
      top: 0;
    }
    &::after {
      top: $hamburger__layer__height * 4;
    }
  }



  // Clicked State
  .hamburger--open {
    .hamburger__inner {
      background: none;

      &::before, &::after {
        top: $hamburger__layer__height * 2; 
      } 
      &::before {
        -webkit-transform: rotate(-45deg); 
        -ms-transform: rotate(-45deg); 
        transform: rotate(-45deg);
      }
      &::after {
        -webkit-transform: rotate(45deg); 
        -ms-transform: rotate(45deg); 
        transform: rotate(45deg);
      }
    } 
  }

  /*Side menu */

  .fa-2x {
    font-size: 2em;
  }

  .fa {
    position: relative;
    display: table-cell;
    width: 60px;
    height: 36px;
    text-align: center;
    vertical-align: middle;
    font-size:20px;
  }


  .main-menu:hover,nav.main-menu.expanded {
    width:250px;
    overflow:visible;
  }

  .expanded {
    width:250px;
    overflow:visible;
  }

  .main-menu {
    background:#212121;
    border-right:1px solid #e5e5e5;
    position:absolute;
    top:129px !important;
    bottom:0;
    height:100%;
    left:0;
    width:60px;
    overflow:hidden;
    -webkit-transition:width .05s linear;
    transition:width .05s linear;
    -webkit-transform:translateZ(0) scale(1,1);
    z-index:1000;
  }

  .main-menu>ul {
    margin:7px 0;
  }

  .main-menu li {
    position:relative;
    display:block;
    width:350px;
  }

  .main-menu li>a {
    position:relative;
    display:table;
    border-collapse:collapse;
    border-spacing:0;
    color:#999;
     font-family: arial;
    font-size: 14px;
    text-decoration:none;
    -webkit-transform:translateZ(0) scale(1,1);
    -webkit-transition:all .1s linear;
    transition:all .1s linear;
  }

  .main-menu .nav-icon {
    position:relative;
    display:table-cell;
    width:60px;
    height:36px;
    text-align:center;
    vertical-align:middle;
    font-size:18px;
  }

  .main-menu .nav-text {
    position:relative;
    display:table-cell;
    vertical-align:middle;
    width:190px;
    font-family: 'Titillium Web', sans-serif;
  }

  .main-menu>ul.logout {
    position:absolute;
    left:0;
    bottom:0;
  }

  .no-touch .scrollable.hover {
    overflow-y:hidden;
  }

  .no-touch .scrollable.hover:hover {
    overflow-y:auto;
    overflow:visible;
  }

  a:hover,a:focus {
    text-decoration:none;
  }

  nav {
    -webkit-user-select:none;
    -moz-user-select:none;
    -ms-user-select:none;
    -o-user-select:none;
    user-select:none;
  }

  nav ul,nav li {
    outline:0;
    margin:0;
    padding:0;
  }

  .main-menu li:hover>a,nav.main-menu li.active>a,.dropdown-menu>li>a:hover,.dropdown-menu>li>a:focus,.dropdown-menu>.active>a,.dropdown-menu>.active>a:hover,  .dropdown-menu>.active>a:focus,.no-touch .dashboard-page nav.dashboard-menu ul li:hover a,.dashboard-page nav.dashboard-menu ul li.active a {
    color:#fff;
    background-color:#5fa2db;
  }
  .area {
    float: left;
    background: #e2e2e2;
    width: 100%;
    height: 100%;
  }

  .nav-text{
    color: #abb4be;
    padding-top: 20px;
  }
</style>
