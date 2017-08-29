<script>
import axios from 'axios'
export default {
  data: function () {
    return {
      searchCategory: '',
      categoriesOptions: [],
      categoriesList: []
    }
  },
  methods: {
    populateCategories (text) {
      axios.post('/api/categories', {
        search: text
      }).then(response => {
        this.categoriesList = response.data
        this.categoriesOptions = response.data.map((e) => e.title)
      })
    },
    categoryBySelect (element) {
      window.location.href = '/tasks/new?category_id=' + this.categoryId(element)
    },
    categoryId (category) {
      var result
      this.categoriesList.every((e) => {
        if (e.title === category) {
          result = e
          return false
        }
        return true
      })
      return result.id
    }
  }
}
</script>
