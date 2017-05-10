import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import css from './Variant.scss'
import classNames from 'classnames'
import * as questionActions from '../../actions/QuestionActions'

class Variant extends React.Component {
  handleChange(event) {
    this.props.changeVariant(this.props.id, this.props.question_id, event.target.value);
  }

  onInputBlur(event) {
    this.props.blurVariantTitle(this.props.id, this.props.question_id);
  }

  onInputFocus(event) {
    this.props.focusVariantTitle(this.props.id, this.props.question_id);
  }

  onEditClick(event) {
    this.props.focusVariantTitle(this.props.id, this.props.question_id);
  }

  onInsertClick(event) {
    this.props.insertVariant({
      id: this.props.id,
      title: this.props.title,
      question: this.props.question
    });
  }

  onInputKeyPress(event) {
    if (event.key == 'Enter') {
      event.preventDefault();
      this.props.addVariant(this.props.question_id);
    }
  }

  componentDidMount() {
    this.titleInput.focus();
  }

  componentDidUpdate(prevProps) {
    const { focused_title } = this.props
    const { focused_title: wasFocused } = prevProps

    if (!wasFocused && focused_title) {
      this.titleInput.focus();
    }
  }

  render() {
    const { title, focused_title } = this.props
    const name = 'contract_template[markup][questions][' + this.props.question.id + '][variants][' + this.props.id + '][title]'

    const containerClasses = classNames({
      'container': true,
      [(focused_title || title == '') ? 'editable' : 'nonEditable']: true
    });

    return (<div className={containerClasses}>
      <div className="headingContainer">
        <div className="titleContainer">
          <a href="#" className="title" onClick={::this.onEditClick}>{title}</a>
          <a href="#" className="insert" onClick={::this.onInsertClick}>→</a>
        </div>
        <div className="inputContainer">
          <input
            ref={ (input) => { this.titleInput = input; } }
            name={name}
            value={title}
            onChange={::this.handleChange}
            onFocus={::this.onInputFocus}
            onBlur={::this.onInputBlur}
            onKeyPress={::this.onInputKeyPress}
            placeholder="Вариант ответа" />
        </div>
      </div>
    </div>);
  }
}

function mapStateToProps(state, ownProps) {
  return {
    ...state.$$templateStore.questions[ownProps.question_id].variants[ownProps.id],
    question: state.$$templateStore.questions[ownProps.question_id]
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(questionActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Variant)
