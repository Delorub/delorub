import contractReducer, { $$initialState as $$contractState } from './contractReducer';
import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';

export default {
  $$contractStore: contractReducer,
  railsContext: railsContextReducer,
};

export const initialStates = {
  $$contractState,
  railsContextState,
};
