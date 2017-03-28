import React from 'react';
import { Provider } from 'react-redux';
import ReactOnRails from 'react-on-rails';
import RenderApp from '../components/RenderApp/RenderApp'
import ReactDomServer from 'react-dom/server'

export default class ContractApp extends React.Component {
  _renderResult() {
    const store = ReactOnRails.getStore('contractStore');

    return ReactDomServer.renderToStaticMarkup(
      <Provider store={store}>
        <RenderApp {...this.props}/>
      </Provider>
    )
  }

  render() {
    return <div dangerouslySetInnerHTML={{ __html: this._renderResult() }} />
  }
}
