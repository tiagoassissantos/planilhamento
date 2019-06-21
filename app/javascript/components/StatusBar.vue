<template>
  <div id="navBarUser">
    <div class="header-side">
      <div class="container">
        <ul class="nav justify-content-start">
          <li class="nav-item">
            <label id="label" class="nav-link active"> Recicladora GAG </label>
          </li>
        </ul>
      </div>

    </div>
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

  methods: {}
}

</script>

<style scoped lang="scss">
  .header-side{
    background-color: #171717;
  }

  #label{
    color: white;
    font-size: 20px;
  }
</style>
