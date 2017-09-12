<script>
  import axios from 'axios'
  import countdown from 'mixins/countdown'

  export default {
    mixins: [countdown],
    props: {
      initialModel: {
        default: {}
      },
      resendSeconds: {
        default: 20,
        type: Number
      },
      errorMessages: {
        default: function () {
          return {}
        }
      }
    },
    data: function () {
      return {
        model: this.initialModel,
        requesting: false,
        tokenRequestedAt: null,
        code: null
      }
    },
    methods: {
      requestToken: function () {
        if (!this.resendAvailable) {
          return false
        }

        this.requesting = true

        axios.post('/api/sms_confirmations', {
          phone: this.model.email_or_phone
        }).then(response => {
          this.requesting = false

          if (response.data.errors) {
            this.errors = response.data.errors
          } else {
            this.errors = {}
            this.model.sms_confirmation = response.data
            this.tokenRequestedAt = (new Date()).getTime()
          }
        }).catch(error => {
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
      },
      sign_in_by: function () {
        if (this.model.sms_confirmation !== null) {
          return 'sms'
        }
        return 'password'
      }
    }
  }
</script>
