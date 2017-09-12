<template lang="pug">
  div
    slot(name="inputs" v-bind="model")
    div.form__phone(v-if="model.phone && model.token")
      span.form__phone-number {{model.phone}}
      template(v-if="model.accepted")
        span.form__approved Подтвержден
      template(v-else="")
        span.form__phone-link
          a.link-default(:disabled="requesting" href="#" @click.prevent="changePhone") Изменить
    div.row(v-if="!model.accepted && model.token")
      div.col-lg-4.col-md-6
        input.form-control.form-control__item(
          type="text"
          :disabled="requesting"
          placeholder="Код подтверждения"
          id="sms_confirmation_code"
          v-model.trim="code"
        )
      div.col-lg-4.col-md-6
        input.dr-btn-default.dr-btn-default-margin-top-2(
          type="button"
          :disabled="requesting"
          role="button"
          id="sms_confirm_phone"
          @click.prevent="checkCode"
          value="Подтвердить"
        )
      div.col-lg-4.col-md-6.offset-lg-0.offset-md-6.phone-display-show
        a.link-default(:disabled="requesting" href="#" @click.prevent="requestToken") Отправить повторно
        br
        span(v-if="!resendAvailable")
          | Доступно через {{ formatCountdown(resendAvailableAt) }}
    div.row.margin-bottom-05(v-else-if="!model.accepted")
      div.col-xl-4.col-lg-6
        input.form-control.form-control__item(
          type="text"
          :disabled="requesting"
          placeholder="Номер телефона"
          id="user_sms_confirmation_attributes_phone"
          v-model="model.phone"
          @keydown.capture="handleRussianPhoneFormat"
          ref="phoneInput"
        )
      div.col-xl-4.col-lg-6.col-margin-bottom
        input.dr-btn-default.dr-btn-default-margin-top-2(
          type="button"
          :disabled="requesting"
          role="button"
          id="sms_send_confirm_phone"
          @click.prevent="requestToken"
          value="Подтвердить"
        )
    div.row(v-if="errors.phone")
      div.col-12
        span.form__error-message {{ errors.phone[0] }}
    div.row(v-if="model.accepted")
      div.col.form__phone-change
        a.link-default(:disabled="requesting" href="#" @click.prevent="changePhone") Изменить номер телефона
</template>
<script>
  import axios from 'axios'
  import Cleave from 'cleave.js'
  import 'cleave.js/dist/addons/cleave-phone.ru'
  import countdown from 'mixins/countdown'

  export default {
    mixins: [countdown],
    props: {
      value: {
        default: {
          phone: null,
          token: null,
          accepted: null,
          created_at: null
        }
      },
      resendSeconds: {
        default: 20,
        type: Number
      },
      errorMessages: {
        default: {}
      }
    },
    data: function () {
      return {
        model: this.value,
        errors: this.errorMessages,
        code: null,
        tokenRequestedAt: null,
        requesting: false,
        phoneCleave: null
      }
    },
    mounted () {
      if (this.$refs.phoneInput !== undefined) {
        this.phoneCleave = new Cleave(this.$refs.phoneInput, {
          phone: true,
          phoneRegionCode: 'RU'
        })
      }
    },
    methods: {
      handleRussianPhoneFormat: function (e) {
        if (e.target.value === '' && (e.key === '8' || e.key === '7')) {
          e.preventDefault()
          e.target.value = '+7'
        }
      },
      changePhone: function () {
        this.errors = {}
        this.model.token = null
        this.model.code = null
        this.model.created_at = null
        this.model.accepted = false
        this.tokenRequestedAt = null
      },
      requestToken: function () {
        if (!this.resendAvailable) {
          return false
        }

        this.requesting = true

        axios.post('/api/sms_confirmations', {
          phone: this.model.phone
        }).then(response => {
          this.requesting = false

          if (response.data.errors) {
            this.errors = response.data.errors
          } else {
            this.errors = {}
            this.tokenRequestedAt = (new Date()).getTime()
            this.model = response.data
          }
        }).catch(error => {
          if (error) {}
          this.requesting = false
        })
      },
      checkCode: function () {
        this.requesting = true

        axios.put('/api/sms_confirmations', {
          token: this.model.token,
          code: this.code
        }).then(response => {
          this.requesting = false

          if (response.data.errors) {
            this.errors = response.data.errors
          } else {
            this.errors = {}
            this.model = response.data
          }
        }).catch((error, response) => {
          if (error) {}
          this.requesting = false
        })
      }
    },
    computed: {
      resendAvailable () {
        return this.resendAvailableAt === 0
      },
      resendAvailableAt () {
        return this.countdownTo(this.tokenRequestedAt, this.resendSeconds)
      }
    }
  }
</script>
