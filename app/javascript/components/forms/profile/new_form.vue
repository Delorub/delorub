<script>
import formTooltips from 'mixins/form_tooltips'
import baseForm from './form'

export default {
  mixins: [baseForm, formTooltips],
  props: ['initialModel', 'citiesList'],
  data: function () {
    return {
      availableCategories: null
    }
  },
  methods: {
    updateAvailable: function (e) {
      this.availableCategories = e
    },
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
</script>
