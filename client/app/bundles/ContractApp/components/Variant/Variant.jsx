import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as answerActions from '../../actions/AnswerActions'

class Variant extends React.Component {
  handleChange(event) {
    this.props.selectAnswer(this.props.question_id, event.target.value)
  }

  render() {
    const { id, question_id, title, selected_variant } = this.props
    const name = 'question[' + question_id + ']'
    const selected = (selected_variant == id);

    return (
      <label>
        <input type="radio" name={name} checked={selected} value={id} onChange={::this.handleChange} />
        {title}
      </label>
    );
  }
}

function mapStateToProps(state, ownProps) {
  return { selected_variant: state.$$contractStore.answers[ownProps.question_id] }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(answerActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Variant)
