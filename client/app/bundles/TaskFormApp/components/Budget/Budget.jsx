import React from 'react';
import ReactBootstrapSlider from 'react-bootstrap-slider';
import { renderField } from 'libs/delorub/redux-form-input'
import { required, minLength } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';
import { normalizePositiveNum } from 'libs/delorub/redux-form-normalizers'

export default class Budget extends React.Component {
  changeValue(e) {
    this.props.change('task[price_exact]', e.target.value)
  }

  getPrice() {
    const { price_exact } = this.props
    if(!price_exact) {
      return 0;
    }

    return parseInt(price_exact)
  }

  render() {
    const max = 10000;
    const min = 0;
    const step = 50;

    return (
      <div className="dr-task-budget dr-task-div">
        <div className="row">
          <Field
            component={renderField}
            type="hidden"
            name="task[price_type]"
            />
          <Field
            component={renderField}
            type="text"
            containerClasses="col-md-4"
            className="form-control"
            name="task[price_exact]"
            label="Бюджет"
            glyphicon="ruble"
            validate={[required]}
            normalize={normalizePositiveNum}
            />
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
