import Immutable from 'immutable';
import { combineReducers } from 'redux'
import answers from './answers'
import variables from './variables'

const rootReducer = combineReducers({
  answers,
  variables
})

export default rootReducer
