import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import VariantList from '../VariantList/VariantList';
import * as answerActions from '../../actions/AnswerActions'

export default class Question extends React.Component {
  render() {
    const { id, title, variants } = this.props

    return (
      <fieldset>
        <legend>{title}</legend>
        <VariantList question_id={id} variants={variants}/>
      </fieldset>
    );
  }
}
