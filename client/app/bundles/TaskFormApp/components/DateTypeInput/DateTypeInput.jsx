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
        name="task[date_type]"
        options={optionsToSelect2(this.props.task.date_type_options)}
        placeholder="Выберите тип сроков"
        label="Сроки"
        searchable={false}
        clearable={false}
        validate={[required]}
        />
    )
  }
}
