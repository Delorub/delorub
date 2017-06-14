import React from 'react';
import RenderSelect2 from 'libs/delorub/components/RenderSelect2'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class ContractInput extends React.Component {
  render() {
    return (
      <Field
        component={RenderSelect2}
        className="dr-task-select"
        name="task[contract_type]"
        data={optionsToSelect2(this.props.task.contract_type_options)}
        options={{
          minimumResultsForSearch: Infinity,
          placeholder: 'Выберите тип работы',
        }}
        label="Заключение договора"
        validate={[required]}
        />
    )
  }
}
