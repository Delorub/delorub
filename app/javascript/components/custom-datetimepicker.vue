<template>
  <div class="input-group date">
    <label class="date-addon"></label>
    <flat-pickr v-model="dateValue" :config="datepickerConfig">
    </flat-pickr>
    <div class="vertical-hr"></div>
    <input type="time" ref="timeInput" v-model="timeValue" maxlength="5" placeholder="Время" class="form-control date-time">
  </div>
</template>

<script>
  import flatPickr from 'vue-flatpickr-component'
  import 'flatpickr/dist/flatpickr.css'
  import Cleave from 'cleave.js'
  import moment from 'moment'

  export default {
    props: ['value'],
    data () {
      return {
        dateValue: moment(this.value, 'DD-MM-YYYY hh:mm').format('DD.MM.YYYY'),
        timeValue: moment(this.value, 'DD-MM-YYYY hh:mm').format('hh:mm'),
        timeCleave: null,
        timeCleaveConfig: {
          numericOnly: true,
          blocks: [2, 2],
          delimiter: ':'
        },
        datepickerConfig: {
          allowInput: true,
          enableTime: false,
          dateFormat: 'd.m.Y'
        }
      }
    },
    mounted () {
      this.timeCleave = new Cleave(this.$refs.timeInput, this.timeCleaveConfig)
    },
    methods: {
      updateValue () {
        this.$emit('input', this.dateValue + ' ' + this.timeValue)
      },
      setToday () {
        this.dateValue = moment().format('DD.MM.YYYY')
      },
      setTomorrow () {
        this.dateValue = moment().add(1, 'days').format('DD.MM.YYYY')
      }
    },
    watch: {
      dateValue () {
        this.updateValue()
      },
      timeValue () {
        this.updateValue()
      }
    },
    components: {
      flatPickr
    }
  }
</script>
