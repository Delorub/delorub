import React from 'react';
import { Field } from 'redux-form';

export default class Fields extends React.Component {
  renderCategories(params) {
    console.log(params)
    return (
      <div>
        {params.input.value.map((category, index) => (
          <input key={index} type="hidden" name={`${params.input.name}[][id]`} value={category} />
        ))}
      </div>
    )
  }

  render() {
    return (
      <div>
        <Field component="input" type="hidden" name="create_profile[main_category_id]" />
        <Field component={this.renderCategories} name="create_profile[categories]" />
        <Field component="input" type="hidden" name="create_profile[temporary_photo_id]" />
        <Field component="input" type="hidden" name="create_profile[about]" />
        <Field component="input" type="hidden" name="create_profile[place_id]" />
        <Field component="input" type="hidden" name="create_profile[notifications_type]" />
        <Field component="input" type="hidden" name="create_profile[paid_functions]" />
      </div>
    );
  }
}
