import React from 'react';
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import App from '../components/App/App'
import DevTools from '../containers/DevTools'

export default class CreateTaskApp extends React.Component {
  render() {
    const store = ReactOnRails.getStore('taskStore');

    return (
      <Provider store={store}>
        <div>
          <App {...this.props}/>
          <DevTools />
        </div>
      </Provider>
    );
  }
}
