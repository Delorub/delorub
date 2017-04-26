import React from 'react';
import { connect } from 'react-redux'
import classNames from 'classnames'

class Item extends React.Component {
  render() {
    const { id, itemTitle, currentStep } = this.props
    const itemClasses = classNames({
      'active': (id == currentStep)
    });

    return (
      <li className={itemClasses}><a>{itemTitle}</a></li>
    );
  }
}

function mapStateToProps(state) {
  return {
    currentStep: state.$$profileStore.form.step
  }
}

export default connect(mapStateToProps)(Item)
