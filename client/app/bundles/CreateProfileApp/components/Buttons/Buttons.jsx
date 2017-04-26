import React from 'react';
import { config } from '../Steps/config';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as formActions from '../../actions/FormActions'

class Buttons extends React.Component {
  handlePrev(event) {
    this.props.prevStep()
  }

  handleNext(event) {
    this.props.nextStep()
  }

  render() {
    const { currentStep } = this.props

    return (
      <div className="row lastRow">
        { currentStep > 0 &&
          <button type="button" className="btn dr-button-blue" onClick={::this.handlePrev}>Назад</button>
        }
        <button type="button" className="btn dr-button-blue">Предпросмотр</button>
        { currentStep == (config.length - 1) &&
          <input type="submit" className="btn dr-button-blueFull" value="Готово" />
        }
        { currentStep < (config.length - 1) &&
          <button type="button" className="btn dr-button-blueFull" onClick={::this.handleNext}>Далее</button>
        }
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    currentStep: state.$$profileStore.form.step
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(formActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Buttons)
