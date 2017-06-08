import React from 'react';
import Select2 from 'react-select2-wrapper';
import classNames from 'classnames';

export default class RenderSelect2 extends React.Component {
  render() {
    const { input, options, data, meta, containerClasses, disabled, className, multiple, label } = this.props

    var divClasses = classNames(
      'dr-task-name', 'dr-task-div',
      { 'dr-task-div-error': meta.touched && meta.error },
      containerClasses
    );

    return (
      <div className={divClasses}>
        <span className="input-label">{label}</span>
        {meta.touched && meta.error &&
         <span className="error">{meta.error}</span>}
        <br />
        <Select2
          ref="select2"
          multiple={multiple}
          value={input.value}
          name={input.name}
          onOpen={input.onFocus}
          onClose={input.onBlur}
          onSelect={input.onChange}
          options={options}
          data={data}
          disabled={disabled}
          className={className}
        />
      </div>
    )
  }
}
