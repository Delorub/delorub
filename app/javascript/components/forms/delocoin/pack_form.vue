<template lang="pug">
  div
    slot(name="input" :value="internalValue")
    table.table.table-buy
      thead
        tr
          th
          th
            div
              | Стоимость 
              br
              | пакета
          th
            div Дисконт
          th
            div
              | Стоимость
              br
              | монеты ₽
          th
            div
              | Количество 
              br
              | монет
          th
            div
              | Стоимость монет ₽ на {{ lastStepNumber }}
              br/
              | этапе, {{ formatNumber(lastStepDelocoinCost) }} Р/монета
      tbody
        template(v-for="pack in packsList")
          tr(@click="internalValue = pack.id" :class="(pack.id == internalValue) ? 'checked' : ''")
            td(colspan="2")
              .form-check
                .dr-radio.form-group
                  input(name="optionsRadios" @click="internalValue = pack.id" type="radio" :checked="pack.id == internalValue")
                  label(@click="internalValue = pack.id") {{ formatNumber(pack.cost) }}
                  .check
            td
              div
                template(v-if="pack.discount_in_percents == 0")
                  | -
                template(v-else="")
                  | {{ '-' + pack.discount_in_percents + ' %' }}
            td {{ formatFloatNumber(pack.one_delocoin_cost) }}
            td {{ formatNumber(pack.delocoin_amount) }}
            td {{ formatNumber(pack.delocoin_cost_on_last_step) }}
</template>
<script>
  import numeral from 'lib/numeral'

  export default {
    props: [
      'packsList', 'value', 'lastStepDelocoinCost', 'lastStepNumber'
    ],
    data: function () {
      return {
        internalValue: this.value
      }
    },
    mounted () {
      let pack = this.packsList.find(e => e.id === this.internalValue)
      if (pack !== undefined) {
        this.$emit('cost', pack.cost)
      }
    },
    methods: {
      formatNumber (number) {
        return numeral(number).format('0,0')
      },
      formatFloatNumber (number) {
        return numeral(number).format('0,0.[00]')
      }
    },
    watch: {
      internalValue (value) {
        let pack = this.packsList.find(e => e.id === value)

        this.$emit('value', pack.id)
        this.$emit('cost', pack.cost)
      }
    }
  }
</script>
