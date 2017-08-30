<template>
  <custom-select
    v-model="searchCategory"
    :options="categoriesOptions"
    placeholder="Что вас интересует?"
    @search-change= "populateCategories"
    :internal-search="false"
    @select="categoryBySelect">
    <span slot="noResult">
      <p> Не найдено совпадений </p>
    </span>
  </custom-select>
</template>
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
        query: text
      }).then(response => {
        this.categoriesList = response.data
        this.categoriesOptions = response.data.map((e) => e.title)
      })
    },
    categoryBySelect (element) {
      window.location.href = '/tasks/new/' + this.categorySlug(element)
    },
    categorySlug (category) {
      var result
      this.categoriesList.every((e) => {
        if (e.title === category) {
          result = e
          return false
        }
        return true
      })
      return result.slug
    }
  }
}
</script>
