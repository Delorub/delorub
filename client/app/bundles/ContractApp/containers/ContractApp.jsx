import React from 'react';
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import App from '../components/App/App'
import DevTools from '../containers/DevTools'

export default class ContractApp extends React.Component {
  render() {
    const store = ReactOnRails.getStore('contractStore');

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
