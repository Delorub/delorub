import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import VariantList from '../VariantList/VariantList';
import css from './Question.scss'
import classNames from 'classnames'
import * as questionActions from '../../actions/QuestionActions'

class Question extends React.Component {
  handleChange(event) {
    this.props.changeQuestion(this.props.id, event.target.value);
  }

  onInputBlur(event) {
    this.props.blurQuestionTitle(this.props.id);
  }

  onInputFocus(event) {
    this.props.focusQuestionTitle(this.props.id);
  }

  onEditClick(event) {
    this.props.focusQuestionTitle(this.props.id);
  }

  onInputKeyPress(event) {
    if (event.key == 'Enter') {
      event.preventDefault();
      this.props.addQuestion();
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
    const name = 'contract_template[markup][questions][' + this.props.id + '][title]'

    const containerClasses = classNames({
      [css.container]: true,
      [(focused_title || title == '') ? css.editable : css.nonEditable]: true
    });

    return <div className={containerClasses}>
      <div className={css.headingContainer}>
        <div className={css.titleContainer} onClick={::this.onEditClick}>
          {title}
        </div>
        <div className={css.inputContainer}>
          <input
            ref={ (input) => { this.titleInput = input; } }
            name={name}
            value={title}
            onChange={::this.handleChange}
            onFocus={::this.onInputFocus}
            onBlur={::this.onInputBlur}
            onKeyPress={::this.onInputKeyPress}
            placeholder="Введите название вопроса" />
        </div>
      </div>
      <div className={css.variantsContainer}>
        <VariantList id={this.props.id}/>
      </div>
    </div>;
  }
}

function mapStateToProps(state, ownProps) {
  return state.$$templateStore.questions[ownProps.id]
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(questionActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Question)
