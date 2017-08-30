<template>
  <custom-select
    v-model="searchCategory"
    :options="categoriesOptions"
    placeholder="Что вас интересует?"
    @search-change= "populateCategories"
    @select= "categoryBySelect">
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
        console.log(response.data)
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
