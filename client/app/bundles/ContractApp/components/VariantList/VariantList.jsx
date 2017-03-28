import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Variant from '../Variant/Variant';
import * as answerActions from '../../actions/AnswerActions'

export default class VariantList extends React.Component {
  render() {
    const { question_id, variants } = this.props
    const listItems = variants.map((variant) =>
      <Variant
        key={variant.id}
        question_id={question_id}
        {...variant}
      />
    );

    return <div>{listItems}</div>;
  }
}
