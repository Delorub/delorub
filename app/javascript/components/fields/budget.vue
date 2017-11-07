<template lang="pug">  
  input.form-control.string.required(
    type="text"
    ref="priceInput"
    maxlength="11"
    placeholder="300 000"
  )
</template>

<script>
  import Cleave from 'cleave.js'

  export default {
    data () {
      return {
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
    }
  }
</script>
