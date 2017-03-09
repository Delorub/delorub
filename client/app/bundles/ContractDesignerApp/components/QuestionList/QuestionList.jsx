import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Question from '../Question/Question';
import css from './QuestionList.scss'
import * as questionActions from '../../actions/QuestionActions'

class QuestionList extends React.Component {
  render() {
    const questions = this.props.questions;
    const listItems = questions.map((question) =>
      <Question
        key={question.id}
        id={question.id}
      />
    );

    return <div>
      <div>
        {listItems}
      </div>
      <div className={css.buttons}>
        <a href="#" className={css.add} onClick={this.props.addQuestion}>Добавить вопрос</a>
      </div>
    </div>;
  }
}

function mapStateToProps(state) {
  return {
    questions: state.$$templateStore.questions
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(questionActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(QuestionList)
