<template>
  <div ref="map" class="hidden" style="height: 300px">
  </div>
</template>
<script>
import yandexMap from 'mixins/yandex_map'

export default {
  mixins: [yandexMap],
  props: ['value'],
  data: function () {
    return {
      map: null,
      placemark: null
    }
  },
  methods: {
    initializeMap () {
      this.$refs.map.classList.remove('hidden')
      this.map = new this.ymaps.Map(this.$refs.map, {
        center: this.value,
        zoom: 13
      })

      this.placemark = new this.ymaps.Placemark(this.value)
      this.map.geoObjects.add(this.placemark)
      this.map.setCenter(this.value)
    }
  }
}
</script>
