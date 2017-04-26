import taskReducer, { $$initialState as $$taskState } from './taskReducer';
import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';

export default {
  $$taskStore: taskReducer,
  railsContext: railsContextReducer,
};

export const initialStates = {
  $$taskState,
  railsContextState,
};
