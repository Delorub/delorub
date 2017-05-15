import React from 'react';
import TimePicker from 'rc-time-picker';
import 'rc-time-picker/assets/index.css';
import classNames from 'classnames';
import moment from 'moment';

export const renderField = field => {
  var divClasses = classNames(
    { 'dr-task-div-error': field.meta.touched && field.meta.error }
  );

  return (
    <div className={divClasses}>
      <TimePicker
        showSecond={false}
        name={field.input.name}
        className={field.className}
        onChangeRaw={field.input.onChange}
        onOpen={field.input.onFocus}
        onClose={field.input.onBlur}
      />
    </div>
  )
}
