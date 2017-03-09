import Immutable from 'immutable';
import { combineReducers } from 'redux'
import questions from './questions'
import text from './text'
import variables from './variables'

const rootReducer = combineReducers({
  questions,
  text,
  variables
})

export default rootReducer
