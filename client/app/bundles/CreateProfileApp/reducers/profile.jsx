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
    default:
      return state
  }
}
