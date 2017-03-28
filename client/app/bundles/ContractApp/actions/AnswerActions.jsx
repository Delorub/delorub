export const selectAnswer = (question_id, variant_id) => ({
  type: 'SELECT_ANSWER',
  question_id: question_id,
  variant_id: variant_id
})
