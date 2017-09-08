<script>
import axios from 'axios'

export default {
  props: [
    'initialModel'
  ],
  data: function () {
    return {
      model: this.initialModel,
      requesting: false,
      code: null
    }
  },
  methods: {
    requestToken: function () {
      this.requesting = true
      console.log(this.model)
      axios.post('/api/sms_confirmations', {
        phone: this.model.email_or_phone
      }).then(response => {
        this.model.sms_confirmation = response.data
        this.requesting = false
      }).catch(error => {
        if (error) {}
        this.model.sms_confirmation = null
        this.requesting = false
        this.code = null
      })
    }
  },
  computed: {
    sign_in_by: function () {
      if (this.model.sms_confirmation !== null) {
        return 'sms'
      }
      return 'password'
    }
  }
}
</script>
