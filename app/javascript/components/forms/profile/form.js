export default {
  props: [
    'initialModel', 'categoriesList'
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
  }
}
