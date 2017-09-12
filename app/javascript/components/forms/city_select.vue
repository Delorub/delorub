<script>
import axios from 'axios'

export default {
  props: ['formCitySelected'],
  data: function () {
    return {
      placeId: '',
      citySelected: '',
      citiesList: [],
      citiesOptions: []
    }
  },
  mounted () {
    if ((this.formCitySelected !== undefined) && (this.formCitySelected.length > 0)) {
      this.citiesList = this.formCitySelected
      this.citiesOptions = this.citiesList.map(e => e.id)
      this.placeId = this.citiesList[0].id
    }
  },
  methods: {
    populateCities (city) {
      axios.post('/api/cities', {
        query: city
      }).then(response => {
        this.putCities(response.data)
      })
    },
    selectedCity (element) {
      var city = this.getCityById(element)
      this.citySelected = city.full_name
    },
    getCityById (id) {
      var result
      this.citiesList.every((e) => {
        if (parseInt(e.id) === parseInt(id)) {
          result = e
          return false
        }
        return true
      })
      return result
    },
    putCities (arrayCities) {
      this.citiesList = arrayCities
      this.citiesOptions = this.citiesList.map(e => e.id)
    },
    cityLabel (id) {
      var result
      this.citiesList.every((e) => {
        if (parseInt(e.id) === parseInt(id)) {
          result = e
          return false
        }
        return true
      })
      return result === undefined ? this.citySelected : result.full_name
    }
  }
}
</script>



