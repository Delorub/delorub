<template lang="pug">
  div
    div.form-group
      div.input-group.date
        flat-pickr(v-model="dateValue" :config="datepickerConfig")
        div.vertical-hr
        input(
          type="text"
          ref="timeInputHour"
          v-model="timeValueHour"
          maxlength="2"
          placeholder="12"
          class="form-control date-time date-time-hour"
          @keypress="inputHour"
          @blur="blurTime"
        )
        span
          | :
        input(
          type="text"
          ref="timeInputMinute"
          v-model="timeValueMinute"
          maxlength="2"
          placeholder="00"
          class="form-control date-time date-time-minute"
          @keypress="inputMinute"
          @blur="blurTime"
        )
        slot(name="input" :value="internalValue")
    div.form-group__sublink
      a(href="#" @click.prevent="setToday" :class="todayLinkClass")  сегодня
      a(href="#" @click.prevent="setTomorrow" :class="tomorrowLinkClass") завтра
</template>

<script>
  import flatPickr from 'vue-flatpickr-component'
  import 'flatpickr/dist/flatpickr.css'
  import moment from 'lib/moment'

  export default {
    props: ['value'],
    data () {
      return {
        internalValue: moment(this.value).toISOString(),
        timeValueHour: moment(this.internalValue).format('HH'),
        timeValueMinute: moment(this.internalValue).format('mm'),
        datepickerConfig: {
          enableTime: false,
          disableMobile: true,
          allowInput: false,
          time_24hr: true,
          minDate: 'today',
          maxDate: new Date().fp_incr(365),
          dateFormat: 'd.m.Y',
          locale: {
            firstDayOfWeek: 1,
            weekdays: {
              shorthand: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
              longhand: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота']
            },
            months: {
              shorthand: ['Янв', 'Фев', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
              longhand: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
            }
          }
        }
      }
    },
    methods: {
      setToday () {
        let date = moment()
        this.internalValue = moment(this.internalValue)
          .set('date', date.date())
          .set('month', date.month())
          .set('year', date.year())
          .toISOString()
      },
      setTomorrow () {
        let date = moment().add(1, 'days')
        this.internalValue = moment(this.internalValue)
          .set('date', date.date())
          .set('month', date.month())
          .set('year', date.year())
          .toISOString()
      },
      isNumeric (evt) {
        var regex = /[0-9]|\./
        if (!regex.test(evt.key)) {
          return false
        }
        return true
      },
      blurTime (evt) {
        if (this.timeValueHour.length === 0) {
          this.timeValueHour = '00'
        } else
        if (this.timeValueHour.length === 1) {
          this.timeValueHour = '0' + this.timeValueHour
        }

        if (this.timeValueMinute.length === 0) {
          this.timeValueMinute = '00'
        } else
        if (this.timeValueMinute.length === 1) {
          this.timeValueMinute = '0' + this.timeValueMinute
        }
      },
      inputHour (evt) {
        if (!this.isNumeric(evt)) {
          evt.preventDefault()
          return
        }
        var digit = parseInt(evt.key)

        if (this.timeValueHour.length === 2) {
          evt.preventDefault()
        }

        if (digit >= 3 && (this.timeValueHour.length === 0)) {
          if (this.timeValueHour !== '0' + evt.key) {
            this.timeValueHour = '0' + evt.key
          }
          this.$refs.timeInputMinute.focus()
          return
        }

        if (this.timeValueHour === '2') {
          if (digit > 3) {
            this.timeValueHour = '02'
            this.$refs.timeInputMinute.focus()
            evt.preventDefault()
          }
        }
      },
      inputMinute (evt) {
        if (!this.isNumeric(evt)) {
          evt.preventDefault()
          return
        }
        var digit = parseInt(evt.key)

        if (digit >= 6 && (this.timeValueMinute.length === 0 || this.timeValueMinute.length === 2)) {
          evt.preventDefault()
        }
      }
    },
    computed: {
      dateValue: {
        get: function () {
          return moment(this.internalValue).format('DD.MM.YYYY')
        },
        set: function (newValue) {
          let date = moment(newValue, 'DD.MM.YYYY')
          this.internalValue = moment(this.internalValue)
            .set('date', date.date())
            .set('month', date.month())
            .set('year', date.year())
            .toISOString()
        }
      },
      todayLinkClass () {
        let today = moment()

        if (today.isSame(moment(this.internalValue), 'd')) {
          return 'datetimepicker-date-active'
        }
      },
      tomorrowLinkClass () {
        let tomorrow = moment().add(1, 'days')

        if (tomorrow.isSame(moment(this.internalValue), 'd')) {
          return 'datetimepicker-date-active'
        }
      }
    },
    watch: {
      internalValue () {
        this.$emit('input', this.internalValue)
      },
      timeValueHour (newVal) {
        if (newVal.length < 2) {
          return
        }
        if (newVal.length === 2) {
          if (parseInt(newVal[0]) >= 3) {
            this.timeValueHour = '0' + newVal[0]
          } else if (parseInt(newVal[0]) === 2 && parseInt(newVal[1]) > 3) {
            this.timeValueHour = '0' + newVal[0]
          }
          this.$refs.timeInputMinute.focus()
        }
        let hours = moment(this.timeValueHour, 'HH')
        this.internalValue = moment(this.internalValue)
          .set('hour', hours.hour())
          .toISOString()
      },
      timeValueMinute (newVal) {
        if (newVal.length < 2) {
          return
        }
        if (newVal.length === 2) {
          if (parseInt(newVal[0]) >= 6) {
            this.timeValueMinute = '0' + newVal[0]
          }
        }
        let minutes = moment(this.timeValueMinute, 'mm')
        this.internalValue = moment(this.internalValue)
          .set('minute', minutes.minute())
          .toISOString()
      }
    },
    components: {
      flatPickr
    }
  }
</script>
<style lang="scss">
  .datetimepicker-date-active {
    color: #aaa !important;
    text-decoration: none !important;
  }
</style>
