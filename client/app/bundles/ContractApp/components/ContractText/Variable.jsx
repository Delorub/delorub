import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import VariantList from '../VariantList/VariantList';
import classNames from 'classnames'
import ContentEditable from 'react-contenteditable'
import * as variableActions from '../../actions/VariableActions'

class Variable extends React.Component {
  handleChange(event) {
    this.props.changeVariable(this.props.id, event.target.value);
  }

  handlePlaceholderClick() {
    this.props.focusVariable(this.props.id);
  }

  handleContainerBlur() {
    this.props.blurVariable(this.props.id);
  }

  componentDidUpdate(prevProps) {
    const { focused } = this.props
    const { focused: wasFocused } = prevProps

    if (!wasFocused && focused) {
      this.containerSpan.htmlEl.focus();
    }
  }

  render() {
    const { id, title, value, focused, error } = this.props

    const containerClasses = classNames({
      'variable': true,
      'active': focused,
      'error': error,
      'filled': (value != '')
    });

    const inputName = 'variable[' + id + ']'

    if(this.props.rendering) {
      return <span>{value}</span>
    }

    return (
      <span className={containerClasses} ref={ (div) => { this.mainDiv = div; } }>
        <input type="hidden" name={inputName} value={value} />
        <ContentEditable
          tagName="span"
          className="container"
          ref={ (span) => { this.containerSpan = span; } }
          onChange={::this.handleChange}
          onBlur={::this.handleContainerBlur}
          html={value}
        />
        <span className="placeholder noselect" onClick={::this.handlePlaceholderClick}>{title}</span>
      </span>
    );
  }
}

function mapStateToProps(state, ownProps) {
  return state.$$contractStore.variables[ownProps.id]
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(variableActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Variable)
