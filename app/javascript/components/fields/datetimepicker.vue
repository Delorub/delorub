<template lang="pug">
  div
    div.form-group
      div.input-group.date
        label.date-addon
        flat-pickr(v-model="dateValue" :config="datepickerConfig")
        div.vertical-hr
        input(
          type="text"
          ref="timeInput"
          v-model="timeValue"
          maxlength="5"
          placeholder="Время"
          class="form-control date-time"
        )
        slot(name="input" :value="internalValue")
    div.form-group__sublink
      a(href="#" @click.prevent="setToday" :class="todayLinkClass")  сегодня
      a(href="#" @click.prevent="setTomorrow" :class="tomorrowLinkClass") завтра
</template>

<script>
  import flatPickr from 'vue-flatpickr-component'
  import 'flatpickr/dist/flatpickr.css'
  import Cleave from 'cleave.js'
  import moment from 'lib/moment'

  export default {
    props: ['value'],
    data () {
      return {
        internalValue: moment(this.value).toISOString(),
        timeCleave: null,
        timeCleaveConfig: {
          numericOnly: true,
          blocks: [2, 2],
          delimiter: ':'
        },
        datepickerConfig: {
          disableMobile: true,
          allowInput: true,
          enableTime: false,
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
    mounted () {
      this.timeCleave = new Cleave(this.$refs.timeInput, this.timeCleaveConfig)
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
      timeValue: {
        get: function () {
          return moment(this.internalValue).format('HH:mm')
        },
        set: function (newValue) {
          let date = moment(newValue, 'HH:mm')
          this.internalValue = moment(this.internalValue)
            .set('hour', date.hour())
            .set('minute', date.minute())
            .set('second', date.second())
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
