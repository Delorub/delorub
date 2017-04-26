import update from 'react/lib/update';

export default function form (state = [], action) {
  switch (action.type) {
    case 'SUBCATEGORY_TOGGLE':
      var i = state.specializations.indexOf(action.id);
      if(i > -1) {
        return update(state, {
          specializations: { $splice: [ [i, 1] ] }
        })
      } else {
        return update(state, {
          specializations: { $push: [ action.id ] }
        })
      }
    case 'CATEGORY_SELECT':
      return update(state, {
        main_specialization_id: { $set: [ action.id ] }
      })
    case 'PHOTO_SET_URL':
      return update(state, {
        photo_url: { $set: [ action.url ] }
      })
    default:
      return state
  }
}
