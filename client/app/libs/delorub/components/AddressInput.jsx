import React from 'react';
import { renderField } from 'libs/delorub/redux-form-input'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class AddressInput extends React.Component {
  render() {
    return (
      <Field
        component={renderField}
        type="text"
        className="form-control"
        label="Адрес"
        placeholder="Введите адрес"
        validate={[required]}
        {...this.props}
        />
    )
  }
}
