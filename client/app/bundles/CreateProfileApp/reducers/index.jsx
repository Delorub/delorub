import createProfileReducer from './createProfileReducer';
import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';
import { reducer as formReducer } from 'redux-form'

export default {
  $$createProfileStore: createProfileReducer,
  railsContext: railsContextReducer,
  form: formReducer
}
