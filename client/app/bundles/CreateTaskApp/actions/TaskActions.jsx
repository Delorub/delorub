export const selectMainCategory = (id) => ({
  type: 'MAIN_CATEGORY_SELECT',
  id: id
})

export const selectSubcategory = (id) => ({
  type: 'SUBCATEGORY_SELECT',
  id: id
})

export const changeBudget = (value) => ({
  type: 'BUDGET_CHANGE',
  id: value
})
