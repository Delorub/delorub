<script>
  export default {
    props: ['initialModel'],
    data: function () {
      return {
        model: this.initialModel,
        cost: null
      }
    }
  }
</script>
