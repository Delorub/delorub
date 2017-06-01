import update from 'react/lib/update';

export default function wizard (state = [], action) {
  switch (action.type) {
    case 'STEP_NEXT':
      return update(state, {
        step: { $set: state.step + 1 }
      })
    case 'STEP_PREV':
      return update(state, {
        step: { $set: state.step - 1 }
      })
    default:
      return state
  }
}
