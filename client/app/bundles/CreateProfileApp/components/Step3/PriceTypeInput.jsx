import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import { Field } from 'redux-form';

export default class PriceTypeInput extends React.Component {
  render() {
    return (
      <Field
        component={RenderSelect}
        className="dr-task-select"
        containerClasses="dr-task dr-profile-div"
        name="create_profile[price_type]"
        options={optionsToSelect2(this.props.create_profile.price_type_options)}
        placeholder="Выберите вариант оплаты"
        label="Вариант оплаты"
        validate={[required]}
        />
    )
  }
}
