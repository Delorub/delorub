import Immutable from 'immutable';
import { combineReducers } from 'redux'
import profile from './profile'
import form from './form'

const rootReducer = combineReducers({
  profile, form
})

export default rootReducer
