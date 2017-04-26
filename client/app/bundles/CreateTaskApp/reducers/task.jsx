import update from 'react/lib/update';

export default function task (state = [], action) {
  switch (action.type) {
    case 'CATEGORY_SELECT':
      return update(state, {
        category_id: { $set: [ action.id ] }
      })
    default:
      return state
  }
}
