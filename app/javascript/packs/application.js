import $ from 'jquery';
import "bootstrap-slider/dist/bootstrap-slider.js";
import "bootstrap-slider/dist/css/bootstrap-slider.css";
import 'bootstrap/dist/js/bootstrap.js';
import 'app';
import './common'
import Vue from 'vue'
import axios from 'axios'
import SmsConfirmation from '../components/sms_confirmation.vue'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common['Accept'] = 'application/json'

document.addEventListener('DOMContentLoaded', () => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '#app',
    components: {
      'sms-confirmation': SmsConfirmation
    }
  })
})
