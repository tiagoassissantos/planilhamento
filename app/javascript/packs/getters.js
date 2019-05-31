export default {
  async gethardwareTypes() {
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
      this.showAlert = true
      this.messageClass = "danger"
      this.message = "Erro ao carregar os dados."
    }

    this.loading = false
  },
}