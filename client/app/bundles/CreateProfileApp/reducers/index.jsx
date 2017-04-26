import profileReducer, { $$initialState as $$profileState } from './profileReducer';
import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';

export default {
  $$profileStore: profileReducer,
  railsContext: railsContextReducer,
};

export const initialStates = {
  $$profileState,
  railsContextState,
};
