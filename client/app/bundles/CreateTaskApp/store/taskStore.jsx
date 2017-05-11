import { compose, createStore, applyMiddleware, combineReducers } from 'redux';
import reducers from '../reducers';

export default (props, railsContext) => {
  const initialState = {
    railsContext
  };

  const reducer = combineReducers(reducers);

  return createStore(reducer, initialState);
};
