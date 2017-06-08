import React from 'react';
import { Field } from 'redux-form';

export default class Fields extends React.Component {
  render() {
    return (
      <div>
        <Field component="input" type="hidden" name="create_profile[main_specialization_id]" />
        <Field component="input" type="hidden" name="create_profile[specializations]" />
      </div>
    );
  }
}
