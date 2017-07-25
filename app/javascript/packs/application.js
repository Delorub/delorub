import './common'
import './coming_soon'
import Vue from 'vue'
import axios from 'axios'
import SmsConfirmation from '../components/sms_confirmation.vue'
import TaskForm from '../components/task_form.vue'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

document.addEventListener('DOMContentLoaded', () => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '#app',
    components: {
      TaskForm,
      SmsConfirmation
    }
  })
})
