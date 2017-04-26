import React from 'react';
import { config } from './config';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import classNames from 'classnames'

class Steps extends React.Component {
  render() {
    const { currentStep } = this.props
    var listSteps = []

    config.forEach(function(step, i) {
      var StepComponent = step.component
      const itemClasses = classNames({
        'hidden': (i != currentStep)
      });

      listSteps.push(
        <div key={i} className={itemClasses}>
          <StepComponent key={i} id={i} {...this.props} />
        </div>
      );
    }, this);

    return (
        <div>
          {listSteps}
        </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    currentStep: state.$$profileStore.form.step
  }
}

export default connect(mapStateToProps)(Steps)
