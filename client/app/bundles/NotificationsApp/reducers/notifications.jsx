import update from 'react/lib/update';

export default function answers (state = [], action) {
  switch (action.type) {
    case 'SELECT_ANSWER':
      return update(state, {
        [action.question_id]: { $set: action.variant_id }
      })
    default:
      return state
  }
}
