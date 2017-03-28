import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import classNames from 'classnames'

class Block extends React.Component {
  render() {
    const { variant_id, attribs, data, selected_variant } = this.props
    const hidden = (variant_id != selected_variant);

    const containerClasses = classNames({
      [attribs.class]: attribs.class && true,
      'hidden': hidden
    });

    delete attribs['data-question-id']
    delete attribs['data-variant-id']
    delete attribs['data-question-title']
    delete attribs['data-variant-title']
    delete attribs['class']

    return (
      <this.props.tag className={containerClasses} {...attribs}>
        {data}
      </this.props.tag>
    )
  }
}

function mapStateToProps(state, ownProps) {
  return { selected_variant: state.$$contractStore.answers[ownProps.question_id] }
}

export default connect(mapStateToProps)(Block)
