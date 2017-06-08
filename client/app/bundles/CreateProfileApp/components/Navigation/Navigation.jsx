import React from 'react';
import { connect } from 'react-redux'
import { config } from '../Steps/config';
import { bindActionCreators } from 'redux'
import Item from './Item';
import * as formActions from '../../actions/FormActions'

class Steps extends React.Component {
  render() {
    const { currentStep } = this.props

    return (
      <div className="dr-header-span dr-header-step">
        {config[currentStep].title}
        <div className="steps">
        { currentStep < (config.length - 1) &&
          <button type="submit" className="btn dr-button-blue" name="next">Далее</button>
        }
        { currentStep == (config.length - 1) &&
          <button type="submit" className="btn dr-button-blue" name="send">Готово</button>
        }
          <ul className="nav-tabs step-anchor">
            <li><a>&nbsp;</a></li>
            {config.map((step, i) =>
              <Item key={i} id={i} {...step}/>
            )}
            <li><a></a></li>
          </ul>
        </div>
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
