<template lang="pug">
  .input-group
    input.form-control.string.required(
      type="text"
      v-model="internalValue"
      ref="priceInput"
      maxlength="11"
      placeholder="300 000"
    )
    i.input-group-addon.fa.fa-rub(aria-hidden="true")
    slot(name="input" :value="normalizedValue")
</template>

<script>
  import Cleave from 'cleave.js'

  export default {
    props: {
      value: {
        default: ''
      }
    },
    data () {
      return {
        internalValue: this.value,
        priceCleave: null,
        priceCleaveConfig: {
          numeral: true,
          numeralPositiveOnly: true,
          delimiter: ' '
        }
      }
    },
    mounted () {
      this.priceCleave = new Cleave(this.$refs.priceInput, this.priceCleaveConfig)
      if (this.priceCleave.properties && this.priceCleave.properties.result) {
        this.internalValue = this.priceCleave.properties.result
      }
    },
    computed: {
      normalizedValue () {
        if (this.internalValue === '') {
          return ''
        }
        return parseInt(this.internalValue.replace(/\s/g, ''))
      }
    }
  }
</script>
