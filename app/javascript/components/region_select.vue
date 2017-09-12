<template>
  <span>
    <custom-select
      v-model="regionValue"
      :options="regionsOptions"
      placeholder="Выберите регион"
      :searchable='true'
      @select="selectedRegion"
      @search-change="populateRegions">
      <span slot="noResult">
        <p> Не найдено совпадений </p>
      </span>
    </custom-select>
    <custom-select
      v-model="cityValue"
      :options="citiesOptions"
      placeholder="Выберите город"
      :searchable="true"
      @select="selectedCity"
      @search-change="populateCities">
      <span slot="noResult">
        <p> Не найдено совпадений </p>
      </span>
    </custom-select>
  </span>
</template>

<script>
import axios from 'axios'

export default {
  props: ['regionSelected', 'citySelected', 'redirectUrl'],
  data: function () {
    return {
      cityValue: '',
      regionValue: '',
      regionsList: [],
      citiesList: [],
      regionsOptions: [],
      citiesOptions: []
    }
  },
  mounted () {
    this.cityValue = this.citySelected
    this.regionValue = this.regionSelected

    if (this.citySelected !== '') {
      axios.post('/api/regions', {
        query: this.regionValue
      }).then(response => {
        if (response.data.length > 0) {
          this.regionsList = response.data
          this.selectedRegion(this.regionValue)
        }
      })
    }
  },
  methods: {
    populateRegions (region) {
      axios.post('/api/regions', {
        query: region
      }).then(response => {
        this.regionsList = response.data
        this.regionsOptions = this.regionsList.map((e) => e.full_name)
      })
    },
    populateCities (city) {
      if (this.regionValue === '') {
        axios.post('/api/cities', {
          query: city
        }).then(response => {
          this.putCities(response.data)
        })
      }
    },
    selectedRegion (selected) {
      var region = this.getRegionByFullName(selected)
      this.putCities(region.cities)
    },
    selectedCity (element) {
      window.location.href = '/' + this.getCity(element).slug + this.redirectUrl
    },
    getCity (cityName) {
      var result
      this.citiesList.every((e) => {
        if (e.name === cityName) {
          result = e
          return false
        }
        return true
      })
      return result
    },
    getRegionByFullName (name) {
      var result
      this.regionsList.every((e) => {
        if (e.full_name === name) {
          result = e
          return false
        }
        return true
      })
      return result
    },
    putCities (arrayCities) {
      this.citiesList = arrayCities
      this.citiesOptions = this.citiesList.map(e => e.name)
    }
  }
}
</script>

