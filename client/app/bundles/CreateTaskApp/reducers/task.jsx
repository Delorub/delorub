import update from 'react/lib/update';

export default function task (state = [], action) {
  switch (action.type) {
    case 'MAIN_CATEGORY_SELECT':
      return update(state, {
        main_category_id: { $set: [ action.id ] }
      })
    case 'SUBCATEGORY_SELECT':
      return update(state, {
        category_id: { $set: [ action.id ] }
      })
    case 'BUDGET_CHANGE':
      return update(state, {
        price_exact: { $set: [ action.id ] }
      })
    default:
      return state
  }
}
