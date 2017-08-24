<script>
import formTooltips from 'mixins/form_tooltips'

export default {
  mixins: [formTooltips],
  props: [
    'initialModel', 'categoriesList'
  ],
  data: function () {
    return {
      model: this.initialModel,
      maxMainCategories: 2,
      datepickerConfig: {
        allowInput: true,
        enableTime: false,
        dateFormat: 'd.m.Y'
      }
    }
  },
  mounted () {
    if (this.model.main_categories_profiles.length === 0) {
      this.addMainCategory()
    }
  },
  computed: {
    availableCategories () {
      return this.maxMainCategories - this.model.main_categories_profiles.length
    }
  },
  methods: {
    addMainCategory () {
      this.model.main_categories_profiles.push({
        main_category_id: null,
        description: null,
        category_ids: []
      })
    },
    removeMainCategoryByIndex (index) {
      this.model.main_categories_profiles.splice(index, 1)
    },
    categoriesListFor (selected) {
      return this.categoriesList.filter(e => parseInt(e.parent_id) === parseInt(selected)).map(e => e.value)
    },
    mainCategoriesListFor (selected) {
      return this.categoriesList.filter((e) => {
        if (e.parent_id !== null) return false
        if (parseInt(e.value) === parseInt(selected)) return true
        return !this.model.main_categories_profiles.map(d => parseInt(d.main_category_id)).includes(parseInt(e.value))
      }).map(e => e.value)
    },
    resetCategoriesValueForIndex (index) {
      this.model.main_categories_profiles[index].category_ids = []
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
    limitSubcategoriesText (count) {
      return `Выбрано ${count} подкатегорий`
    }
  }
}
</script>
