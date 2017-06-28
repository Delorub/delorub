import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class PaidFunctionsInput extends React.Component {
  render() {
    return (
      <Field
        component={RenderSelect}
        className="dr-task-select"
        name="task[paid_functions]"
        options={optionsToSelect2(this.props.task.paid_functions_options)}
        placeholder="Выберите платные функции для вашего задания"
        label="Платные функции"
        searchable={false}
        clearable={true}
        multi={false}
        />
    )
  }
}
