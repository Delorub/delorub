import React from 'react';
import ContractText from '../ContractText/ContractText';

export default class App extends React.Component {
  render() {
    const { text } = this.props.template.markup

    return <ContractText text={text} rendering="true" />
  }
}
