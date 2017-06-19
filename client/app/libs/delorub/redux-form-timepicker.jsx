import React from 'react';
import TimeInput from 'time-input';
import classNames from 'classnames';
import moment from 'moment';

export default class RenderTimePickerField extends React.Component {
  render() {
    const { input, meta, ...rest } = this.props

    var divClasses = classNames(
      { 'dr-task-div-error': meta.touched && meta.error }
    );

    return (
      <div className={divClasses}>
        <input type="hidden" name={input.name} value={input.value} />
        <TimeInput
          value={input.value || '12:00'}
          defaultValue={input.value}
          onChange={input.onChange}
          onFocus={input.onFocus}
          onBlur={input.onBlur}
          {...rest}
        />
      </div>
    )
  }
}
