import React from 'react';
import ReactBootstrapSlider from 'react-bootstrap-slider';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as taskActions from '../../actions/TaskActions'

class Budget extends React.Component {
  changeValue(e) {
    this.props.changeBudget(e.target.value)
  }

  getPrice() {
    const { price_exact } = this.props
    if(price_exact == null) {
      return 0;
    }

    return price_exact
  }

  render() {
    const max = 10000;
    const min = 0;
    const step = 50;

    return (
      <div className="dr-task-budget dr-task-div">
        <div className="row">
          <div className="col-md-4">
            <span>Бюджет *</span>
            <input type="text" className="form-control" value={this.getPrice()} onChange={::this.changeValue} />
          </div>
          <div className="col-md-8">
            <span className="minValue">{min}</span>
            <span className="maxValue">{max}</span>
            <ReactBootstrapSlider
              value={this.getPrice()}
              slideStop={::this.changeValue}
              step={step}
              max={max}
              min={min}
              />
          </div>
        </div>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    price_exact: state.$$taskStore.task.price_exact,
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(taskActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Budget)
