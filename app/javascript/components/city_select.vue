<template lang="pug">
  div
    selectbox(
      v-model="placeId"
      :searchable="true"
      placeholder="Выберите город"
      :options="citiesOptions"
      :labels="citiesList"
      @search-change='populateCities'
      :clear-on-select="false"
    )
    slot(name="input" :value="placeId")
</template>

<script>
import axios from 'axios'

export default {
  props: ['value', 'formCitySelected'],
  data: function () {
    return {
      placeId: this.value === undefined ? null : this.value,
      citySelected: '',
      citiesOptions: [],
      citiesList: this.formCitySelected !== undefined ? this.putFormattedList(this.formCitySelected) : []
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
    putCities (arrayCities) {
      this.citiesList = this.putFormattedList(arrayCities)
      this.citiesOptions = this.citiesList.map(e => e.value)
    },
    putFormattedList (arrayCities) {
      var formattedList = arrayCities.map(function (e) {
        return {value: e.id, label: e.full_name}
      })
      return formattedList
    }
  }
}
</script>



