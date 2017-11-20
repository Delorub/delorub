import '../lib/rollbar'

import './common'
import './visitor_sessions'

import axios from 'axios'

import Vue from 'vue'
import VueMeta from 'vue-meta'

import flatPickr from 'vue-flatpickr-component'
import 'flatpickr/dist/flatpickr.css'

import CustomSelect from '../components/fields/custom-select.vue'
import SelectBox from '../components/fields/selectbox.vue'
import DatetimePicker from '../components/fields/datetimepicker.vue'
import DatePicker from '../components/fields/datepicker.vue'
import BudgetPicker from '../components/fields/budget.vue'

import ProfileSpecializationsForm from '../components/forms/profile/specializations_form.vue'
import NewProfileForm from '../components/forms/profile/new_form.vue'
import EditProfileForm from '../components/forms/profile/edit_form.vue'
import ProfileFiltersForm from '../components/forms/profile/filters_form.vue'
import EditUserForm from '../components/forms/user/edit_form.vue'
import UserPhotoUpload from '../components/forms/user/photo_upload.vue'
import TaskForm from '../components/forms/task/edit_form.vue'
import TaskUploadForm from '../components/forms/task/upload_form.vue'
import TaskFiltersForm from '../components/forms/task/filters_form.vue'
import SignInForm from '../components/forms/user/sign_in_form.vue'
import DelocoinPackForm from '../components/forms/delocoin/pack_form.vue'
import DelocoinBuyForm from '../components/forms/delocoin/buy_form.vue'
import DelocoinPaymentForm from '../components/forms/delocoin/payment_form.vue'
import DelocoinOmniauthLinks from '../components/forms/delocoin/omniauth_links.vue'
import DelocoinChart from '../components/delocoin_chart.vue'

import TaskMap from '../components/task_map.vue'
import CustomPagination from '../components/custom-pagination.vue'
import SmsConfirmation from '../components/sms_confirmation.vue'
import CategorySuggest from '../components/fields/category_suggest.vue'
import TimerCountdown from '../components/timer_countdown.vue'

import RegionSelect from '../components/region_select.vue'
import CitySelect from '../components/city_select.vue'
import HideShowElement from '../components/hide_show_element.vue'

let token = document.getElementsByName('csrf-token')[0]
if (token !== undefined) {
  axios.defaults.headers.common['X-CSRF-Token'] = token.getAttribute('content')
}
axios.defaults.headers.common['Accept'] = 'application/json'

if (process.env.NODE_ENV === 'production') {
  Vue.config.devtools = false
  Vue.config.debug = false
  Vue.config.silent = true
  Vue.config.productionTip = false
}

Vue.use(VueMeta)

// Fields
Vue.component('datetimepicker', DatetimePicker)
Vue.component('budgetpicker', BudgetPicker)
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
Vue.component('delocoin-pack-form', DelocoinPackForm)
Vue.component('delocoin-buy-form', DelocoinBuyForm)
Vue.component('delocoin-payment-form', DelocoinPaymentForm)
Vue.component('delocoin-omniauth-links', DelocoinOmniauthLinks)
Vue.component('delocoin-chart', DelocoinChart)

Vue.component('task-form', TaskForm)
Vue.component('task-upload-form', TaskUploadForm)
Vue.component('task-filters-form', TaskFiltersForm)
Vue.component('task-map', TaskMap)
Vue.component('custom-pagination', CustomPagination)

Vue.component('category-suggest', CategorySuggest)
Vue.component('timer-countdown', TimerCountdown)
Vue.component('city-select', CitySelect)
Vue.component('sign-in-form', SignInForm)
Vue.component('region-select', RegionSelect)
Vue.component('hide-show-element', HideShowElement)
Vue.component('profile-filters-form', ProfileFiltersForm)

document.addEventListener('DOMContentLoaded', () => {
  // eslint-disable-next-line no-new
  new Vue({
    el: '#app',
    metaInfo: {
      title: document.title
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
