import React from 'react';
import { renderSelect2 } from 'libs/delorub/redux-form-select2'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class PaidFunctionsInput extends React.Component {
  render() {
    console.log(this.props.task.paid_functions_options)
    return (
      <Field
        component={renderSelect2}
        className="dr-task-select"
        name="task[paid_functions]"
        data={optionsToSelect2(this.props.task.paid_functions_options)}
        options={{
          allowClear: true,
          minimumResultsForSearch: Infinity,
          placeholder: 'Выберите платные функции для вашего задания',
        }}
        label="Платные функции"
        />
    )
  }
}
