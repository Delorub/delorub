import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';
import request from 'superagent';

class CityInput extends React.Component {
  getOptions(input, callback) {
    request
      .get('/api/searches/place')
      .query({ query: input, type: 'city' })
      .end((error, response) => (
        callback(null, { options: response.body.places.map(function(e) {
          return {
            value: e.id,
            label: e.name
          }
        }) })
      ))
  }

  render() {
    return (
      <Field
        ref="selectField"
        component={RenderSelect}
        className="dr-task-select"
        loadOptions={::this.getOptions}
        label={this.props.label}
        validate={[required]}
        noResultsText="Ничего не найдено"
        clearable={false}
        {...this.props}
        />
    )
  }
}

CityInput.defaultProps = {
  placeholder: 'Выберите город',
  label: 'Город',
  name: 'place_id',
  searchable: true
}

export default CityInput
