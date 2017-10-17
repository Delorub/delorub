<template lang="pug">
div
  template(v-for="(mainCategory, index) in internalValue")
    slot(name="eachCategory" :mainCategory="mainCategory")
    div.row
      div.col-lg-6
        div.form-group.black-content
          selectbox(
            v-model="internalValue[index]['main_category_id']"
            :searchable='false'
            :allow-empty='false'
            placeholder='Выберите категорию'
            :options="mainCategoriesListFor(internalValue[index]['main_category_id'])"
            :custom-label='categoryLabel'
            @select="resetCategoriesValueForIndex(index)"
            @open="$emit('focus')"
          )
      div.col-lg-6
        div.form-group
          selectbox(
            v-model="internalValue[index]['category_ids']"
            :searchable='false'
            :allow-empty='true'
            :show-reset='true'
            :multiple='true'
            :limit='0'
            :limit-text='limitSubcategoriesText'
            :disabled="isSubcategorySelectDisabled(index)"
            placeholder='Выберите подкатегорию'
            :clear-on-select='true'
            :options="categoriesListFor(internalValue[index]['main_category_id'])"
            :custom-label='categoryLabel'
            @open="$emit('focus')"
          )
    div.row
      div.col-lg-12
        textarea(
          rows="10"
          class="form-control"
          placeholder="Опишите ваши тарифы и условия"
          v-model="internalValue[index]['description']"
          @focus="$emit('focus')"
        )
    div.row(v-if="internalValue.length > 1")
      div.col-lg-6
        a.link-default(href='#' v-on:click.prevent='removeMainCategoryByIndex(index)') Удалить
        br/
        br/
  div.row(v-if="availableCategories > 0")
    div.col-lg-6
      a.link-default(href='#' v-on:click.prevent='addMainCategory') Добавить
</template>
<script>
  export default {
    props: {
      value: {
        default: []
      },
      categoriesList: {
        default: []
      },
      maxMainCategories: {
        default: 2
      }
    },
    data: function () {
      return {
        internalValue: this.value,
        datepickerConfig: {
          allowInput: true,
          enableTime: false,
          dateFormat: 'd.m.Y'
        }
      }
    },
    mounted () {
      if (this.internalValue.length === 0) {
        this.addMainCategory()
      }
    },
    computed: {
      availableCategories () {
        return this.maxMainCategories - this.internalValue.length
      }
    },
    methods: {
      addMainCategory () {
        this.internalValue.push({
          main_category_id: null,
          description: null,
          category_ids: []
        })
        this.$emit('available', this.availableCategories)
      },
      removeMainCategoryByIndex (index) {
        this.internalValue.splice(index, 1)
        this.$emit('available', this.availableCategories)
      },
      categoriesListFor (selected) {
        return this.categoriesList.filter(e => parseInt(e.parent_id) === parseInt(selected)).map(e => e.value)
      },
      isSubcategorySelectDisabled (subcategoryId) {
        return this.internalValue[subcategoryId]['main_category_id'] === null || this.categoriesListFor(this.internalValue[subcategoryId]['main_category_id']).length === 0
      },
      mainCategoriesListFor (selected) {
        return this.categoriesList.filter((e) => {
          if (e.parent_id !== null) return false
          if (parseInt(e.value) === parseInt(selected)) return true
          return !this.internalValue.map(d => parseInt(d.main_category_id)).includes(parseInt(e.value))
        }).map(e => e.value)
      },
      resetCategoriesValueForIndex (index) {
        this.internalValue[index].category_ids = []
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
    },
    watch: {
      internalValue () {
        this.$emit('focus')
        this.$emit('input', this.internalValue)
        this.$emit('available', this.availableCategories)
      }
    }
  }
</script>
