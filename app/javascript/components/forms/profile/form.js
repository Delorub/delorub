export default {
  props: [
    'initialModel', 'categoriesList', 'citiesList'
  ],
  data: function () {
    return {
      model: this.initialModel,
      datepickerConfig: {
        allowInput: true,
        enableTime: false,
        dateFormat: 'd.m.Y'
      }
    }
  },
  methods: {
    cityLabel (id) {
      var result
      this.citiesList.every((e) => {
        if (parseInt(e.value) === parseInt(id)) {
          result = e
          return false
        }
        return true
      })
      return result.label
    }
  }
}
