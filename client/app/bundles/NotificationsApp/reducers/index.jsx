import notificationsReducer, { $$initialState as $$notificationsState } from './notificationsReducer';
import railsContextReducer, { initialState as railsContextState } from './railsContextReducer';

export default {
  $$notificationsStore: notificationsReducer,
  railsContext: railsContextReducer,
};

export const initialStates = {
  $$notificationsState,
  railsContextState,
};
