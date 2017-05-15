import React from 'react';
import { renderField } from 'libs/delorub/redux-form-textarea'
import { required, minLength } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class DescriptionInput extends React.Component {
  render() {
    const minLength10 = minLength(10)

    return (
      <Field
        component={renderField}
        className="form-control"
        name="task[description]"
        label="Описание задания"
        placeholder="Введите описание задания"
        validate={[required, minLength10]}
        {...this.props}
        />
    )
  }
}
