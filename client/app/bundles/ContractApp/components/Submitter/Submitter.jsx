import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as variableActions from '../../actions/VariableActions'

class Submitter extends React.Component {
  validate() {
    var submit = true;
    const { variables } = this.props

    Object.keys(variables).forEach(function(key) {
      const variable = variables[key]
      if(variable.value == '') {
        this.props.errorVariable(key);
        if(submit == true) {
          this.props.focusVariable(key);
        }
        submit = false;
      }
    }.bind(this));

    return submit;
  }

  handlePrint(e) {
    if( ! this.validate()) {
      e.preventDefault();
    } else {

    }
  }

  render() {
    return (
      <div>
        <input type="submit" name="print" value="Распечатать" onClick={::this.handlePrint} />
      </div>
    );
  }
}

function mapStateToProps(state) {
  return state.$$contractStore
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(variableActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Submitter)
