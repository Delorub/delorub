<script>
export default {
  props: ['citiesList', 'citySelected', 'redirectUrl'],
  data: function () {
    return {
      cityValue: ''
    }
  },
  mounted () {
    this.cityValue = this.citySelected
  },
  methods: {
    populateCities (element) {
      window.location.href = '/'+this.getCode(element)+this.redirectUrl
    },
    getCode (cityName) {
      var result
      this.citiesList.every((e) => {
        if (e.name === cityName) {
          result = e
          return false
        }
        return true
      })
      return result.code
    }
  }
}
</script>

