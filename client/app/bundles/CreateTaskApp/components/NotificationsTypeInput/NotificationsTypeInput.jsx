import React from 'react';
import { renderSelect2 } from 'libs/delorub/redux-form-select2'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class NotificationsTypeInput extends React.Component {
  render() {
    return (
      <Field
        component={renderSelect2}
        className="dr-task-select"
        name="task[notifications_type]"
        data={optionsToSelect2(this.props.task.notifications_type_options)}
        options={{
          minimumResultsForSearch: Infinity,
          placeholder: 'Выберите формат уведомлений',
        }}
        label="Формат уведомлений об откликах"
        validate={[required]}
        />
    )
  }
}
