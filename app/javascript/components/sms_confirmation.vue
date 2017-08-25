<script>
import axios from 'axios'
import Cleave from 'cleave.js'
import * as cl from 'cleave.js/dist/addons/cleave-phone.ru'

export default {
  props: [
    'initialModel'
  ],
  data: function () {
    return {
      model: this.initialModel,
      code: null,
      tokenRequestedAt: null,
      requesting: false,
      phoneCleave: null
    }
  },
  mounted () {
    this.phoneCleave = new Cleave(this.$refs.phoneInput, {
      phone: true,
      phoneRegionCode: 'RU'
    });
  },
  methods: {
    changePhone: function () {
      this.model.token = null
      this.model.code = null
      this.model.tokenRequestedAt = null
      this.model.accepted = false
    },
    requestToken: function () {
      this.requesting = true
      axios.post('/api/sms_confirmations', {
        phone: this.model.phone
      }).then(response => {
        this.model.token = response.data.token
        this.requesting = false
        this.tokenRequestedAt = Date.now()
      }).catch(error => {
        if (error) {}
        this.model.token = null
        this.model.accepted = false
        this.requesting = false
        this.code = null
        this.tokenRequestedAt = null
      })
    },
    checkCode: function () {
      this.requesting = true
      axios.put('/api/sms_confirmations', {
        token: this.model.token,
        code: this.code
      }).then(response => {
        this.model.accepted = response.data.accepted
        this.requesting = false
      })
    }
  }
}
</script>
