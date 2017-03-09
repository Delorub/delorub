import templateReducer, { $$initialState as $$templateState } from './templateReducer';
import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';

export default {
  $$templateStore: templateReducer,
  railsContext: railsContextReducer,
};

export const initialStates = {
  $$templateState,
  railsContextState,
};
