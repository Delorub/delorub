import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import reducers from '../reducers';
import DevTools from '../containers/DevTools';

const enhancer = compose(
  DevTools.instrument()
);

export default (props, railsContext) => {
  const initialState = {
    $$profileStore: props,
    railsContext,
  };

  const reducer = combineReducers(reducers);

  return createStore(reducer, initialState, enhancer);
};
