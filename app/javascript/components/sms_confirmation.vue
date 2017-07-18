<template>
  <div class="registration-form__content-inputs registration-form__content-inputs__last-input">
    <input type="text" v-bind:value="phone" class="form-control form-control__item" placeholder="Номер телефона"/>
    <a class="btn btn-primary dr-btn-primary" href="#" role="button" v-on:click="send">Подтвердить</a>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  methods: {
    send: function () {
      axios.get('/api/sms_confirmations/confirm', {
        phone: this.phone
      })
      .then(response => {
      })
      .catch(error => {
      })
    }
  }
}
</script>
