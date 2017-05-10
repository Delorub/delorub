import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';
import { reducer as formReducer } from 'redux-form'

export default {
  railsContext: railsContextReducer,
  form: formReducer
};
