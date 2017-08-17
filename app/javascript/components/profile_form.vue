<script>
import formTooltips from 'mixins/form_tooltips'

export default {
  mixins: [formTooltips],
  props: [
    'initialModel', 'categoriesList'
  ],
  data: function () {
    return {
      model: this.initialModel
    }
  },
  methods: {
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
    }
  }
}
</script>
