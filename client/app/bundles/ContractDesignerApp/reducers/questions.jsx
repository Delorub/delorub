import update from 'react/lib/update';

const questionInitialState = {
  id: 0,
  title: '',
  focused_title: false,
  variants: []
}

const variantInitialState = {
  id: 0,
  title: '',
  focused_title: false
}

const variant = (state = variantInitialState, action) => {
  switch (action.type) {
    case 'ADD_VARIANT':
      return state
    case 'CHANGE_VARIANT':
      return {
        title: action.title
      }
    default:
      return state
  }
}

const question = (state = questionInitialState, action) => {
  switch (action.type) {
    case 'ADD_QUESTION':
      return state
    case 'CHANGE_QUESTION':
      return {
        title: action.title
      }
    default:
      return state
  }
}

export default function questions (state = [], action) {
  switch (action.type) {
    case 'ADD_QUESTION':
      return [
        ...state,
        update(question(undefined, action), {
          id: { $set: state.length }
        })
      ]
    case 'CHANGE_QUESTION':
      return update(state, {
        [action.id]: { $merge: question(undefined, action) }
      })
    case 'FOCUS_QUESTION_TITLE':
      return update(state, {
        [action.id]: { focused_title: { $set: true } }
      })
    case 'BLUR_QUESTION_TITLE':
      return update(state, {
        [action.id]: { focused_title: { $set: false } }
      })
    case 'ADD_VARIANT':
      return update(state, {
        [action.question_id]: { variants: { $push: [update(variant(undefined, action), {
          id: { $set: state[action.question_id].variants.length }
        })] } }
      })
    case 'CHANGE_VARIANT':
      return update(state, {
        [action.question_id]: { variants: { [action.id]: { $merge: variant(undefined, action) } } }
      })
    case 'FOCUS_VARIANT_TITLE':
      return update(state, {
        [action.question_id]: { variants: { [action.id]: { focused_title: { $set: true } } } }
      })
    case 'BLUR_VARIANT_TITLE':
      return update(state, {
        [action.question_id]: { variants: { [action.id]: { focused_title: { $set: false } } } }
      })
    default:
      return state
  }
}
