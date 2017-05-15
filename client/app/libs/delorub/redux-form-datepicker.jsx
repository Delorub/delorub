import React from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import classNames from 'classnames';
import moment from 'moment';

export const renderField = field => {
  var divClasses = classNames(
    { 'dr-task-div-error': field.meta.touched && field.meta.error }
  );

  return (
    <div className={divClasses}>
      <DatePicker
        dateFormat='DD.MM.YYYY'
        name={field.input.name}
        selected={field.input.value ? moment(field.input.value, 'DD.MM.YYYY') : null}
        className={field.className}
        onChange={field.input.onChange}
        onFocus={field.input.onFocus}
        onBlur={field.input.onBlur}
      />
    </div>
  )
}
