import update from 'react/lib/update';

const initialState = {
  focused: false
}

const variable = (state = initialState, action) => {
  switch (action.type) {
    case 'CHANGE_VARIABLE':
      return {
        value: action.value,
        error: false
      }
    default:
      return state
  }
}

export default function variables (state = [], action) {
  switch (action.type) {
    case 'CHANGE_VARIABLE':
      return update(state, {
        [action.id]: { $merge: variable(undefined, action) }
      })
    case 'ERROR_VARIABLE':
      return update(state, {
        [action.id]: { error: { $set: true } }
      })
    case 'FOCUS_VARIABLE':
      return update(state, {
        [action.id]: { focused: { $set: true } }
      })
    case 'BLUR_VARIABLE':
      return update(state, {
        [action.id]: { focused: { $set: false } }
      })
    default:
      return state
  }
}
