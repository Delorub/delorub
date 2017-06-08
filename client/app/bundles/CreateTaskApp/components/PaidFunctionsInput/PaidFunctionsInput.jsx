import React from 'react';
import RenderSelect2 from 'libs/delorub/components/RenderSelect2'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class PaidFunctionsInput extends React.Component {
  render() {
    return (
      <Field
        component={RenderSelect2}
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
