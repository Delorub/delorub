<template>
  <span>
    <custom-select
      v-model="regionValue"
      :options="regionsOptions"
      placeholder="Выберите регион"
      :searchable='true'
      @select="selectedRegion">
      <span slot="noResult">
        <p> Не найдено совпадений </p>
      </span>
    </custom-select>
    <custom-select
      v-model="cityValue"
      :options="citiesOptions"
      placeholder="Выберите город"
      :searchable="true"
      @select="selectedCity">
      <span slot="noResult">
        <p> Не найдено совпадений </p>
      </span>
    </custom-select>
  </span>
</template>

<script>
export default {
  props: ['citiesList', 'regionsList', 'citySelected', 'redirectUrl'],
  data: function () {
    return {
      cityValue: '',
      regionValue: '',
      regionsOptions: [],
      citiesOptions: []
    }
  },
  mounted () {
    console.log(this.citySelected)
    this.cityValue = this.citySelected
    if (this.citySelected !== '') {
      this.regionValue = this.getRegionName(this.getCity(this.citySelected).region_id)
      this.selectedRegion(this.regionValue)
    } else {
      this.citiesOptions = this.citiesList.map((e) => e.name)
    }
    this.regionsOptions = this.regionsList.map((e) => e.name)
  },
  methods: {
    selectedRegion (selected) {
      this.citiesOptions = this.citiesList.filter(e => e.region_id === parseInt(this.getRegionId(selected))).map(e => e.name)
    },
    selectedCity (element) {
      window.location.href = '/' + this.getCity(element).code + this.redirectUrl
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
    getRegionName (regionId) {
      var result
      this.regionsList.every((e) => {
        if (e.id === regionId) {
          result = e
          return false
        }
        return true
      })
      return result.name
    },
    getRegionId (regionName) {
      var result
      this.regionsList.every((e) => {
        if (e.name === regionName) {
          result = e
          return false
        }
        return true
      })
      return result.id
    }
  }
}
</script>

