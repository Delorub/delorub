import React from 'react';
import { config } from './config';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import classNames from 'classnames'
import * as formActions from '../../actions/FormActions'

class Steps extends React.Component {
  handleNext(event) {
    this.props.nextStep()
  }

  render() {
    const { currentStep } = this.props
    var displayStep = null

    config.forEach(function(step, i) {
      var StepComponent = step.component
      if(i == currentStep) {
        displayStep = <StepComponent key={i} id={i} {...this.props} onSubmit={::this.handleNext} />
      }
    }, this);

    return (
        <div>
          {displayStep}
        </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    currentStep: state.$$createProfileStore.wizard.step
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(formActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Steps)
