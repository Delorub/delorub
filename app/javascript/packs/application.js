import './common'
import './visitor_sessions'
import './profile'

import axios from 'axios'

import Vue from 'vue'
import VueMeta from 'vue-meta'

import flatPickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'

import CustomSelect from '../components/fields/custom-select.vue'
import SelectBox from '../components/fields/selectbox.vue'
import DatetimePicker from '../components/fields/datetimepicker.vue'
import DatePicker from '../components/fields/datepicker.vue'

import ProfileSpecializationsForm from '../components/forms/profile/specializations_form.vue'
import NewProfileForm from '../components/forms/profile/new_form.vue'
import EditProfileForm from '../components/forms/profile/edit_form.vue'
import EditUserForm from '../components/forms/user/edit_form.vue'
import UserPhotoUpload from '../components/forms/user/photo_upload.vue'
import TaskForm from '../components/forms/task/edit_form.vue'
import TaskUploadForm from '../components/forms/task/upload_form.vue'
import SignInForm from '../components/forms/user/sign_in_form.vue'

import TaskMap from '../components/task_map.vue'
import SmsConfirmation from '../components/sms_confirmation.vue'
import CategorySuggest from '../components/fields/category_suggest.vue'
import TimerCountdown from '../components/timer_countdown.vue'

import CitySelect from '../components/city_select.vue'

let token = document.getElementsByName('csrf-token')[0]
if (token !== undefined) {
  axios.defaults.headers.common['X-CSRF-Token'] = token.getAttribute('content')
}
axios.defaults.headers.common['Accept'] = 'application/json'

Vue.use(VueMeta)

// Fields
Vue.component('datetimepicker', DatetimePicker)
Vue.component('datepicker', DatePicker)
Vue.component('selectbox', SelectBox)

Vue.component('custom-select', CustomSelect)
Vue.component('flat-pickr', flatPickr)

Vue.component('sms-confirmation', SmsConfirmation)

Vue.component('new-profile-form', NewProfileForm)
Vue.component('edit-profile-form', EditProfileForm)
Vue.component('edit-user-form', EditUserForm)
Vue.component('user-photo-upload', UserPhotoUpload)
Vue.component('profile-specializations-form', ProfileSpecializationsForm)

Vue.component('task-form', TaskForm)
Vue.component('task-upload-form', TaskUploadForm)
Vue.component('task-map', TaskMap)

Vue.component('category-suggest', CategorySuggest)
Vue.component('timer-countdown', TimerCountdown)
Vue.component('city-select', CitySelect)
Vue.component('sign-in-form', SignInForm)

document.addEventListener('DOMContentLoaded', () => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '#app'
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
