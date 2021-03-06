<script>
  import formTooltips from 'mixins/form_tooltips'
  import yandexMap from 'mixins/yandex_map'
  import axios from 'axios'

  export default {
    mixins: [formTooltips, yandexMap],
    props: [
      'initialModel', 'categories'
    ],
    data: function () {
      return {
        model: this.initialModel,
        map: null,
        placemark: null,
        suggestView: null,
        placeSuggestions: [],
        citiesList: [],
        placeLoading: false
      }
    },
    mounted () {
      this.showTooltip('task_title')
    },
    methods: {
      initializeMap () {
        this.$refs.placeMap.classList.remove('hidden')
        this.map = new this.ymaps.Map(this.$refs.placeMap, {
          center: this.yandexMap.defaultCenter,
          zoom: 10
        })
        this.positionPopover()
        this.map.events.add('click', (event) => {
          this.showTooltip('task_place_address')
          this.placeByCoords(event.get('coords'))
        })
        this.map.events.add(['actionbegin', 'contextmenu'], (event) => {
          this.showTooltip('task_place_address')
        })
        if (this.model.place_lat && this.model.place_long) {
          let coordinates = [this.model.place_lat, this.model.place_long]
          this.placemark = new this.ymaps.Placemark(coordinates)
          this.map.geoObjects.add(this.placemark)
          this.map.setCenter(coordinates, 13)
        }
      },
      placeBySelect (element) {
        if (!this.ymaps) return
        if (!element) {
          this.placeGeoObject(null)
        }
        this.ymaps.geocode(element).then(
          (result) => { this.placeGeoObject(result.geoObjects.get(0), false) }
        )
      },
      placeByCoords (request) {
        if (!this.ymaps) return
        if (!request) {
          this.placeGeoObject(null)
        }
        this.ymaps.geocode(request).then(
          (result) => { this.placeGeoObject(result.geoObjects.get(0), true, false) }
        )
      },
      placeGeoObject (geoObject, changeAddress = true, changeCenter = true) {
        if (!geoObject) {
          this.model.place_lat = null
          this.model.place_long = null
          this.map.geoObjects.remove(this.placemark)
          this.placemark = null
          return
        }
        let name = geoObject.properties.get('metaDataProperty.GeocoderMetaData.AddressDetails.Country.AddressLine')
        let coordinates = geoObject.geometry.getCoordinates()
        let placemark = new this.ymaps.Placemark(coordinates)

        this.map.geoObjects.remove(this.placemark)
        this.map.geoObjects.add(placemark)
        this.placemark = placemark

        if (changeCenter) {
          this.map.setCenter(coordinates, 13)
        }

        if (changeAddress) {
          this.model.place_address = name
        }
        this.model.place_lat = coordinates[0]
        this.model.place_long = coordinates[1]

        var region = geoObject.properties.get('metaDataProperty.GeocoderMetaData.AddressDetails.Country.AdministrativeArea.AdministrativeAreaName')
        var city = geoObject.getLocalities()[0]
        this.model.place_id = null
        if (city === region) {
          axios.post('/api/cities', {
            query: region
          }).then(response => {
            this.recognizeCity(response.data, city)
          })
        } else {
          axios.post('/api/regions', {
            query: region
          }).then(response => {
            var arrayCities = response.data.length > 0 ? response.data[0].cities : []
            this.recognizeCity(arrayCities, city)
          })
        }
      },
      populatePlaces (text) {
        if (!this.ymaps) return
        this.placeLoading = true
        this.ymaps.suggest(text).then((items) => {
          this.placeSuggestions = items.map((e) => e.displayName)
          this.placeLoading = false
        })
      },
      recognizeCity (arrayCities, city) {
        this.citiesList = arrayCities
        this.model.place_id = this.getCityId(city)
        var errorEl = document.getElementById('map_error')
        errorEl.innerHTML = ''
        if (this.model.place_id === '') {
          errorEl.innerHTML = 'На данный момент города нет в нашей базе'
        }
      },
      getCityId (cityName) {
        var result
        this.citiesList.every((e) => {
          if (e.name === cityName) {
            result = e
            return false
          }
          return true
        })
        return result === undefined ? '' : result.id
      },
      limitSubcategoriesText (count) {
        return `Выбрано ${count} подкатегорий`
      }
    },
    computed: {
      availableSubcategoriesIds () {
        return this.categories
          .filter(e => e.parent_id === parseInt(this.model.category_id))
          .map(e => e.value)
      },
      availableCategoriesIds () {
        return this.categories
          .filter(e => e.parent_id === null)
          .map(e => e.value)
      },
      isSubcategorySelectDisabled () {
        return !this.model.category_id || this.availableSubcategoriesIds.length === 0
      }
    },
    watch: {
      'model.category_id': function (newValue) {
        this.model.subcategory_ids = []
      }
    }
  }
</script>
