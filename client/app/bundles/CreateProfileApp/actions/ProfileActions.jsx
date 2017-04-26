export const toggleSubcategory = (id) => ({
  type: 'SUBCATEGORY_TOGGLE',
  id: id
})

export const selectCategory = (id) => ({
  type: 'CATEGORY_SELECT',
  id: id
})

export const setPhotoUrl = (url) => ({
  type: 'PHOTO_SET_URL',
  url: url
})
