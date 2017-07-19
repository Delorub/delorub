<template>
  <div>
    <template v-if="token">
      {{phone}}
      <template v-if="accepted">
        Подтвержден
      </template>
      <template v-else>
        <a href="#" :disabled="requesting" v-on:click.prevent="changePhone">Изменить</a>
      </template>
    </template>
    <template v-if="!accepted">
      <div v-if="token">
        <div class="registration-form__content-inputs registration-form__content-inputs__last-input">
          <input type="text" v-model.trim="code" :disabled="requesting" class="form-control form-control__item" placeholder="Введите код подтверждения" />
          <button class="btn btn-primary dr-btn-primary" role="button" :disabled="requesting" v-on:click.prevent="checkCode">Подтвердить</button>
          <a href="#" :disabled="requesting" v-on:click.prevent="requestToken">Отправить повторно</a>
        </div>
      </div>
      <div v-else class="registration-form__content-inputs registration-form__content-inputs__last-input">
        <input type="text" :name="inputName" v-model.trim="phone" :disabled="requesting" class="form-control form-control__item" placeholder="Номер телефона" />
        <button class="btn btn-primary dr-btn-primary" role="button" :disabled="requesting" v-on:click.prevent="requestToken">Подтвердить</button>
      </div>
    </template>
    <template v-if="accepted">
      <a href="#" :disabled="requesting" v-on:click.prevent="changePhone">Изменить номер телефона</a>
    </template>
    <input type="hidden" :name="inputName" v-model.trim="token" />
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props: [
    'initialPhone', 'initialToken', 'initialCode', 'initialAccepted', 'inputName'
  ],
  data: function () {
    return {
      phone: this.initialPhone,
      token: this.initialToken,
      code: this.initialCode,
      accepted: this.initialAccepted,
      tokenRequestedAt: null,
      requesting: false
    }
  },
  methods: {
    changePhone: function () {
      this.token = null
      this.code = null
      this.tokenRequestedAt = null
      this.accepted = false
    },
    requestToken: function () {
      this.requesting = true
      axios.post('/api/sms_confirmations', {
        phone: this.phone
      }).then(response => {
        this.token = response.data.token
        this.requesting = false
        this.tokenRequestedAt = Date.now()
      }).catch(error => {
        if (error) {}
        this.requesting = false
        this.token = null
        this.code = null
        this.tokenRequestedAt = null
        this.accepted = false
      })
    },
    checkCode: function () {
      this.requesting = true
      axios.put('/api/sms_confirmations', {
        token: this.token,
        code: this.code
      }).then(response => {
        this.accepted = response.data.accepted
        this.requesting = false
      })
    }
  }
}
</script>
