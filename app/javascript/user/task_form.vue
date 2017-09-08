<script>
import formTooltips from 'mixins/form_tooltips'
import yandexMap from 'mixins/yandex_map'

export default {
  mixins: [formTooltips, yandexMap],
  props: [
    'initialModel', 'categoriesList', 'dateTypesList'
  ],
  data: function () {
    return {
      model: this.initialModel,
      map: null,
      placemark: null,
      suggestView: null,
      subcategories: [],
      placeSuggestions: [],
      placeLoading: false,
      datepickerConfig: {
        allowInput: true,
        enableTime: false,
        dateFormat: 'd.m.Y',
        wrap: true
      }
    }
  },
  mounted () {
    this.populateSubcategories(this.model.category_id)
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
    },
    populatePlaces (text) {
      if (!this.ymaps) return
      this.placeLoading = true
      this.ymaps.suggest(text).then((items) => {
        this.placeSuggestions = items.map((e) => e.displayName)
        this.placeLoading = false
      })
    },
    populateSubcategories (selected) {
      if (selected !== this.model.category_id) {
        this.model.subcategory_ids = []
      }
      this.subcategories = this.categoriesList.filter(e => e.parent_id === parseInt(selected)).map(e => e.value)
    },
    categoryLabel (id) {
      var result
      this.categoriesList.every((e) => {
        if (parseInt(e.value) === parseInt(id)) {
          result = e
          return false
        }
        return true
      })
      return result.label
    },
    dateTypeLabel (id) {
      var result
      this.dateTypesList.every((e) => {
        if (String(e.value) === String(id)) {
          result = e
          return false
        }
        return true
      })
      return result.label
    },
    limitSubcategoriesText (count) {
      return `Выбрано ${count} подкатегорий`
    }
  }
}
</script>
