import React from 'react';
import { renderField as renderDatePickerField } from 'libs/delorub/redux-form-datepicker'
import { renderField } from 'libs/delorub/redux-form-input'
import { required, time } from 'libs/delorub/redux-form-validations'
import { normalizeTime } from 'libs/delorub/redux-form-normalizers'
import { Field } from 'redux-form';
import moment from 'moment';

const upper = value => value && moment(value)

export default class DateActual extends React.Component {
  render() {
    return (
      <div className="dr-task-name dr-task-div">
        <span className="input-label">Дата выполнения</span>
        <br />
        <div className="row">
          <div className="col-md-6">
            <Field
              component={renderDatePickerField}
              className="form-control"
              name="task[date_actual_date]"
              placeholder="Дата"
              label="Дата"
              validate={[required]}
              />
          </div>
          <div className="col-md-6">
            <Field
              component={renderField}
              type="text"
              label=""
              containerClasses={[]}
              className="form-control"
              name="task[date_actual_time]"
              placeholder="Время"
              validate={[required, time]}
              normalize={normalizeTime}
              />
          </div>
        </div>
      </div>
    );
  }
}
