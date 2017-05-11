import React from 'react';
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import App from '../components/App/App'

export default class ContractDesignerApp extends React.Component {
  render() {
    const store = ReactOnRails.getStore('templateStore');

    return (
      <Provider store={store}>
        <div>
          <App />
        </div>
      </Provider>
    );
  }
}
