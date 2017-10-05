<script>
  export default {
    props: ['currentUrl', 'orderField', 'orderValue'],
    data: function () {
      return {
        redirectUrl: this.currentUrl + (this.orderValue !== '' ? '?' + this.orderField + '=' + this.orderValue : '')
      }
    },
    methods: {
      redirectToUrl () {
        window.location.href = this.redirectUrl
      }
    }
  }
</script>
