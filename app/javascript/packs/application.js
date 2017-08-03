import './common'
import './visitor_sessions'

import axios from 'axios'

import Vue from 'vue'
import VueMeta from 'vue-meta'

import SmsConfirmation from '../components/sms_confirmation.vue'
import TaskForm from '../components/task_form.vue'
import PriceSlider from '../components/price_slider.vue'
import UploadForm from '../components/upload_form.vue'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

Vue.use(VueMeta)
Vue.component('upload-form', UploadForm)
Vue.component('sms-confirmation', SmsConfirmation)
Vue.component('price-slider', PriceSlider)

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
