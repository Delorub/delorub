<script>
  import baseForm from './form'

  export default {
    mixins: [baseForm],
    props: ['selectedCity'],
    data: function () {
      return {
        placeId: ''
      }
    },
    mounted: function () {
      this.placeId = this.selectedCity
    }
  }
</script>
