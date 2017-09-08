<script>
import formTooltips from 'mixins/form_tooltips'
import baseForm from './form'

export default {
  mixins: [baseForm, formTooltips],
  data: function () {
    return {
      availableCategories: null
    }
  },
  methods: {
    updateAvailable: function (e) {
      this.availableCategories = e
    }
  }
}
</script>
