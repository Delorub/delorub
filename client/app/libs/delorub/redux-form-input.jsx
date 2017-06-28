import React from 'react';
import classNames from 'classnames';

export const renderField = ({ input, label, placeholder, className, containerClasses, glyphicon, type, meta: { touched, error, warning } }) => {
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

  var inputComponent = <input {...input} placeholder={placeholder} type={type} className={className} />
  if(glyphicon) {
    var addonClasses = classNames(
      'glyphicon', 'glyphicon-' + glyphicon
    );

    var inputContainer = (<div className="input-group">
      {inputComponent}
      <span className="input-group-addon"><span className={addonClasses}></span></span>
    </div>);
  } else {
    var inputContainer = inputComponent;
  }

  return (
    <div className={divClasses}>
      { label && (<span className="input-label">{label}</span>) }
      {label && touched && (error && <span className="error">{error}</span>)}
      {inputContainer}
    </div>
  )
}
