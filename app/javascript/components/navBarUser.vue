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
            <a href="javascript:void(0)" v-on:click='logoff()'>Sair</a>
          </div>
        </div>
      </li>
    </ul>
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
    }

  }
}

</script>

<style scoped lang="scss">
  .nav-header {
    /*border-bottom: 1px solid #E9E9E6;
    border-top: 3px solid #EDEDED;*/
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
</style>
