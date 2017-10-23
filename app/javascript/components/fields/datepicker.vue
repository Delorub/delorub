<template lang="pug">
  div.input-group.date
    label.date-addon
    flat-pickr(
      ref="component"
      :config="datepickerConfig"
      v-bind="$attrs"
      v-bind:value="internalValue"
      @input="updateValue"
    )
    slot(:value="inputValue")
</template>

<script>
  import flatPickr from 'vue-flatpickr-component'
  import 'flatpickr/dist/flatpickr.css'
  import moment from 'lib/moment'

  export default {
    props: {
      value: {
        default: undefined
      },
      inputFormat: {
        default: 'YYYY-MM-DD'
      },
      datepickerFormat: {
        default: 'DD.MM.YYYY'
      }
    },
    data: function () {
      let internalValue

      if (this.value !== undefined && this.value !== '') {
        internalValue = moment(this.value, this.inputFormat).format(this.datepickerFormat)
      }

      return {
        internalValue: internalValue,
        datepickerConfig: {
          disableMobile: true,
          allowInput: false,
          enableTime: false,
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
      updateValue (value) {
        this.internalValue = value
      }
    },
    computed: {
      inputValue: function () {
        if (this.internalValue === undefined || this.internalValue === '') {
          return
        }
        return moment(this.internalValue, this.datepickerFormat).format(this.inputFormat)
      }
    },
    components: {
      flatPickr
    }
  }
</script>
