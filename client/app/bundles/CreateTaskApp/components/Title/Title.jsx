import React from 'react';
import { renderField } from '../libs/renderHelpers'
import { required, minLength } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class Title extends React.Component {
  render() {
    const minLength4 = minLength(4)

    return (
      <Field
        component={renderField}
        type="text"
        className="form-control"
        name="task[title]"
        label="Название задания"
        placeholder="Введите название задания"
        validate={[required, minLength4]}
        {...this.props}
        />
    )
  }
}
