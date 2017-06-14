import React from 'react';
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import App from '../components/App/App'

export default class TaskFormApp extends React.Component {
  render() {
    const store = ReactOnRails.getStore('taskStore');

    return (
      <Provider store={store}>
        <div>
          <App {...this.props} authenticity_token={ReactOnRails.authenticityToken()}/>
        </div>
      </Provider>
    );
  }
}
