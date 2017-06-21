import React from 'react';
import TimeInput from 'time-input';
import classNames from 'classnames';
import moment from 'moment';
import { Field } from 'redux-form';

export default class YesNoField extends React.Component {
  render() {
    const { input, meta, label, ...rest } = this.props

    var divClasses = classNames(
      { 'dr-task-div-error': meta.touched && meta.error, 'dr-task dr-profile-div': true }
    );

    return (
      <div className={divClasses}>
        <span className="input-label">{label}</span>
        <br />
        <div className="btn-group dr-radio">
          <label className={classNames({ 'active': input.value == 'yes', 'btn btn-primary': true })}>
            <Field name={input.name} component="input" type="radio" value="yes" />
            <span>Да</span>
          </label>
          <label className={classNames({ 'active': input.value == 'no', 'btn btn-primary': true })}>
            <Field name={input.name} component="input" type="radio" value="no" />
            <span>Нет</span>
          </label>
        </div>
      </div>
    )
  }
}
