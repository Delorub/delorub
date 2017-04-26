import React from 'react';
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import App from '../components/App/App'
import DevTools from '../containers/DevTools'

export default class NotificationsApp extends React.Component {
  render() {
    const store = ReactOnRails.getStore('profileStore');

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
