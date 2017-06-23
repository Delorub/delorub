import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class ContractInput extends React.Component {
  render() {
    return (
      <Field
        component={RenderSelect}
        className="dr-task-select"
        name="task[contract_type]"
        options={optionsToSelect2(this.props.task.contract_type_options)}
        placeholder="Выберите тип работы"
        label="Заключение договора"
        validate={[required]}
        searchable={false}
        clearable={false}
        />
    )
  }
}
