export default {
  props: [
    'initialModel', 'categories'
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
