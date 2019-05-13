<template>
  <nav class="navbar navbar-dark navbar-expand-md bg-primary" style="background-color: #1168b7;">
    <div class="container-fluid">
      <a class="navbar-brand" href="/">
        <img src="../assets/images/logo.png" class="brand">
      </a>
      <button data-toggle="collapse" data-target="#navcol-1" class="navbar-toggler">
        <span class="sr-only">Toggle navigation</span>
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navcol-1">
        <!--ul class="nav navbar-nav">
          <li role="presentation" class="nav-item"><a class="nav-link active" href="#">First Item</a></li>
          <li role="presentation" class="nav-item"><a class="nav-link" href="#">Second Item</a></li>
          <li role="presentation" class="nav-item"><a class="nav-link" href="#">Third Item</a></li>
        </ul-->
      </div>

      <a class="float-right" href="/">
        <img src="../assets/images/logo_constata.png" class="brand">
      </a>
    </div>
  </nav>
</template>

<script>
  export default {
    data: () => {
      return {
      };
    },

    computed: {
      logged() {
        return this.$store.state.logged
      },

      currentUser() {
        return this.$store.state.currentUser
      },

      landing() {
        return this.$store.state.landing
      }
    },

    mounted() {
    },

    methods: {

    }
  };
</script>

<style scoped >
  .navbar {
    background-color: #1168b7 !important;
    height: 60px !important;
  }

  .brand {
    width: 150px;
    height: 40px;
  }

  .navbar-dark .navbar-nav .nav-link {
    color: #fff !important;
    border-left: 1px solid rgba(255, 255, 255, 0.1);
  }

  .nav-item:hover {
    background-color: #444854;
  }

  .dd-button {
    border-left: 1px solid rgba(255, 255, 255, 0.1);
  }

  .dd-button:hover {
    background-color: #444854;
  }

  .dd-button a em {
    color: #fff !important;
  }

  .nav-icon img {
    width: 15px;
    margin-top: -5px;
    margin-right: 3px
  }
</style>
