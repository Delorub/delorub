import React from 'react';
import { connect } from 'react-redux'
import { Field } from 'redux-form';
import { renderField } from 'libs/delorub/redux-form-input'
import { required } from 'libs/delorub/redux-form-validations'

export default class PriceSelector extends React.Component {
  render() {
    const { price_type } = this.props

    if(price_type == 'hourly') {
      return (
        <Field
          name="create_profile[price_hourly]"
          component={renderField}
          className="form-control"
          type="text"
          label="Почасовая ставка"
          placeholder="Введите почасовую ставку"
          containerClasses="dr-task-name dr-task-div dr-task dr-profile-div"
          validate={[required]}
        />
      )
    } else if(price_type == 'project') {
      return (
        <Field
          name="create_profile[price_project]"
          component={renderField}
          className="form-control"
          label="Цена за проект"
          type="text"
          placeholder="Введите цену за проект"
          containerClasses="dr-task-name dr-task-div dr-task dr-profile-div"
          validate={[required]}
        />
      )
    } else {
      return null;
    }
  }
}
