<template lang="pug">  
  input(
    type="text"
    ref="priceInput"
    maxlength="15"
    placeholder="300 000"
    class="form-control string required"
  )
</template>

<script>
  import Cleave from 'cleave.js'

  export default {
    data () {
      return {
        priceCleave: null,
        priceCleaveConfig: {
          numericOnly: true,
          blocks: [3, 3, 3, 3],
          delimeter: ' '
        }
      }
    },
    mounted () {
      this.priceCleave = new Cleave(this.$refs.priceInput, this.priceCleaveConfig)
    }
  }
</script>
