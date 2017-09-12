<template lang="pug">
  div
    selectbox(
      v-model="placeId"
      :searchable="true"
      placeholder="Выберите город"
      :options="citiesOptions"
      :custom-label='cityLabel'
      @select='selectedCity'
      @search-change='populateCities'
      :clear-on-select="false"
    )
    slot(name="input" :id="placeId")
</template>

<script>
import axios from 'axios'

export default {
  props: ['id', 'formCitySelected'],
  data: function () {
    return {
      placeId: this.id === undefined ? null : this.id,
      citySelected: '',
      citiesOptions: [],
      citiesList: []
    }
  },
  mounted () {
    if ((this.formCitySelected !== undefined) && (this.formCitySelected.length > 0)) {
      this.putCities(this.formCitySelected)
      this.placeId = this.citiesList[0].value
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
      this.citySelected = city.label
    },
    getCityById (id) {
      var result
      this.citiesList.every((e) => {
        if (parseInt(e.value) === parseInt(id)) {
          result = e
          return false
        }
        return true
      })
      return result
    },
    putCities (arrayCities) {
      this.putFormattedList(arrayCities)
      this.citiesOptions = this.citiesList.map(e => e.value)
    },
    putFormattedList (arrayCities) {
      var nameLengths = arrayCities.map(function (e) {
        return {value: e.id, label: e.full_name}
      })
      this.citiesList = nameLengths
    },
    cityLabel (id) {
      var result
      this.citiesList.every((e) => {
        if (parseInt(e.value) === parseInt(id)) {
          result = e
          return false
        }
        return true
      })
      return result === undefined ? this.citySelected : result.label
    }
  }
}
</script>



