<template>
  <div class="sliderHandler">
    <div ref="slider">
    </div>
  </div>
</template>
<script>
import noUiSlider from 'nouislider'
import _ from 'lodash'

export default {
  props: [
    'url'
  ],
  data: function () {
    return {
      asd: 'asd',
      steps: [
        { title: 'Малый бюджет', step: 500 },
        { title: 'Средний бюджет', step: 2000 },
        { title: 'Большой бюджет', step: 10000 },
        { title: 'Громадный бюджет', step: 100000 }
      ]
    }
  },
  mounted () {
    noUiSlider.create(this.$refs.slider, {
      range: this.sliderRanges(),
      start: 500,
      snap: true,
      pips: {
        mode: 'positions',
        values: this.pipValues(),
        density: 1000000,
        stepped: true,
        format: {
          to: (value) => {
            let currentStep = _.find(this.steps, (step) => (
              step.step === value
            ))
            return currentStep.title
          }
        }
      }
    })
  },
  methods: {
    pipValues: function () {
      let result = []
      for (let i = 0; i < this.steps.length; i++) {
        result[i] = (i / (this.steps.length - 1)) * 100
      }
      return result
    },
    sliderRanges: function () {
      let result = {}
      for (let i = 0; i < this.steps.length; i++) {
        let key
        if (i === 0) key = 'min'
        else if (i === this.steps.length - 1) key = 'max'
        else key = ((i / (this.steps.length - 1)) * 100) + '%'
        result[key] = this.steps[i].step
      }

      return result
    }
  }
}
</script>

<style lang="scss">
  @import "nouislider/distribute/nouislider.css";

  .sliderHandler {
    height: 50px
  }
</style>
