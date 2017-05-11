import React from 'react';
import Select2 from 'react-select2-wrapper';
import classNames from 'classnames';

export const renderSelect2 = field => {
  var divClasses = classNames(
    'dr-task-name', 'dr-task-div',
    { 'dr-task-div-error': field.meta.touched && field.meta.error },
    field.containerClasses
  );

  return (
    <div className={divClasses}>
      <span>{field.label}</span>
      {field.meta.touched && field.meta.error &&
       <span className="error">{field.meta.error}</span>}
      <br />
      <Select2
        multiple={field.multiple}
        value={field.input.value}
        name={field.input.name}
        onOpen={field.input.onFocus}
        onClose={field.input.onBlur}
        onSelect={field.input.onChange}
        options={field.options}
        data={field.data}
        disabled={field.disabled}
        className={field.className}
      />
    </div>
  )
}
