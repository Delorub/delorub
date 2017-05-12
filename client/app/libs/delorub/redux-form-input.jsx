import React from 'react';
import classNames from 'classnames';

export const renderField = ({ input, label, placeholder, className, containerClasses, type, meta: { touched, error, warning } }) => {
  if(type == 'hidden') {
    return (<input {...input} type={type} />)
  }

  if(!containerClasses) {
    var divClasses = classNames(
      'dr-task-name', 'dr-task-div',
      { 'dr-task-div-error': touched && error }
    );
  } else {
    var divClasses = classNames(
      { 'dr-task-div-error': touched && error },
      containerClasses
    );
  }

  return (
    <div className={divClasses}>
      <span className="input-label">{label}</span>
      {touched && (error && <span className="error">{error}</span>)}
      <input {...input} placeholder={placeholder} type={type} className={className} />
    </div>
  )
}
