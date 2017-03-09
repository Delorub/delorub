export const changeQuestion = (id, title) => ({
  type: 'CHANGE_QUESTION',
  id: id,
  title: title
})

export const focusQuestionTitle = (id) => ({
  type: 'FOCUS_QUESTION_TITLE',
  id: id
})

export const blurQuestionTitle = (id) => ({
  type: 'BLUR_QUESTION_TITLE',
  id: id
})

export const addQuestion = () => ({
  type: 'ADD_QUESTION'
})

export const insertVariant = (variant) => ({
  type: 'INSERT_VARIANT',
  variant: variant
})

export const changeVariant = (id, question_id, title) => ({
  type: 'CHANGE_VARIANT',
  id: id,
  question_id: question_id,
  title: title
})

export const focusVariantTitle = (id, question_id) => ({
  type: 'FOCUS_VARIANT_TITLE',
  id: id,
  question_id: question_id
})

export const blurVariantTitle = (id, question_id) => ({
  type: 'BLUR_VARIANT_TITLE',
  id: id,
  question_id: question_id
})

export const addVariant = (question_id) => ({
  type: 'ADD_VARIANT',
  question_id: question_id
})
