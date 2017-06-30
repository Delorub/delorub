import React from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import classNames from 'classnames';
import moment from 'moment';

class RenderDatepicker extends React.Component {
  clickOutside() {
    this.refs.picker.cancelFocusInput();
    this.refs.picker.setOpen(false);
  }

  render() {
    const { input, data, meta, ...rest } = this.props

    var divClasses = classNames(
      { 'dr-task-div-error': meta.touched && meta.error }
    );

    return (
      <div className={divClasses}>
        <DatePicker
          dateFormat='DD.MM.YYYY'
          locale="ru"
          ref="picker"
          name={input.name}
          selected={input.value ? moment(input.value, 'DD.MM.YYYY') : null}
          onChange={input.onChange}
          onFocus={input.onFocus}
          onBlur={input.onBlur}
          onClickOutside={::this.clickOutside}
          {...rest}
        />
      </div>
    )
  }
}

export default RenderDatepicker
