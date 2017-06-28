import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';
import request from 'superagent';

class CityInput extends React.Component {
  renderOption(option) {
		return (
			<span>{option.label}<br /><small>{option.region_name}</small></span>
		);
	}

  getOptions(input, callback) {
    request
      .get('/api/searches/place')
      .query({ query: input, type: 'city' })
      .end((error, response) => (
        callback(null, { options: response.body.places.map(function(e) {
          return {
            value: e.id,
            label: e.name,
            region_name: e.region_name
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
        optionRenderer={::this.renderOption}
        loadOptions={::this.getOptions}
        filterOption={(e) => true}
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
