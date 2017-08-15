<script>
import Tether from 'tether'
import _ from 'lodash'

export default {
  props: [
    'initialModel', 'categoriesList'
  ],
  data: function () {
    return {
      model: this.initialModel,
      popoverTether: null,
      map: null,
      ymaps: null,
      placemark: null,
      suggestView: null,
      subcategories: [],
      datepickerConfig: {
        enableTime: true,
        dateFormat: 'd.m.Y H:i',
        time_24hr: true,
        wrap: true
      }
    }
  },
  metaInfo: {
    script: [
      { src: 'https://api-maps.yandex.ru/2.1/?lang=ru_RU&onload=ymapscallback' }
    ]
  },
  mounted () {
    document.addEventListener('ymapsLoaded', (e) => {
      if (global.ymaps !== undefined) {
        this.ymaps = global.ymaps
        this.initializeMap()
      }
    })
    this.populateSubcategories({ value: this.model.main_category_id })
    this.showTooltip('task_title')
  },
  methods: {
    initializeMap () {
      this.$refs.placeMap.classList.remove('hidden')
      this.map = new this.ymaps.Map(this.$refs.placeMap, {
        center: [59.94, 30.32],
        zoom: 12
      })
      this.positionPopover()
      this.map.events.add('click', (event) => {
        this.showTooltip('task_place_address')
        this.placeByCoords(event.get('coords'))
      })
      this.map.events.add(['actionbegin', 'contextmenu'], (event) => {
        this.showTooltip('task_place_address')
      })

      this.suggestView = new this.ymaps.SuggestView(this.$refs.suggestAddress)
      this.suggestView.events.add('select', (e) => {
        this.placeByAddress(e.get('item').value)
      })
    },
    placeByAddress (request) {
      if (!this.ymaps) return
      if (!request) {
        this.placeGeoObject(null)
      }
      this.ymaps.geocode(request).then(
        (result) => { this.placeGeoObject(result.geoObjects.get(0), false) }
      )
    },
    placeByCoords (request) {
      if (!this.ymaps) return
      if (!request) {
        this.placeGeoObject(null)
      }
      this.ymaps.geocode(request).then(
        (result) => { this.placeGeoObject(result.geoObjects.get(0)) }
      )
    },
    placeGeoObject (geoObject, changeAddress = true) {
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

      this.map.setCenter(coordinates)

      if (changeAddress) {
        this.model.place_address = name
      }
      this.model.place_lat = coordinates[0]
      this.model.place_long = coordinates[1]
    },
    showTooltip (elementId) {
      let content = document.querySelector('.dr-popover-data[data-for=' + elementId + ']')
      if (!content) return
      let popover = document.querySelector('.dr-popover')
      let area = content.parentElement
      let target = document.getElementById(elementId)

      if (!popover || !target || area.offsetParent === null) {
        return
      }

      popover.classList.remove('hidden')
      popover.style.width = (area.offsetWidth - 34) + 'px'
      popover.innerHTML = content.innerHTML
      if (this.popoverTether === null) {
        this.popoverTether = new Tether({
          element: popover,
          target: target,
          attachment: 'middle left',
          targetAttachment: 'middle right',
          constraints: [{
            to: area,
            pin: true
          }]
        })
      } else {
        this.popoverTether.target = target
        this.popoverTether.position()
      }
    },
    positionPopover () {
      if (this.popoverTether !== null) {
        this.popoverTether.position()
      }
    },
    populateSubcategories (selected) {
      if (selected.value !== this.model.main_category_id) {
        this.model.category_id = null
      }

      this.subcategories = _.filter(this.categoriesList, (e) => {
        return e.parent_id === selected.value
      })
    }
  }
}
</script>
