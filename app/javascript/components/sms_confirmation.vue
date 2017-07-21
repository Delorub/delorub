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
