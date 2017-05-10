import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Variant from '../Variant/Variant';
import css from './VariantList.scss'
import * as questionActions from '../../actions/QuestionActions'

class VariantList extends React.Component {
  handleAddClick(event) {
    this.props.addVariant(this.props.id);
  }

  render() {
    const variants = this.props.variants;
    const listItems = variants.map((variant) =>
      <Variant
        key={variant.id}
        id={variant.id}
        question_id={this.props.id}
      />
    );

    return (<div>
      <div>
        {listItems}
      </div>
      <a href="#" className="add" onClick={::this.handleAddClick}>Добавить ответ</a>
    </div>);
  }
}

function mapStateToProps(state, ownProps) {
  return state.$$templateStore.questions[ownProps.id]
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(questionActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(VariantList)
