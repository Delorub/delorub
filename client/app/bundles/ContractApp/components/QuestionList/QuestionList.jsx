import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Question from '../Question/Question';
import Submitter from '../Submitter/Submitter';
import * as answerActions from '../../actions/AnswerActions'

class QuestionList extends React.Component {
  render() {
    const questions = this.props.questions;
    const listItems = questions.map((question) =>
      <Question
        key={question.id}
        {...question}
      />
    );

    return (
      <div className="questions_container">
        <div>
          {listItems}
        </div>
        <Submitter />
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    answers: state.$$contractStore.answers
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(answerActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(QuestionList)
