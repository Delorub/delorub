<template lang="pug">
  div
    slot(name="input" :value="internalValue")
    .choose-payment__pocket(v-if="showBalancePayment")
      .choose-payment__card(:class="paymentCheckedClass('balance')" @click="paymentSelect('balance')")
        .money-pocket
          h4 Кошелек
          .delocoin-current
            img(alt="" src="/images/icons/ruble.svg")
            div
              span.delocoin-current__value-big {{ formatNumber(balance) }}
      .dr-popover.dr-popover-left(v-if="this.internalValue == 'balance' && !haveEnoughBalance")
        .dr-popover__text
          | На вашем балансе недостаточно средств! Выберите другой способ оплаты.
    hr
    br
    .choose-payment
      .choose-payment-row
        .choose-payment__card(
          v-for="paymentType in paymentTypeList"
          v-if="paymentType != 'balance'"
          :class="paymentCheckedClass(paymentType)"
          @click="paymentSelect(paymentType)"
        )
          .choose-payment__image
            img(alt="" :src="imageForPaymentType(paymentType)")
</template>
<script>
  import numeral from 'lib/numeral'

  export default {
    props: [
      'value', 'paymentTypeList', 'balance', 'cost'
    ],
    data: function () {
      return {
        internalValue: this.value
      }
    },
    mounted () {
      this.$emit('can-pay', this.canPay)
    },
    methods: {
      paymentCheckedClass (payment) {
        return this.internalValue === payment ? 'checked' : ''
      },
      imageForPaymentType (paymentType) {
        return '/images/payment/' + paymentType + '.png'
      },
      paymentSelect (payment) {
        this.internalValue = payment
      },
      formatNumber (number) {
        return numeral(number).format('0,0')
      }
    },
    computed: {
      haveEnoughBalance () {
        return this.cost <= this.balance
      },
      canPay () {
        if (this.internalValue !== 'balance') return true
        return this.haveEnoughBalance
      },
      showBalancePayment () {
        return this.paymentTypeList.find(e => e === 'balance')
      },
      paymentTypeListToDisplay () {
        return this.paymentTypeList.every(e => e !== 'balance')
      }
    },
    watch: {
      canPay(value) {
        this.$emit('can-pay', value)
      }
    }
  }
</script>
