export default {
  data: function () {
    return {
      ymaps: null,
      yandexMap: {
        defaultCenter: [59.94, 30.32]
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
  }
}
