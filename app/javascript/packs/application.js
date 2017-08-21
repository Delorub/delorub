import './common'
import './visitor_sessions'
import './profiles'

import axios from 'axios'

import Vue from 'vue'
import VueMeta from 'vue-meta'

import flatPickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'

import CustomSelect from '../components/custom-select.vue'

import SmsConfirmation from '../components/sms_confirmation.vue'
import TaskForm from '../components/task_form.vue'
import ProfileForm from '../components/profile_form.vue'
import UploadForm from '../components/upload_form.vue'

import 'selectize'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

Vue.use(VueMeta)
Vue.component('custom-select', CustomSelect)
Vue.component('flat-pickr', flatPickr)

Vue.component('upload-form', UploadForm)
Vue.component('sms-confirmation', SmsConfirmation)

Vue.component('profile-form', ProfileForm)

document.addEventListener('DOMContentLoaded', () => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '#app',
    components: {
      TaskForm
    }
  })
})

window.ymapscallback = () => {
  let event

  if (document.createEvent) {
    event = document.createEvent('HTMLEvents')
    event.initEvent('ymapsLoaded', true, true)
  } else {
    event = document.createEventObject()
    event.eventType = 'ymapsLoaded'
  }

  event.eventName = 'ymapsLoaded'

  if (document.createEvent) {
    document.dispatchEvent(event)
  } else {
    document.fireEvent('on' + event.eventType, event)
  }
}
