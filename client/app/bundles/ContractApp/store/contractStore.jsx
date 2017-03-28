import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import reducers, { initialStates } from '../reducers';
import DevTools from '../containers/DevTools';

const enhancer = compose(
  DevTools.instrument()
);

export default (props, railsContext) => {
  const initialState = {
    $$contractStore: props.data,
    railsContext,
  };

  const reducer = combineReducers(reducers);

  return createStore(reducer, initialState, enhancer);
};
