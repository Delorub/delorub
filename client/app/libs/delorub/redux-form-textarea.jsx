import React from 'react';
import classNames from 'classnames';

export const renderField = field => {
  var divClasses = classNames(
    'dr-task-description', 'dr-task-div',
    { 'dr-task-div-error': field.meta.touched && field.meta.error },
    field.containerClasses
  );

  return (
    <div className={divClasses}>
      <span className="input-label">{field.label}</span>
      {field.meta.touched && (field.meta.error && <span className="error">{field.meta.error}</span>)}
      <textarea {...field.input} placeholder={field.placeholder} className={field.className} />
    </div>
  )
}
