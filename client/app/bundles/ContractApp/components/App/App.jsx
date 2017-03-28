import React from 'react';
import QuestionList from '../QuestionList/QuestionList';
import ContractText from '../ContractText/ContractText';

export default class App extends React.Component {
  render() {
    const { questions, text } = this.props.template.markup

    return (
      <div className="contract_app">
        <QuestionList questions={questions} />
        <ContractText text={text} />
      </div>
    );
  }
}
