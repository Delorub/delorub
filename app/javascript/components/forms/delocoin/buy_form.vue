<script>
  export default {
    props: ['initialModel'],
    data: function () {
      return {
        model: this.initialModel,
        cost: null,
        canPay: false,
        packId: null,
        paymentType: this.initialModel.pay_type
      }
    },
    computed: {
      paramsForOmniauth () {
        return 'pack_id=' + this.packId + '&pay_type=' + this.paymentType
      }
    }
  }
</script>
