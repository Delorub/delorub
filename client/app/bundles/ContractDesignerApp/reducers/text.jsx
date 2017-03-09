import update from 'react/lib/update';

const initialState = {
  data: '',
  insert_variant: undefined,
  change_variant: undefined,
  change_question: undefined
}

export default function text (state = initialState, action) {
  switch (action.type) {
    case 'CHANGE_QUESTION':
      return update(state, { change_question: { $set: { id: action.id, title: action.title } }})
    case 'CHANGE_VARIANT':
      return update(state, { change_variant: { $set: { id: action.id, question_id: action.question_id, title: action.title } }})
    case 'INSERT_VARIANT':
      return update(state, { insert_variant: { $set: action.variant }})
    case 'CHANGE_TEXT':
      return update(state, { data: { $set: action.text } } )
    default:
      return state
  }
}
